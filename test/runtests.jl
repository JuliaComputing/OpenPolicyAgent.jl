using OpenPolicyAgent
using OpenPolicyAgent_jll
using OpenAPI
using JSON
using HTTP
using Test
import OpenPolicyAgent: CLI, Client, ASTWalker
import OpenPolicyAgent.ASTWalker: AST, SQL
import OpenPolicyAgent.ASTWalker.AST: ASTVisitor
import OpenPolicyAgent.ASTWalker.SQL: SQLVisitor, SQLCondition, UnconditionalInclude, UnconditionalExclude

include("test_data.jl")
include("test_utils.jl")
include("sql_translate.jl")
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

function test_data_api(openapi_client)
    opa_client = OpenPolicyAgent.Client.DataApi(openapi_client)

    # run only if not windows
    if !Sys.iswindows()
        # TODO: check why this fails on windows
        response, _http_resp = OpenPolicyAgent.Client.get_document(opa_client, policy_path(); pretty=true, provenance=true, explain=true, metrics=true, instrument=true);
        @test response.result == false

        @test query_user(opa_client, "bob") == true
    end

    response, _http_resp = OpenPolicyAgent.Client.create_document(opa_client, "servers", EXAMPLE_QUERY_INPUT; metrics=true)
    @test isa(response, OpenPolicyAgent.Client.CreateDocumentSuccessResponse)
    @test response.metrics["timer_rego_input_parse_ns"] >= 0

    patch_op = OpenPolicyAgent.Client.PatchOperation(; op="add", path="/servers/0/ports/-", value="p4")
    response, _http_resp = OpenPolicyAgent.Client.patch_document(opa_client, "servers", [patch_op])
    @test isa(response, Nothing)

    response, _http_resp = OpenPolicyAgent.Client.get_document(opa_client, "servers")
    @test isa(response, OpenPolicyAgent.Client.GetDocumentSuccessResponse)
    result = response.result
    servers = result["servers"]
    @test isa(servers, Vector)
    @test length(servers) == 2
    @test servers[1]["name"] in ("app", "dev")
    @test servers[2]["name"] in ("app", "dev")
    @test Set(servers[1]["ports"]) == Set(["p1", "p2", "p3", "p4"]) # p4 was added via the patch operation

    response, _http_resp = OpenPolicyAgent.Client.delete_document(opa_client, "servers"; metrics=true)
    @test isa(response, OpenPolicyAgent.Client.DeleteDocumentSuccessResponse)
    @test response.metrics["timer_server_handler_ns"] >= 0
end

function test_config_api(openapi_client)
    opa_client = OpenPolicyAgent.Client.ConfigApi(openapi_client)
    result_dict, _http_resp = OpenPolicyAgent.Client.get_config(opa_client; pretty=true)

    @test isa(result_dict, Dict{String,Any})
    @test haskey(result_dict, "result")

    result = result_dict["result"]
    @test haskey(result, "services") && isa(result["services"], Vector)
    services = result["services"]
    @test length(services) == 1
    @test services[1]["name"] == "BundleServiceAPI"

    @test haskey(result, "bundles") && isa(result["bundles"], Dict)
    bundles = result["bundles"]
    @test Set(keys(bundles)) == Set(["data", "policies"])

    @test haskey(result, "keys") && isa(result["keys"], Dict)
    bundle_keys = result["keys"]
    @test haskey(bundle_keys, "bundle_key")
    @test haskey(bundle_keys["bundle_key"], "algorithm")
    @test bundle_keys["bundle_key"]["algorithm"] == "HS512"
end

function test_status_api(openapi_client)
    opa_client = OpenPolicyAgent.Client.StatusApi(openapi_client)
    result, _http_resp = OpenPolicyAgent.Client.get_status(opa_client; pretty=true)

    # status plugin is not enabled by default
    # https://github.com/open-policy-agent/opa/issues/4297
    @test isa(result, OpenPolicyAgent.Client.ServerErrorResponse)
    @test result.code == "internal_error"
    @test result.message == "status plugin not enabled"
end

function test_health_api(openapi_client)
    opa_client = OpenPolicyAgent.Client.HealthApi(openapi_client)
    result, _http_resp = OpenPolicyAgent.Client.get_health(opa_client; bundles=true, plugins=true)
    @test isa(result, Nothing)
end

function test_policy_api(openapi_client)
    opa_client = OpenPolicyAgent.Client.PolicyApi(openapi_client)
    result, _http_resp = OpenPolicyAgent.Client.get_policies(opa_client; pretty=true)
    @test isa(result, OpenPolicyAgent.Client.GetPolicyListSuccessResponse)
    @test isa(result.result, Vector{OpenPolicyAgent.Client.Policy})
    @test !isempty(result.result)

    policy_id = result.result[1].id
    result, _http_resp = OpenPolicyAgent.Client.get_policy_module(opa_client, policy_id; pretty=true)
    @test isa(result, OpenPolicyAgent.Client.GetPolicyModuleSuccessResponse)
    @test isa(result.result, OpenPolicyAgent.Client.Policy)
    @test result.result.id == policy_id

    example_policy_id = "example1"
    result, _http_resp = OpenPolicyAgent.Client.put_policy_module(opa_client, example_policy_id, EXAMPLE_POLICY; pretty=true, metrics=true)
    @test isa(result, OpenPolicyAgent.Client.PutPolicySuccessResponse)
    @test isa(result.metrics, Dict{String,Any})
    @test result.metrics["timer_rego_module_parse_ns"] >= 0

    result, _http_resp = OpenPolicyAgent.Client.get_policies(opa_client; pretty=true)
    @test isa(result.result, Vector{OpenPolicyAgent.Client.Policy})
    has_example_policy = false
    for policy in result.result
        if policy.id == example_policy_id
            has_example_policy = true
            break
        end
    end
    @test has_example_policy

    result, _http_resp = OpenPolicyAgent.Client.delete_policy_module(opa_client, policy_id; pretty=true)
    @test isa(result, OpenPolicyAgent.Client.ServerErrorResponse)
    @test result.code == "invalid_parameter"

    result, _http_resp = OpenPolicyAgent.Client.delete_policy_module(opa_client, example_policy_id; pretty=true)
    @test isa(result, Nothing)

    result, _http_resp = OpenPolicyAgent.Client.get_policies(opa_client; pretty=true)
    has_example_policy = false
    for policy in result.result
        if policy.id == example_policy_id
            has_example_policy = true
            break
        end
    end
    @test !has_example_policy
end

function test_compile_api(openapi_client)
    policy_client = OpenPolicyAgent.Client.PolicyApi(openapi_client)
    compile_client = OpenPolicyAgent.Client.CompileApi(openapi_client)

    for partial_compile_case in PARTIAL_COMPILE_CASES
        # create the test policy to evaluate the query on
        result, _http_resp = OpenPolicyAgent.Client.put_policy_module(policy_client, "example", partial_compile_case.policy)
        @test isa(result, OpenPolicyAgent.Client.PutPolicySuccessResponse)

        try
            partial_query_schema = OpenPolicyAgent.Client.PartialQuerySchema(;
                query = partial_compile_case.query,
                input = partial_compile_case.input,
                options = partial_compile_case.options,
                unknowns = partial_compile_case.unknowns,
            )
            response, _http_resp = OpenPolicyAgent.Client.post_compile(compile_client;
                partial_query_schema = partial_query_schema,
                pretty=true,
                explain=true,
                metrics=true,
                instrument=true
            )
            @test isa(response, OpenPolicyAgent.Client.CompileSuccessResponse)
            @test !isnothing(response.metrics) && (response.metrics["timer_rego_partial_eval_ns"] >= 0)

            result = response.result
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
            result, _http_resp = OpenPolicyAgent.Client.delete_policy_module(policy_client, "example"; pretty=true)
            @test isa(result, Nothing)
        end
    end
end

function test_query_api(openapi_client)
    query_client = OpenPolicyAgent.Client.QueryApi(openapi_client)
    response, _http_resp = OpenPolicyAgent.Client.query_get(query_client, EXAMPLE_QUERY; pretty=true, explain=true, metrics=true)

    @test isa(response, OpenPolicyAgent.Client.GetDocumentSuccessResponse)
    metrics = response.metrics
    @test isa(metrics, Dict{String,Any})
    @test metrics["timer_rego_query_eval_ns"] >= 0

    query_param = OpenPolicyAgent.Client.QueryParameterPost(; query=EXAMPLE_QUERY, input=EXAMPLE_QUERY_INPUT)
    response, _http_resp = OpenPolicyAgent.Client.query_post(query_client, query_param; pretty=true, explain=true, metrics=true)

    @test isa(response, OpenPolicyAgent.Client.GetDocumentSuccessResponse)
    metrics = response.metrics
    @test isa(metrics, Dict{String,Any})
    @test metrics["timer_rego_query_eval_ns"] >= 0
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
                    openapi_client = OpenAPI.Clients.Client("http://localhost:8181"; escape_path_params=false)
                    @testset "Data API" begin
                        test_data_api(openapi_client)
                    end
                    @testset "Config API" begin
                        test_config_api(openapi_client)
                    end
                    @testset "Status API" begin
                        test_status_api(openapi_client)
                    end
                    @testset "Health API" begin
                        test_health_api(openapi_client)
                    end
                    @testset "Policy API" begin
                        test_policy_api(openapi_client)
                    end
                    @testset "Compile API" begin
                        test_compile_api(openapi_client)
                    end
                    @testset "Query API" begin
                        test_query_api(openapi_client)
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
                    openapi_client = OpenAPI.Clients.Client("http://localhost:8181"; escape_path_params=false)
                    @testset "Status API" begin
                        test_status_api(openapi_client)
                    end
                    @testset "Health API" begin
                        test_health_api(openapi_client)
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

@testset "OpenPolicyAgent" begin
    runtests()
end