# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""getPolicyModuleSuccessResponse

    GetPolicyModuleSuccessResponse(;
        result=nothing,
    )

    - result::Policy
"""
Base.@kwdef mutable struct GetPolicyModuleSuccessResponse <: OpenAPI.APIModel
    result = nothing # spec type: Union{ Nothing, Policy }

    function GetPolicyModuleSuccessResponse(result, )
        OpenAPI.validate_property(GetPolicyModuleSuccessResponse, Symbol("result"), result)
        return new(result, )
    end
end # type GetPolicyModuleSuccessResponse

const _property_types_GetPolicyModuleSuccessResponse = Dict{Symbol,String}(Symbol("result")=>"Policy", )
OpenAPI.property_type(::Type{ GetPolicyModuleSuccessResponse }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_GetPolicyModuleSuccessResponse[name]))}

function check_required(o::GetPolicyModuleSuccessResponse)
    o.result === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ GetPolicyModuleSuccessResponse }, name::Symbol, val)
end
