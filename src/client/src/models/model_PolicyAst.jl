# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""policy_ast
The types for declarations and runtime objects passed to your implementation. This consists of an abstract syntax tree (AST) of policy modules, package and import declarations, rules, expressions, and terms.

    PolicyAst(;
        package=nothing,
        rules=nothing,
    )

    - package::PolicyAstPackage
    - rules::Vector{PolicyAstRulesInner} : When OPA evaluates a rule, it generates the content of a [virtual documents](https://www.openpolicyagent.org/docs/latest/philosophy/#the-opa-document-model)
"""
Base.@kwdef mutable struct PolicyAst <: OpenAPI.APIModel
    package = nothing # spec type: Union{ Nothing, PolicyAstPackage }
    rules::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{PolicyAstRulesInner} }

    function PolicyAst(package, rules, )
        OpenAPI.validate_property(PolicyAst, Symbol("package"), package)
        OpenAPI.validate_property(PolicyAst, Symbol("rules"), rules)
        return new(package, rules, )
    end
end # type PolicyAst

const _property_types_PolicyAst = Dict{Symbol,String}(Symbol("package")=>"PolicyAstPackage", Symbol("rules")=>"Vector{PolicyAstRulesInner}", )
OpenAPI.property_type(::Type{ PolicyAst }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_PolicyAst[name]))}

function check_required(o::PolicyAst)
    true
end

function OpenAPI.validate_property(::Type{ PolicyAst }, name::Symbol, val)
    if name === Symbol("rules")
        OpenAPI.validate_param(name, "PolicyAst", :uniqueItems, val, true)
    end
end
