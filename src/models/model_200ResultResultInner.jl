# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""_200Result_result_inner

    200ResultResultInner(;
        id=nothing,
        raw=nothing,
        ast=nothing,
    )

    - id::String : The name of a policy module
    - raw::String : A string representation of the full Rego policy
    - ast::200ResultResultInnerAst
"""
Base.@kwdef mutable struct 200ResultResultInner <: OpenAPI.APIModel
    id::Union{Nothing, String} = nothing
    raw::Union{Nothing, String} = nothing
    ast = nothing # spec type: Union{ Nothing, 200ResultResultInnerAst }

    function 200ResultResultInner(id, raw, ast, )
        OpenAPI.validate_property(200ResultResultInner, Symbol("id"), id)
        OpenAPI.validate_property(200ResultResultInner, Symbol("raw"), raw)
        OpenAPI.validate_property(200ResultResultInner, Symbol("ast"), ast)
        return new(id, raw, ast, )
    end
end # type 200ResultResultInner

const _property_types_200ResultResultInner = Dict{Symbol,String}(Symbol("id")=>"String", Symbol("raw")=>"String", Symbol("ast")=>"200ResultResultInnerAst", )
OpenAPI.property_type(::Type{ 200ResultResultInner }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_200ResultResultInner[name]))}

function check_required(o::200ResultResultInner)
    true
end

function OpenAPI.validate_property(::Type{ 200ResultResultInner }, name::Symbol, val)
    if name === Symbol("id")
        OpenAPI.validate_param(name, "200ResultResultInner", :minLength, val, 1)
    end
    if name === Symbol("raw")
        OpenAPI.validate_param(name, "200ResultResultInner", :minLength, val, 1)
    end
end
