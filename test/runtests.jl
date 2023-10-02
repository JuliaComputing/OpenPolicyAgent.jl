using OpenPolicyAgent
using OpenAPI
using JSON
using HTTP
using Test
import OpenPolicyAgent: CLI, Client

const opa_config_template = joinpath(@__DIR__, "conf", "config.yaml")
const bundle_root = joinpath(@__DIR__, "bundle_root")
const data_bundle_root = joinpath(bundle_root, "data_bundle")
const policies_bundle_root = joinpath(bundle_root, "policies_bundle")
const bundle_args = Dict(
    :bundle => true,
    :signing_alg => "HS512",
    :signing_key => "secret",
)

# Prepare the bundles
function prepare_bundle(bundle_location::String)
    signed_bundle_file = joinpath(bundle_location, "data.tar.gz")
    run(`rm -f $signed_bundle_file`)
    CLI.build(OpenPolicyAgent.CLI.CommandLine(; cmdopts=Dict(:dir => data_bundle_root)),
        ".";
        output=signed_bundle_file,
        bundle_args...
    )

    signed_bundle_file = joinpath(bundle_location, "policies.tar.gz")
    run(`rm -f $signed_bundle_file`)
    CLI.build(OpenPolicyAgent.CLI.CommandLine(; cmdopts=Dict(:dir => policies_bundle_root)),
        ".";
        output=signed_bundle_file,
        bundle_args...
    )
end

function file_response(path)
    open(path, "r") do io
        return HTTP.Response(200, readavailable(io))
    end
end

# Start a bundle server
function start_bundle_server(root_path)
    # start a HTTP.jl server serving at root_path
    # and serve only two files policies.tar.gz and data.tar.gz
    server = HTTP.serve!("127.0.0.1", 8080) do req::HTTP.Request
        @info("request", target=req.target, method=req.method)
        if req.method == "GET" && req.target == "/data.tar.gz"
            return file_response(joinpath(root_path, "data.tar.gz"))
        elseif req.method == "GET" && req.target == "/policies.tar.gz"
            return file_response(joinpath(root_path, "policies.tar.gz"))
        else
            return HTTP.Response(404)
        end
    end

    return server
end

function start_opa_server(root_path)
    opa_server = OpenPolicyAgent.Server.MonitoredOPAServer(
        joinpath(root_path, "config.yaml"),
        stdout = joinpath(root_path, "server.stdout"),
        stderr = joinpath(root_path, "server.stderr"),
    )
    OpenPolicyAgent.Server.start!(opa_server)
    return opa_server
end

function policy_path()
    policy_package = "policies/server/rest"
    rule_name = "allowed"
    return joinpath(policy_package, rule_name)
end

function query_user(opa_client, username)
    request_body = Dict{String,Any}("input" => Dict{String,Any}("name" => username))
    result, http_resp = OpenPolicyAgent.Client.get_document_with_path(opa_client, policy_path(), request_body; pretty=true, provenance=true, explain=true, metrics=true, instrument=true);
    return result.result
end

function test_data_api(openapi_client)
    opa_client = OpenPolicyAgent.Client.DataAPIApi(openapi_client)
   
    result, _http_resp = OpenPolicyAgent.Client.get_document(opa_client, policy_path(); pretty=true, provenance=true, explain=true, metrics=true, instrument=true);
    @info("Decision: $(result.result)")
    @test result.result == false

    @test query_user(opa_client, "bob") == true
end

function runtests()
    mktempdir() do testdir
        bundle_location = joinpath(testdir, "bundle")
        opa_server_location = joinpath(testdir, "opa_server")
        mkpath(bundle_location)
        mkpath(opa_server_location)
        cp(opa_config_template, joinpath(opa_server_location, "config.yaml"))

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
                    test_data_api(openapi_client)
                finally
                    @info("Stopping OPA server")
                    OpenPolicyAgent.Server.stop!(opa_server)
                end
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