# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

struct CompileAPIApi <: OpenAPI.APIClientImpl
    client::OpenAPI.Clients.Client
end

"""
The default API base path for APIs in `CompileAPIApi`.
This can be used to construct the `OpenAPI.Clients.Client` instance.
"""
basepath(::Type{ CompileAPIApi }) = "http://localhost"

const _returntypes_post_compile_CompileAPIApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => GetQuery200Response,
    Regex("^" * replace("400", "x"=>".") * "\$") => Response400,
    Regex("^" * replace("500", "x"=>".") * "\$") => Response400,
)

function _oacinternal_post_compile(_api::CompileAPIApi; pretty=nothing, explain=nothing, metrics=nothing, instrument=nothing, request_body=nothing, _mediaType=nothing)
    _ctx = OpenAPI.Clients.Ctx(_api.client, "POST", _returntypes_post_compile_CompileAPIApi, "/v1/compile", [], request_body)
    OpenAPI.Clients.set_param(_ctx.query, "pretty", pretty)  # type Bool
    OpenAPI.Clients.set_param(_ctx.query, "explain", explain)  # type String
    OpenAPI.Clients.set_param(_ctx.query, "metrics", metrics)  # type Bool
    OpenAPI.Clients.set_param(_ctx.query, "instrument", instrument)  # type Bool
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? ["application/json", ] : [_mediaType])
    return _ctx
end

@doc raw"""Compile

This API endpoint allows you to partially evaluate Rego queries and obtain a simplified version of the policy. The example below assumes that OPA has been given the following policy (use `PUT /v1/policies/{path}`):  ```yaml package example allow {   input.subject.clearance_level >= data.reports[_].clearance_level } ``` Compile API **request body** so that it contain the following fields:  | Field | Type | Required | Description | | --- | --- | --- | --- | | `query` | `string` | Yes | The query to partially evaluate and compile. | | `input` | `any` | No | The input document to use during partial evaluation (default: undefined). | | `unknowns` | `array[string]` | No | The terms to treat as unknown during partial evaluation (default: `[\"input\"]`]). |  For example:  ```json {   \"query\": \"data.example.allow == true\",   \"input\": {     \"subject\": {       \"clearance_level\": 4     }   },   \"unknowns\": [     \"data.reports\"     ] } ``` ### Partial evaluation In some cases, the result of partial valuation is a conclusive, unconditional answer. See [the guidance](https://www.openpolicyagent.org/docs/latest/rest-api/#unconditional-results-from-partial-evaluation) for details.

Params:
- pretty::Bool
- explain::String
- metrics::Bool
- instrument::Bool
- request_body::Dict{String, Any}

Return: GetQuery200Response, OpenAPI.Clients.ApiResponse
"""
function post_compile(_api::CompileAPIApi; pretty=nothing, explain=nothing, metrics=nothing, instrument=nothing, request_body=nothing, _mediaType=nothing)
    _ctx = _oacinternal_post_compile(_api; pretty=pretty, explain=explain, metrics=metrics, instrument=instrument, request_body=request_body, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function post_compile(_api::CompileAPIApi, response_stream::Channel; pretty=nothing, explain=nothing, metrics=nothing, instrument=nothing, request_body=nothing, _mediaType=nothing)
    _ctx = _oacinternal_post_compile(_api; pretty=pretty, explain=explain, metrics=metrics, instrument=instrument, request_body=request_body, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

export post_compile
