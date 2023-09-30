# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""errorDetail

    ErrorDetail(;
        code=nothing,
        message=nothing,
        location=nothing,
    )

    - code::String : The error code name
    - message::String : A general description of the error
    - location::ErrorLocation
"""
Base.@kwdef mutable struct ErrorDetail <: OpenAPI.APIModel
    code::Union{Nothing, String} = nothing
    message::Union{Nothing, String} = nothing
    location = nothing # spec type: Union{ Nothing, ErrorLocation }

    function ErrorDetail(code, message, location, )
        OpenAPI.validate_property(ErrorDetail, Symbol("code"), code)
        OpenAPI.validate_property(ErrorDetail, Symbol("message"), message)
        OpenAPI.validate_property(ErrorDetail, Symbol("location"), location)
        return new(code, message, location, )
    end
end # type ErrorDetail

const _property_types_ErrorDetail = Dict{Symbol,String}(Symbol("code")=>"String", Symbol("message")=>"String", Symbol("location")=>"ErrorLocation", )
OpenAPI.property_type(::Type{ ErrorDetail }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ErrorDetail[name]))}

function check_required(o::ErrorDetail)
    o.code === nothing && (return false)
    o.message === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ ErrorDetail }, name::Symbol, val)
    if name === Symbol("code")
        OpenAPI.validate_param(name, "ErrorDetail", :minLength, val, 1)
    end
    if name === Symbol("message")
        OpenAPI.validate_param(name, "ErrorDetail", :minLength, val, 1)
    end
end
