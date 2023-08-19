# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""_200Result_result_inner_ast_rules_inner

    200ResultResultInnerAstRulesInner(;
        head=nothing,
        body=nothing,
    )

    - head::200ResultResultInnerAstRulesInnerHead
    - body::Vector{200ResultResultInnerAstRulesInnerBodyInner} : A list of the terms in this rule
"""
Base.@kwdef mutable struct 200ResultResultInnerAstRulesInner <: OpenAPI.APIModel
    head = nothing # spec type: Union{ Nothing, 200ResultResultInnerAstRulesInnerHead }
    body::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{200ResultResultInnerAstRulesInnerBodyInner} }

    function 200ResultResultInnerAstRulesInner(head, body, )
        OpenAPI.validate_property(200ResultResultInnerAstRulesInner, Symbol("head"), head)
        OpenAPI.validate_property(200ResultResultInnerAstRulesInner, Symbol("body"), body)
        return new(head, body, )
    end
end # type 200ResultResultInnerAstRulesInner

const _property_types_200ResultResultInnerAstRulesInner = Dict{Symbol,String}(Symbol("head")=>"200ResultResultInnerAstRulesInnerHead", Symbol("body")=>"Vector{200ResultResultInnerAstRulesInnerBodyInner}", )
OpenAPI.property_type(::Type{ 200ResultResultInnerAstRulesInner }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_200ResultResultInnerAstRulesInner[name]))}

function check_required(o::200ResultResultInnerAstRulesInner)
    true
end

function OpenAPI.validate_property(::Type{ 200ResultResultInnerAstRulesInner }, name::Symbol, val)
end
