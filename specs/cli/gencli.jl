using FigCLIGen

const sdir = @__DIR__
const SPEC = joinpath(sdir, "opa.json")
const CLIMODULE = joinpath(sdir, "..", "..", "src", "cli", "cli.jl")

const custom_include = """
using OpenPolicyAgent_jll

\"\"\"
CommandLine execution context.

`exec`: a no argument function that provides the base command to execute in a julia `do` block.
`cmdopts`: keyword arguments that should be used to further customize the `Cmd` creation
`pipelineopts`: keyword arguments that should be used to further customize the `pipeline` creation
\"\"\"
Base.@kwdef struct CommandLine
    exec::Base.Function = OpenPolicyAgent_jll.opa
    cmdopts::OptsType = OptsType()
    pipelineopts::OptsType = OptsType()
    runopts::OptsType = OptsType()
end
"""

FigCLIGen.generate(SPEC, CLIMODULE; custom_include=custom_include, ignore_base_command=true)
