# Prepare the bundles
function prepare_bundle(bundle_location::String)
    signed_bundle_file = joinpath(bundle_location, "data.tar.gz")
    run(`rm -f $signed_bundle_file`)
    CLI.build(OpenPolicyAgent.CLI.CommandLine(; exec=OpenPolicyAgent_jll.opa, cmdopts=Dict(:dir => data_bundle_root)),
        ".";
        output=signed_bundle_file,
        bundle_args...
    )

    signed_bundle_file = joinpath(bundle_location, "policies.tar.gz")
    run(`rm -f $signed_bundle_file`)
    CLI.build(OpenPolicyAgent.CLI.CommandLine(; exec=OpenPolicyAgent_jll.opa, cmdopts=Dict(:dir => policies_bundle_root)),
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

function start_opa_server(root_path; change_dir::Bool=true)
    if change_dir
        opa_server = OpenPolicyAgent.Server.MonitoredOPAServer(
            joinpath(root_path, "config.yaml");
            stdout = joinpath(root_path, "server.stdout"),
            stderr = joinpath(root_path, "server.stderr"),
            cmdline = OpenPolicyAgent.CLI.CommandLine(; exec=OpenPolicyAgent_jll.opa, cmdopts=Dict(:dir => root_path)),
        )
    else
        opa_server = OpenPolicyAgent.Server.MonitoredOPAServer(
            joinpath(root_path, "config.yaml");
            stdout = joinpath(root_path, "server.stdout"),
            stderr = joinpath(root_path, "server.stderr"),
            cmdline = OpenPolicyAgent.CLI.CommandLine(; exec=OpenPolicyAgent_jll.opa),
        )
    end
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
    response, http_resp = OpenPolicyAgent.Client.get_document_with_path(opa_client, policy_path(), request_body; pretty=true, provenance=true, explain=true, metrics=true, instrument=true);
    return response.result
end
