# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""response200Explanations_explanation_inner_node_terms_inner

    Response200ExplanationsExplanationInnerNodeTermsInner(;
        type=nothing,
        value=nothing,
    )

    - type::String
    - value::String
"""
Base.@kwdef mutable struct Response200ExplanationsExplanationInnerNodeTermsInner <: OpenAPI.APIModel
    type::Union{Nothing, String} = nothing
    value::Union{Nothing, String} = nothing

    function Response200ExplanationsExplanationInnerNodeTermsInner(type, value, )
        OpenAPI.validate_property(Response200ExplanationsExplanationInnerNodeTermsInner, Symbol("type"), type)
        OpenAPI.validate_property(Response200ExplanationsExplanationInnerNodeTermsInner, Symbol("value"), value)
        return new(type, value, )
    end
end # type Response200ExplanationsExplanationInnerNodeTermsInner

const _property_types_Response200ExplanationsExplanationInnerNodeTermsInner = Dict{Symbol,String}(Symbol("type")=>"String", Symbol("value")=>"String", )
OpenAPI.property_type(::Type{ Response200ExplanationsExplanationInnerNodeTermsInner }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_Response200ExplanationsExplanationInnerNodeTermsInner[name]))}

function check_required(o::Response200ExplanationsExplanationInnerNodeTermsInner)
    true
end

function OpenAPI.validate_property(::Type{ Response200ExplanationsExplanationInnerNodeTermsInner }, name::Symbol, val)
end
