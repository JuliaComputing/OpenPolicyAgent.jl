using FigCLIGen

const sdir = @__DIR__
const SPEC = joinpath(sdir, "opa.json")
const CLIMODULE = joinpath(sdir, "..", "..", "src", "cli", "cli.jl")

FigCLIGen.generate(SPEC, CLIMODULE)