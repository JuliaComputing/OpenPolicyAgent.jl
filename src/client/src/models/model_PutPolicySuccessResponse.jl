# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""putPolicySuccessResponse

    PutPolicySuccessResponse(;
        metrics=nothing,
    )

    - metrics::Dict{String, Any}
"""
Base.@kwdef mutable struct PutPolicySuccessResponse <: OpenAPI.APIModel
    metrics::Union{Nothing, Dict{String, Any}} = nothing

    function PutPolicySuccessResponse(metrics, )
        OpenAPI.validate_property(PutPolicySuccessResponse, Symbol("metrics"), metrics)
        return new(metrics, )
    end
end # type PutPolicySuccessResponse

const _property_types_PutPolicySuccessResponse = Dict{Symbol,String}(Symbol("metrics")=>"Dict{String, Any}", )
OpenAPI.property_type(::Type{ PutPolicySuccessResponse }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_PutPolicySuccessResponse[name]))}

function check_required(o::PutPolicySuccessResponse)
    true
end

function OpenAPI.validate_property(::Type{ PutPolicySuccessResponse }, name::Symbol, val)
end
