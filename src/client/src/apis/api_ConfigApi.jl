# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

struct ConfigApi <: OpenAPI.APIClientImpl
    client::OpenAPI.Clients.Client
end

"""
The default API base path for APIs in `ConfigApi`.
This can be used to construct the `OpenAPI.Clients.Client` instance.
"""
basepath(::Type{ ConfigApi }) = "http://localhost:8181"

const _returntypes_get_config_ConfigApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => Dict{String, Any},
    Regex("^" * replace("500", "x"=>".") * "\$") => ServerErrorResponse,
)

function _oacinternal_get_config(_api::ConfigApi; pretty=nothing, _mediaType=nothing)
    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_get_config_ConfigApi, "/v1/config", [])
    OpenAPI.Clients.set_param(_ctx.query, "pretty", pretty)  # type Bool
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Get configurations

The /config API endpoint returns OPA's active configuration. When the discovery feature is enabled, this API can be used to fetch the discovered configuration in the last evaluated discovery bundle. The credentials field in the Services configuration and the private_key and key fields in the Keys configuration will be omitted from the API response.

Params:
- pretty::Bool

Return: Dict{String, Any}, OpenAPI.Clients.ApiResponse
"""
function get_config(_api::ConfigApi; pretty=nothing, _mediaType=nothing)
    _ctx = _oacinternal_get_config(_api; pretty=pretty, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function get_config(_api::ConfigApi, response_stream::Channel; pretty=nothing, _mediaType=nothing)
    _ctx = _oacinternal_get_config(_api; pretty=pretty, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

export get_config
