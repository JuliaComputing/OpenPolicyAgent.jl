using OpenPolicyAgent
using OpenPolicyAgent_jll
using HTTP
using Test
import OpenPolicyAgent: CLI, Client, ASTWalker
import OpenPolicyAgent.ASTWalker: AST, SQL
import OpenPolicyAgent.ASTWalker.AST: ASTVisitor
import OpenPolicyAgent.ASTWalker.SQL: SQLVisitor, SQLCondition, UnconditionalInclude, UnconditionalExclude

include("test_data.jl")
include("test_utils.jl")
include("sql_translate.jl")
import .OPASQL
import .OPASQL: translate

# Check version and help output
function test_version_help()
    iob_stdout = IOBuffer()
    iob_stderr = IOBuffer()
    pipelineopts = CLI.OptsType(:stdout => iob_stdout, :stderr => iob_stderr)
    cmd = OpenPolicyAgent.CLI.CommandLine(OpenPolicyAgent_jll.opa; pipelineopts=pipelineopts)
    CLI.version(cmd)
    if Sys.iswindows()
        sleep(10) # Windows is slow to flush the buffers
    end
    output = string(String(take!(iob_stdout)), String(take!(iob_stderr)))
    @test occursin(r"Version: \d+\.\d+\.\d+", output)

    iob_stdout = IOBuffer()
    iob_stderr = IOBuffer()
    pipelineopts = CLI.OptsType(:stdout => iob_stdout, :stderr => iob_stderr)
    cmd = OpenPolicyAgent.CLI.CommandLine(OpenPolicyAgent_jll.opa; pipelineopts=pipelineopts)
    CLI.help(cmd)
    if Sys.iswindows()
        sleep(10) # Windows is slow to flush the buffers
    end
    output = string(String(take!(iob_stdout)), String(take!(iob_stderr)))
    if Sys.iswindows()
        @test occursin(r"Usage:\s+.*opa.exe \[command\]", output)
    else
        @test occursin(r"Usage:\s+.*opa \[command\]", output)
    end
end

# Runs `f`, which is expected to fail with a documented error status, and returns
# the `ApiError` so the caller can inspect the status and the decoded body.
function api_error(f)
    try
        f()
    catch ex
        isa(ex, Client.ApiError) && return ex
        rethrow()
    end
    error("expected an ApiError")
end

const EXPLAIN_FULL = Client.ExplainMode("full")

function test_data_api(client)
    # run only if not windows
    if !Sys.iswindows()
        # TODO: check why this fails on windows
        response = Client.getdocument(policy_path(); pretty=true, provenance=true, explain=EXPLAIN_FULL, metrics=true, instrument=true, client)
        @test isa(response, Client.GetDocumentSuccessResponse)
        @test response.result == false

        @test query_user(client, "bob") == true
    end

    response = Client.createdocument("servers", EXAMPLE_QUERY_INPUT; metrics=true, client)
    @test isa(response, Client.CreateDocumentSuccessResponse)
    @test response.metrics.additional_properties["timer_rego_input_parse_ns"] >= 0

    patch_op = Client.PatchOperation(; op=Client.PatchOperationOp("add"), path="/servers/0/ports/-", value="p4")
    response = Client.patchdocument("servers", [patch_op]; client)
    @test isa(response, Nothing)

    response = Client.getdocument("servers"; client)
    @test isa(response, Client.GetDocumentSuccessResponse)
    result = response.result
    @test isa(result, AbstractDict)
    servers = result["servers"]
    @test isa(servers, Vector)
    @test length(servers) == 2
    @test servers[1]["name"] in ("app", "dev")
    @test servers[2]["name"] in ("app", "dev")
    @test Set(servers[1]["ports"]) == Set(["p1", "p2", "p3", "p4"]) # p4 was added via the patch operation

    # the full response is available with `with_http_info`
    http_resp = Client.getdocument("servers"; with_http_info=true, client)
    @test isa(http_resp, Client.ApiResponse)
    @test http_resp.status == 200
    @test isa(http_resp.body, Client.GetDocumentSuccessResponse)

    response = Client.deletedocument("servers"; metrics=true, client)
    @test isa(response, Client.DeleteDocumentSuccessResponse)
    @test response.metrics.additional_properties["timer_server_handler_ns"] >= 0
end

function test_config_api(client)
    config = Client.getconfig(; pretty=true, client)
    @test isa(config, Client.ActiveConfiguration)

    result_dict = config.additional_properties
    @test haskey(result_dict, "result")

    result = result_dict["result"]
    @test haskey(result, "services") && isa(result["services"], Vector)
    services = result["services"]
    @test length(services) == 1
    @test services[1]["name"] == "BundleServiceAPI"

    @test haskey(result, "bundles") && isa(result["bundles"], AbstractDict)
    bundles = result["bundles"]
    @test Set(keys(bundles)) == Set(["data", "policies"])

    @test haskey(result, "keys") && isa(result["keys"], AbstractDict)
    bundle_keys = result["keys"]
    @test haskey(bundle_keys, "bundle_key")
    @test haskey(bundle_keys["bundle_key"], "algorithm")
    @test bundle_keys["bundle_key"]["algorithm"] == "HS512"
end

function test_status_api(client)
    # status plugin is not enabled by default
    # https://github.com/open-policy-agent/opa/issues/4297
    # A documented error status is raised as an `ApiError` carrying the decoded body.
    ex = api_error(() -> Client.getstatus(; pretty=true, client))
    @test ex.status == 500
    @test isa(ex.decoded, Client.ServerErrorResponse)
    @test ex.decoded.code == "internal_error"
    @test ex.decoded.message == "status plugin not enabled"
end

function test_health_api(client)
    result = Client.gethealth(; bundles=true, plugins=true, client)
    @test isa(result, Client.HealthyResponse)
end

function test_policy_api(client)
    result = Client.getpolicies(; pretty=true, client)
    @test isa(result, Client.GetPolicyListSuccessResponse)
    @test isa(result.result, Vector{Client.Policy})
    @test !isempty(result.result)

    policy_id = result.result[1].id
    result = Client.getpolicymodule(policy_id; pretty=true, client)
    @test isa(result, Client.GetPolicyModuleSuccessResponse)
    @test isa(result.result, Client.Policy)
    @test result.result.id == policy_id

    example_policy_id = "example1"
    result = Client.putpolicymodule(example_policy_id, EXAMPLE_POLICY; pretty=true, metrics=true, client)
    @test isa(result, Client.PutPolicySuccessResponse)
    @test isa(result.metrics, Client.PutPolicySuccessResponseMetrics)
    @test result.metrics.additional_properties["timer_rego_module_parse_ns"] >= 0

    result = Client.getpolicies(; pretty=true, client)
    @test isa(result.result, Vector{Client.Policy})
    @test any(policy -> policy.id == example_policy_id, result.result)

    # policies that came from a bundle cannot be deleted through the API
    ex = api_error(() -> Client.deletepolicymodule(policy_id; pretty=true, client))
    @test ex.status == 400
    @test isa(ex.decoded, Client.ServerErrorResponse)
    @test ex.decoded.code == "invalid_parameter"

    result = Client.deletepolicymodule(example_policy_id; pretty=true, client)
    @test isa(result, Client.DeletePolicySuccessResponse)

    result = Client.getpolicies(; pretty=true, client)
    @test !any(policy -> policy.id == example_policy_id, result.result)
end

function test_compile_api(client)
    for partial_compile_case in PARTIAL_COMPILE_CASES
        # create the test policy to evaluate the query on
        result = Client.putpolicymodule("example", partial_compile_case.policy; client)
        @test isa(result, Client.PutPolicySuccessResponse)

        try
            partial_query_schema = Client.PartialQuerySchema(;
                query = partial_compile_case.query,
                input = partial_compile_case.input,
                options = partial_compile_case.options,
                unknowns = partial_compile_case.unknowns,
            )
            response = Client.postcompile(;
                body = partial_query_schema,
                pretty = true,
                explain = EXPLAIN_FULL,
                metrics = true,
                instrument = true,
                client,
            )
            @test isa(response, Client.CompileSuccessResponse)
            @test isa(response.metrics, Client.CompileSuccessResponseMetrics)
            @test response.metrics.additional_properties["timer_rego_partial_eval_ns"] >= 0

            result = response.result
            @test isa(result, AbstractDict)
            if partial_compile_case.sql !== "false"
                @test !isnothing(result["queries"]) && length(result["queries"]) >= 1
            end

            sql = translate(result)
            @test sql == partial_compile_case.sql

            ast = OpenPolicyAgent.ASTWalker.walk(ASTVisitor(), result)
            sqlvisitor = SQLVisitor(SCHEMA_MAP, TABLE_MAP)
            sqlcondition = OpenPolicyAgent.ASTWalker.walk(sqlvisitor, ast)
            if partial_compile_case.sql == "false"
                @test isa(sqlcondition, UnconditionalExclude)
            elseif isempty(partial_compile_case.sql)
                @test isa(sqlcondition, UnconditionalInclude)
            else
                @test isa(sqlcondition, SQLCondition)
                @test sqlcondition.sql == partial_compile_case.sql
            end
        finally
            # delete the test policy
            result = Client.deletepolicymodule("example"; pretty=true, client)
            @test isa(result, Client.DeletePolicySuccessResponse)
        end
    end
end

function test_query_api(client)
    response = Client.queryget(; q=EXAMPLE_QUERY, pretty=true, explain=EXPLAIN_FULL, metrics=true, client)

    @test isa(response, Client.GetDocumentSuccessResponse)
    metrics = response.metrics
    @test isa(metrics, Client.GetDocumentSuccessResponseMetrics)
    @test metrics.additional_properties["timer_rego_query_eval_ns"] >= 0

    query_param = Client.QueryParameterPost(; query=EXAMPLE_QUERY, input=EXAMPLE_QUERY_INPUT)
    response = Client.querypost(query_param; pretty=true, explain=EXPLAIN_FULL, metrics=true, client)

    @test isa(response, Client.GetDocumentSuccessResponse)
    metrics = response.metrics
    @test isa(metrics, Client.GetDocumentSuccessResponseMetrics)
    @test metrics.additional_properties["timer_rego_query_eval_ns"] >= 0
    result = response.result
    @test isa(result, Vector)
    @test length(result) == 2
    @test result[1]["name"] in ("app", "dev")
    @test result[2]["name"] in ("app", "dev")
    @test result[1]["i"] in (0, 1)
    @test result[2]["i"] in (0, 1)
end

function runtests()
    mktempdir() do testdir
        bundle_location = joinpath(testdir, "bundle")
        opa_server_location = joinpath(testdir, "opa_server")
        mkpath(bundle_location)
        mkpath(opa_server_location)
        cp(opa_config_template, joinpath(opa_server_location, "config.yaml"))

        # Check version and help output
        @info("Checking OPA version")
        test_version_help()

        # Prepare the bundles
        @info("Preparing signed bundles at: $(bundle_location)")
        prepare_bundle(bundle_location)
        @test isfile(joinpath(bundle_location, "data.tar.gz"))
        @test isfile(joinpath(bundle_location, "policies.tar.gz"))

        @info("Starting bundle server")
        bundle_server = start_bundle_server(bundle_location)
        try
            cd(opa_server_location) do
                # Starting OPA server at the server location (localizes all temporary files to this location)
                @info("Starting OPA server")
                opa_server = start_opa_server(opa_server_location)
                
                try
                    # Wait for servers to start
                    sleep(15)
                    @test !(opa_server.stopped[])
                    @test !isnothing(opa_server.monitor_task[])
                    @test !istaskdone(opa_server.monitor_task[])

                    # create the client
                    client = Client.Client("http://localhost:8181")
                    @testset "Data API" begin
                        test_data_api(client)
                    end
                    @testset "Config API" begin
                        test_config_api(client)
                    end
                    @testset "Status API" begin
                        test_status_api(client)
                    end
                    @testset "Health API" begin
                        test_health_api(client)
                    end
                    @testset "Policy API" begin
                        test_policy_api(client)
                    end
                    @testset "Compile API" begin
                        test_compile_api(client)
                    end
                    @testset "Query API" begin
                        test_query_api(client)
                    end
                finally
                    @info("Stopping OPA server")
                    OpenPolicyAgent.Server.stop!(opa_server)
                end
                sleep(5)
                @test opa_server.stopped[]

                # run again withoug changing the directory
                @info("Starting OPA server without changing the directory")
                opa_server = start_opa_server(opa_server_location; change_dir=false)
                try
                    # Wait for servers to start
                    sleep(15)
                    @test !(opa_server.stopped[])
                    @test !isnothing(opa_server.monitor_task[])
                    @test !istaskdone(opa_server.monitor_task[])

                    # create the client
                    client = Client.Client("http://localhost:8181")
                    @testset "Status API" begin
                        test_status_api(client)
                    end
                    @testset "Health API" begin
                        test_health_api(client)
                    end
                finally
                    @info("Stopping OPA server")
                    OpenPolicyAgent.Server.stop!(opa_server)
                end
                sleep(5)
                @test opa_server.stopped[]
            end
        finally
            @info("Stopping bundle server")
            close(bundle_server)
        end
    end
end

function test_sql_string_escaping()
    schema_map = Dict("data" => "public")
    table_map = Dict("reports" => "juliahub_reports")

    # Helper to translate a single scalar value to its SQL literal form.
    function scalar_to_sql(value)
        visitor = SQLVisitor(schema_map, table_map)
        SQL.visit(visitor, AST.OPAScalarValue(value))
        return pop!(visitor.result_stack)
    end

    # Benign strings are still single-quoted as before.
    @test scalar_to_sql("bob") == "'bob'"
    @test scalar_to_sql("public") == "'public'"

    # Embedded single quotes must be doubled so they cannot break out of the
    # literal and inject SQL.
    @test scalar_to_sql("O'Brien") == "'O''Brien'"
    @test scalar_to_sql(raw"bob' or '1'='1") == "'bob'' or ''1''=''1'"
    @test scalar_to_sql("'; DROP TABLE juliahub_reports; --") ==
          "'''; DROP TABLE juliahub_reports; --'"

    # Non-string scalars are unaffected.
    @test scalar_to_sql(Int64(4)) == "4"
    @test scalar_to_sql(true) == "true"
    @test scalar_to_sql(false) == "false"
    @test scalar_to_sql(nothing) == "null"

    # The escaped literal must stay a single, balanced SQL string literal:
    # outer quotes plus an even number of interior quote characters.
    for malicious in (raw"bob' or '1'='1", "O'Brien", "'; DROP TABLE x; --", "a''b")
        sql = scalar_to_sql(malicious)
        @test startswith(sql, "'") && endswith(sql, "'")
        @test iseven(count(==('\''), sql))
    end

    # The standalone reference translator (test/sql_translate.jl) must escape
    # identically, since it is used as the expected-output oracle.
    @test OPASQL.to_sql(OPASQL.OPAScalarValue(raw"bob' or '1'='1")) ==
          "'bob'' or ''1''=''1'"
end

@testset "OpenPolicyAgent" begin
    @testset "SQL string escaping" begin
        test_sql_string_escaping()
    end
    runtests()
end
