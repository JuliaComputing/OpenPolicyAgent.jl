# OPA Client and CLI Code Generation

OPA OpenAPI client and command line interface code is mostly generated from specifications. With OPA having a sizeable REST API and command line interface, this is quite helpful.

## CLI

The CLI interface is generated using [FigCLIGen.j;](https://github.com/tanmaykm/FigCLIGen.jl), using a [specification](cli/opa.json) derived from the OPA fig specification. To regenerate, install the `FigCLIGen` package and run `cli/generate.jl`.

```bash
$ julia cli/generate.jl
```

## OpenAPI Client

The OpenAPI client is generated using [openapi-generator](https://github.com/OpenAPITools/openapi-generator), using the OpenAPI [specification](openapi/open_policy_agent.yaml) included in this repo. To regenerate, install `openapi-generator` and run `openapi/generate.sh`.

```bash
$ openapi/generate.sh
```
