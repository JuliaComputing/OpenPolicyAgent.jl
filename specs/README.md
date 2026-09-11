# OPA Client and CLI Code Generation

OPA OpenAPI client and command line interface code is mostly generated from specifications. With OPA having a sizeable REST API and command line interface, this is quite helpful.

## CLI

The CLI interface is generated using [FigCLIGen.jl](https://github.com/tanmaykm/FigCLIGen.jl), using a [specification](cli/opa.json) derived from the OPA fig specification. To regenerate, install the `FigCLIGen` package and run `cli/generate.jl`.

```bash
$ julia cli/generate.jl
```

## OpenAPI Client

The OpenAPI client (`src/client/OPAClient.jl`) is generated using [OpenAPI.jl](https://github.com/JuliaComputing/OpenAPI.jl), using the OpenAPI [specification](openapi/open_policy_agent.yaml) included in this repo. To regenerate, run `openapi/generate.jl`; it uses the pinned generator version in `openapi/Project.toml`.

```bash
$ julia openapi/generate.jl
```

Generation is strict: a specification defect fails the run instead of degrading a generated type. The generated file is committed, so a change to the specification or to the pinned generator version shows up as a diff in `src/client/OPAClient.jl`.
