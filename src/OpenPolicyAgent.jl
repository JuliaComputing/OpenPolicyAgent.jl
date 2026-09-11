module OpenPolicyAgent

include("cli/cli.jl")
include("client/OPAClient.jl")
include("server/server.jl")
include("utils/ast_walker.jl")

"""
    OpenPolicyAgent.Client

Client for the OPA REST API, generated from `specs/openapi/open_policy_agent.yaml`
by OpenAPI.jl (see `specs/openapi/generate.jl`).

`Client` is an alias of the generated module `OPAClient`. The generated module
cannot itself be named `Client` because it defines the `Client(server; kwargs...)`
constructor, and a module cannot share a name with one of its own bindings.

```julia
client = OpenPolicyAgent.Client.Client("http://localhost:8181")
response = OpenPolicyAgent.Client.getdocument("policies/server/rest/allowed"; client)
response.result
```
"""
const Client = OPAClient

end # module OpenPolicyAgent
