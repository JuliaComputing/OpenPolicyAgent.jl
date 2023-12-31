# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""policy_ast_package

    PolicyAstPackage(;
        path=nothing,
    )

    - path::Vector{PolicyAstPackagePathInner} : The path to the package
"""
Base.@kwdef mutable struct PolicyAstPackage <: OpenAPI.APIModel
    path::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{PolicyAstPackagePathInner} }

    function PolicyAstPackage(path, )
        OpenAPI.validate_property(PolicyAstPackage, Symbol("path"), path)
        return new(path, )
    end
end # type PolicyAstPackage

const _property_types_PolicyAstPackage = Dict{Symbol,String}(Symbol("path")=>"Vector{PolicyAstPackagePathInner}", )
OpenAPI.property_type(::Type{ PolicyAstPackage }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_PolicyAstPackage[name]))}

function check_required(o::PolicyAstPackage)
    true
end

function OpenAPI.validate_property(::Type{ PolicyAstPackage }, name::Symbol, val)
end
