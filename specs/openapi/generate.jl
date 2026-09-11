#!/usr/bin/env julia
#
# Regenerates the OPA REST API client (src/client/OPAClient.jl) from
# open_policy_agent.yaml using OpenAPI.jl's native generator.
#
#   julia specs/openapi/generate.jl
#
# The script activates and instantiates the pinned environment in this
# directory (see Project.toml), so no manual setup is needed beyond registry
# access. Planning runs in strict mode: a specification defect fails the run
# instead of silently degrading a generated type.
#
# The module is named `OPAClient` rather than `Client` because it defines the
# `Client(server; kwargs...)` constructor, and a module cannot share a name
# with one of its own bindings. `OpenPolicyAgent.Client` is an alias of it.

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

using OpenAPI

const SPEC = joinpath(@__DIR__, "open_policy_agent.yaml")
const DEST = normpath(joinpath(@__DIR__, "..", "..", "src", "client", "OPAClient.jl"))

plan = OpenAPI.plan(SPEC; name = "OPAClient", strict = true)
mkpath(dirname(DEST))
OpenAPI.client(plan; path = DEST)
@info "generated" DEST
