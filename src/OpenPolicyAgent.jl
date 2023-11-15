module OpenPolicyAgent

include("cli/cli.jl")
include("client/src/Client.jl")
include("server/server.jl")
include("utils/ast_walker.jl")

end # module OpenPolicyAgent