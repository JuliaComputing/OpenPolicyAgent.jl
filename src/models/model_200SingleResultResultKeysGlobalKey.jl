# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""_200SingleResult_result_keys_global_key
Global Key

    200SingleResultResultKeysGlobalKey(;
        scope=nothing,
    )

    - scope::String : Scope
"""
Base.@kwdef mutable struct 200SingleResultResultKeysGlobalKey <: OpenAPI.APIModel
    scope::Union{Nothing, String} = nothing

    function 200SingleResultResultKeysGlobalKey(scope, )
        OpenAPI.validate_property(200SingleResultResultKeysGlobalKey, Symbol("scope"), scope)
        return new(scope, )
    end
end # type 200SingleResultResultKeysGlobalKey

const _property_types_200SingleResultResultKeysGlobalKey = Dict{Symbol,String}(Symbol("scope")=>"String", )
OpenAPI.property_type(::Type{ 200SingleResultResultKeysGlobalKey }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_200SingleResultResultKeysGlobalKey[name]))}

function check_required(o::200SingleResultResultKeysGlobalKey)
    true
end

function OpenAPI.validate_property(::Type{ 200SingleResultResultKeysGlobalKey }, name::Symbol, val)
    if name === Symbol("scope")
        OpenAPI.validate_param(name, "200SingleResultResultKeysGlobalKey", :minLength, val, 1)
    end
end
