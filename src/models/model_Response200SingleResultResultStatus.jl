# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""response200SingleResult_result_status
Status

    Response200SingleResultResultStatus(;
        service=nothing,
    )

    - service::String : Service
"""
Base.@kwdef mutable struct Response200SingleResultResultStatus <: OpenAPI.APIModel
    service::Union{Nothing, String} = nothing

    function Response200SingleResultResultStatus(service, )
        OpenAPI.validate_property(Response200SingleResultResultStatus, Symbol("service"), service)
        return new(service, )
    end
end # type Response200SingleResultResultStatus

const _property_types_Response200SingleResultResultStatus = Dict{Symbol,String}(Symbol("service")=>"String", )
OpenAPI.property_type(::Type{ Response200SingleResultResultStatus }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_Response200SingleResultResultStatus[name]))}

function check_required(o::Response200SingleResultResultStatus)
    true
end

function OpenAPI.validate_property(::Type{ Response200SingleResultResultStatus }, name::Symbol, val)
    if name === Symbol("service")
        OpenAPI.validate_param(name, "Response200SingleResultResultStatus", :minLength, val, 1)
    end
end
