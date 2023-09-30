# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

struct HealthAPIApi <: OpenAPI.APIClientImpl
    client::OpenAPI.Clients.Client
end

"""
The default API base path for APIs in `HealthAPIApi`.
This can be used to construct the `OpenAPI.Clients.Client` instance.
"""
basepath(::Type{ HealthAPIApi }) = "http://localhost:8181"

const _returntypes_get_health_HealthAPIApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => Nothing,
    Regex("^" * replace("500", "x"=>".") * "\$") => Nothing,
)

function _oacinternal_get_health(_api::HealthAPIApi; bundles=nothing, plugins=nothing, _mediaType=nothing)
    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_get_health_HealthAPIApi, "/health", [])
    OpenAPI.Clients.set_param(_ctx.query, "bundles", bundles)  # type Bool
    OpenAPI.Clients.set_param(_ctx.query, "plugins", plugins)  # type Bool
    OpenAPI.Clients.set_header_accept(_ctx, [])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Health

This API endpoint verifies that the server is operational.  The response from the server is either 200 or 500: - **200** - OPA service is healthy. If `bundles` is true, then all configured bundles have been activated. If `plugins` is true, then all plugins are in an 'OK' state. - **500** - OPA service is *not* healthy. If `bundles` is true, at least one of configured bundles has not yet been activated. If `plugins` is true, at least one plugins is in a 'not OK' state.  --- **Note** This check is only for initial bundle activation. Subsequent downloads will not affect the health check.  Use the **status** endpoint (in the (management API)[management.html]) for more fine-grained bundle status monitoring.  ---

Params:
- bundles::Bool
- plugins::Bool

Return: Nothing, OpenAPI.Clients.ApiResponse
"""
function get_health(_api::HealthAPIApi; bundles=nothing, plugins=nothing, _mediaType=nothing)
    _ctx = _oacinternal_get_health(_api; bundles=bundles, plugins=plugins, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function get_health(_api::HealthAPIApi, response_stream::Channel; bundles=nothing, plugins=nothing, _mediaType=nothing)
    _ctx = _oacinternal_get_health(_api; bundles=bundles, plugins=plugins, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

export get_health
