# OpenPolicyAgent.jl

# OPA Command Line

The OPA command line is made available in the `OpenPolicyAgent.CLI` module. To use, import the module. E.g.:

```julia
julia> using OpenPolicyAgent

julia> import OpenPolicyAgent: CLI

julia> ctx = CLI.CommandLine();

julia> CLI.opa(ctx; help=true);
An open source project to policy-enable your service.

Usage:
  opa [command]

Available Commands:
  bench        Benchmark a Rego query
  build        Build an OPA bundle
  capabilities Print the capabilities of OPA
  check        Check Rego source files
  completion   Generate the autocompletion script for the specified shell
  deps         Analyze Rego query dependencies
  eval         Evaluate a Rego query
  exec         Execute against input files
  fmt          Format Rego source files
  help         Help about any command
  inspect      Inspect OPA bundle(s)
  parse        Parse Rego source file
  run          Start OPA in interactive or server mode
  sign         Generate an OPA bundle signature
  test         Execute Rego test cases
  version      Print the version of OPA

Flags:
  -h, --help   help for opa

Use "opa [command] --help" for more information about a command.
```

# OPA Server

The `OpenPolicyAgent.Server` module includes methods to help start the OPA server,
monitor it for failures, and restart when required.

```julia
function start_opa_server(root_path)
    opa_server = OpenPolicyAgent.Server.MonitoredOPAServer(
        joinpath(root_path, "config.yaml"),
        stdout = joinpath(root_path, "server.stdout"),
        stderr = joinpath(root_path, "server.stderr"),
    )
    OpenPolicyAgent.Server.start!(opa_server)
    return opa_server
end

start_opa_server("/tmp/opaserver")
```

# OPA Client

OPA exposes domain-agnostic APIs that your service can call to manage and enforce policies. Read this page if you want to integrate an application, service, or tool with OPA. The REST APIs are grouped into the following categories:

- **Policy API** - manage policy loaded into the OPA instance.
- **Data API** - evaluate rules and retrieve data.
- **Query API** - execute adhoc queries.
- **Compile API** - access Rego’s Partial Evaluation functionality.
- **Health API** - access instance operational health information.
- **Config API** - view instance configuration.
- **Status API** - view instance status state.

The `OpenPolicyAgent.Client` module includes methods to help interact with the OPA server using the OpenAPI client.

```julia
opa_client = OpenPolicyAgent.Client.DataAPIApi(openapi_client)

response, _http_resp = OpenPolicyAgent.Client.get_document(
    opa_client,
    "policies/server/rest/allowed"
);
@test response.result == false
```

OpenAPI [API Documents](src/client/README.md) give more details on the API methods.
