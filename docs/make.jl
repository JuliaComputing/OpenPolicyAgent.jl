import Pkg
Pkg.add("Documenter")

using Documenter
using OpenPolicyAgent

makedocs(
    sitename = "OpenPolicyAgent.jl",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    pages = [
        "Home" => "index.md",
        "Client" => "client.md",
        "Server" => "server.md",
        "Command Line" => "commandline.md",
    ],
)

deploydocs(
    repo = "github.com/JuliaComputing/OpenPolicyAgent.jl.git",
    push_preview = true,
)
