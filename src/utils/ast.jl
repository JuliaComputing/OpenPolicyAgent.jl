"""
The AST module provides a julia based AST for OPA's partial compile result.
Provides `ASTVisitor` that implements `ASTWalker.Visitor` and can be used to walk the AST and convert it to a julia based AST.
"""
module AST

import ..ASTWalker: Visitor, walk, before, visit, after

abstract type OPATermType end
abstract type OPAComprehensionType <: OPATermType end

struct OPAScalarValue <: OPATermType
    value::Union{Nothing, String, Int64, Float64, Bool}
end

struct OPAVar <: OPATermType
    value::String
end

struct OPATerm <: OPATermType
    value::OPATermType
end

struct OPARef <: OPATermType
    value::Vector{OPATerm}
end

struct OPAArray <: OPATermType
    value::Vector{OPATerm}
end

struct OPASet <: OPATermType
    value::Vector{OPATerm}
end

struct OPAObject <: OPATermType
    value::Vector{Pair{OPATerm, OPATerm}}
end

struct OPACall <: OPATermType
    operator::OPATerm
    operands::Vector{OPATerm}
end

struct OPAExpr
    index::Int64
    value::Union{OPATerm, Vector{OPATerm}}
end

function is_call(expr::OPAExpr)
    return isa(expr.value, Vector)
end

function operator(expr::OPAExpr)
    @assert is_call(expr)
    return expr.value[1]
end

function operands(expr::OPAExpr)
    @assert is_call(expr)
    return expr.value[2:end]
end

struct OPAQuery
    expressions::Vector{OPAExpr}
end

struct QuerySet
    queries::Vector{OPAQuery}
end

struct OPAArrayComprehension <: OPAComprehensionType
    term::OPATerm
    body::OPAQuery
end

struct OPASetComprehension <: OPAComprehensionType
    term::OPATerm
    body::OPAQuery
end

struct OPAObjectComprehension <: OPAComprehensionType
    key::OPATerm
    value::OPATerm
    body::OPAQuery
end

const TERM_TYPE_MAP = Dict{String, DataType}(
    "null" => OPAScalarValue,
    "string" => OPAScalarValue,
    "number" => OPAScalarValue,
    "boolean" => OPAScalarValue,
    "var" => OPAVar,
    "ref" => OPARef,
    "array" => OPAArray,
    "set" => OPASet,
    "object" => OPAObject,
    "call" => OPACall,
    "objectcomprehension" => OPAObjectComprehension,
    "arraycomprehension" => OPAArrayComprehension,
    "setcomprehension" => OPASetComprehension,
)

"""
Visitor that converts a partial compile result to a julia based AST.
Must be used with `ASTWalker.walk`, providing the partial compile result as the `node` argument.

Output:
- `QuerySet`: If the partial compile result contains queries, the output is a `QuerySet` containing the queries.
- `nothing`: If the partial compile result does not contain queries, the output is `nothing`.

The output is returned from the `walk` method.
"""
struct ASTVisitor <: Visitor
    state_stack::Vector{DataType}
    result_stack::Vector{Any}

    function ASTVisitor()
        return new(DataType[], Any[])
    end
end

function before(visitor::ASTVisitor, node)
    if isempty(visitor.state_stack)
        push!(visitor.state_stack, QuerySet)
    end
    return nothing
end

function visit(visitor::ASTVisitor, node)
    T = visitor.state_stack[end]
    _visit(visitor, T, node)
    return nothing
end

function after(visitor::ASTVisitor, node)
    T = pop!(visitor.state_stack)
    if !isempty(visitor.state_stack)
        return nothing
    end
    @assert T === QuerySet
    return pop!(visitor.result_stack) # either a QuerySet or nothing
end

function _visit(visitor::ASTVisitor, ::Type{QuerySet}, node::Dict{String,Any})
    if haskey(node, "queries") && length(node["queries"]) > 0
        data = node["queries"]
        N = length(data)
        for idx in N:-1:1
            push!(visitor.state_stack, OPAQuery)
            walk(visitor, data[idx])
        end
        queryset = QuerySet([pop!(visitor.result_stack) for idx in 1:N])
        push!(visitor.result_stack, queryset)
    else
        push!(visitor.result_stack, nothing)
    end
end

function _visit(visitor::ASTVisitor, ::Type{OPAQuery}, node)
    N = length(node)
    for idx in N:-1:1
        push!(visitor.state_stack, OPAExpr)
        walk(visitor, node[idx])
    end
    query = OPAQuery([pop!(visitor.result_stack) for idx in 1:N])
    push!(visitor.result_stack, query)
end

function _visit(visitor::ASTVisitor, ::Type{OPAExpr}, node)
    index = node["index"]
    terms = node["terms"]

    if isa(terms, Vector)
        N = length(terms)
        for idx in N:-1:1
            push!(visitor.state_stack, OPATerm)
            walk(visitor, terms[idx])
        end
    else
        N = 1
        push!(visitor.state_stack, OPATerm)
        walk(visitor, terms)
    end
    opaterms = OPATerm[pop!(visitor.result_stack) for idx in 1:N]
    opaexpr = OPAExpr(index, opaterms)
    push!(visitor.result_stack, opaexpr)
end

function _visit(visitor::ASTVisitor, ::Type{OPATerm}, node)
    termtype = node["type"]
    T = TERM_TYPE_MAP[termtype]
    if isa(T, DataType)
        push!(visitor.state_stack, T)
        data = node["value"]
        walk(visitor, data)
    else
        error("Unknown term type: $termtype")
    end
    term = OPATerm(pop!(visitor.result_stack))
    push!(visitor.result_stack, term)
end

_visit(visitor::ASTVisitor, ::Type{OPAVar}, value) = push!(visitor.result_stack, OPAVar(value))
_visit(visitor::ASTVisitor, ::Type{OPAScalarValue}, value) = push!(visitor.result_stack, OPAScalarValue(value))

function _visit(visitor::ASTVisitor, ::Type{T}, data) where T <: Union{OPARef, OPAArray, OPASet}
    N = length(data)
    for idx in N:-1:1
        push!(visitor.state_stack, OPATerm)
        walk(visitor, data[idx])
    end
    opaterms = OPATerm[pop!(visitor.result_stack) for idx in 1:N]
    result = T(opaterms)
    push!(visitor.result_stack, result)
end

function _visit(visitor::ASTVisitor, ::Type{OPAObject}, data)
    N = length(data)
    for idx in N:-1:1
        pair = data[idx]
        push!(visitor.state_stack, OPATerm)
        walk(visitor, pair[2])
        push!(visitor.state_stack, OPATerm)
        walk(visitor, pair[1])
    end
    termpairs = Pair{OPATerm, OPATerm}[Pair(pop!(visitor.result_stack), pop!(visitor.result_stack)) for idx in 1:N]
    result = OPAObject(termpairs)
    push!(visitor.result_stack, result)
end

function _visit(visitor::ASTVisitor, ::Type{OPACall}, data)
    N = length(data)
    for idx in N:-1:1
        push!(visitor.state_stack, OPATerm)
        walk(visitor, data[idx])
    end
    operator = pop!(visitor.result_stack)
    operands = OPATerm[pop!(visitor.result_stack) for idx in 1:(N-1)]
    result = OPACall(operator, operands)
    push!(visitor.result_stack, result)
end

function _visit(visitor::ASTVisitor, ::Type{T}, data) where T <: Union{OPASetComprehension, OPAArrayComprehension}
    push!(visitor.state_stack, OPATerm)
    walk(visitor, data["term"])
    term = pop!(visitor.result_stack)

    push!(visitor.state_stack, OPAQuery)
    walk(visitor, data["body"])
    body = pop!(visitor.result_stack)

    result = T(term, body)
    push!(visitor.result_stack, result)
end

function _visit(visitor::ASTVisitor, ::Type{OPAObjectComprehension}, data)
    push!(visitor.state_stack, OPATerm)
    walk(visitor, data["key"])
    key = pop!(visitor.result_stack)

    push!(visitor.state_stack, OPATerm)
    walk(visitor, data["value"])
    value = pop!(visitor.result_stack)

    push!(visitor.state_stack, OPAQuery)
    walk(visitor, data["body"])
    body = pop!(visitor.result_stack)

    result = OPAObjectComprehension(key, value, body)
    push!(visitor.result_stack, result)
end

end # module AST