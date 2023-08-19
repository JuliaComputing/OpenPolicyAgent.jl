# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""_400_errors_inner

    400ErrorsInner(;
        code=nothing,
        message=nothing,
        location=nothing,
    )

    - code::String : The error code name
    - message::String : A general description of the error
    - location::400ErrorsInnerLocation
"""
Base.@kwdef mutable struct 400ErrorsInner <: OpenAPI.APIModel
    code::Union{Nothing, String} = nothing
    message::Union{Nothing, String} = nothing
    location = nothing # spec type: Union{ Nothing, 400ErrorsInnerLocation }

    function 400ErrorsInner(code, message, location, )
        OpenAPI.validate_property(400ErrorsInner, Symbol("code"), code)
        OpenAPI.validate_property(400ErrorsInner, Symbol("message"), message)
        OpenAPI.validate_property(400ErrorsInner, Symbol("location"), location)
        return new(code, message, location, )
    end
end # type 400ErrorsInner

const _property_types_400ErrorsInner = Dict{Symbol,String}(Symbol("code")=>"String", Symbol("message")=>"String", Symbol("location")=>"400ErrorsInnerLocation", )
OpenAPI.property_type(::Type{ 400ErrorsInner }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_400ErrorsInner[name]))}

function check_required(o::400ErrorsInner)
    true
end

function OpenAPI.validate_property(::Type{ 400ErrorsInner }, name::Symbol, val)
    if name === Symbol("code")
        OpenAPI.validate_param(name, "400ErrorsInner", :minLength, val, 1)
    end
    if name === Symbol("message")
        OpenAPI.validate_param(name, "400ErrorsInner", :minLength, val, 1)
    end
end
