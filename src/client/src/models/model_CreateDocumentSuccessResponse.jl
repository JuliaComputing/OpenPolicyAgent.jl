# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""createDocumentSuccessResponse

    CreateDocumentSuccessResponse(;
        metrics=nothing,
    )

    - metrics::Dict{String, Any}
"""
Base.@kwdef mutable struct CreateDocumentSuccessResponse <: OpenAPI.APIModel
    metrics::Union{Nothing, Dict{String, Any}} = nothing

    function CreateDocumentSuccessResponse(metrics, )
        OpenAPI.validate_property(CreateDocumentSuccessResponse, Symbol("metrics"), metrics)
        return new(metrics, )
    end
end # type CreateDocumentSuccessResponse

const _property_types_CreateDocumentSuccessResponse = Dict{Symbol,String}(Symbol("metrics")=>"Dict{String, Any}", )
OpenAPI.property_type(::Type{ CreateDocumentSuccessResponse }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_CreateDocumentSuccessResponse[name]))}

function check_required(o::CreateDocumentSuccessResponse)
    true
end

function OpenAPI.validate_property(::Type{ CreateDocumentSuccessResponse }, name::Symbol, val)
end
