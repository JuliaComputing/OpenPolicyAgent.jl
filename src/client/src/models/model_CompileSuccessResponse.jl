# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""compileSuccessResponse

    CompileSuccessResponse(;
        result=nothing,
        provenance=nothing,
        metrics=nothing,
    )

    - result::Any
    - provenance::Provenance
    - metrics::Dict{String, Any}
"""
Base.@kwdef mutable struct CompileSuccessResponse <: OpenAPI.APIModel
    result::Union{Nothing, Any} = nothing
    provenance = nothing # spec type: Union{ Nothing, Provenance }
    metrics::Union{Nothing, Dict{String, Any}} = nothing

    function CompileSuccessResponse(result, provenance, metrics, )
        OpenAPI.validate_property(CompileSuccessResponse, Symbol("result"), result)
        OpenAPI.validate_property(CompileSuccessResponse, Symbol("provenance"), provenance)
        OpenAPI.validate_property(CompileSuccessResponse, Symbol("metrics"), metrics)
        return new(result, provenance, metrics, )
    end
end # type CompileSuccessResponse

const _property_types_CompileSuccessResponse = Dict{Symbol,String}(Symbol("result")=>"Any", Symbol("provenance")=>"Provenance", Symbol("metrics")=>"Dict{String, Any}", )
OpenAPI.property_type(::Type{ CompileSuccessResponse }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_CompileSuccessResponse[name]))}

function check_required(o::CompileSuccessResponse)
    true
end

function OpenAPI.validate_property(::Type{ CompileSuccessResponse }, name::Symbol, val)
end
