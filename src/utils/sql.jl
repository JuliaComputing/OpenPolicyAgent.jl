module SQL

import ..ASTWalker: Visitor, walk, before, visit, after
import ..ASTWalker: AST

"""
    AbstractSQLCondition

Abstract type for SQL conditions. This is used to represent the result of translating an OPA query to SQL.
Conditions can be either `SQLCondition` or `UnconditionalInclude` or `UnconditionalExclude`.
"""
abstract type AbstractSQLCondition end

"""
    SQLCondition

Represents a SQL condition.
Contains the SQL string that represents the condition. It can be appended to a SQL query using a `where` clause.
"""
struct SQLCondition <: AbstractSQLCondition
    sql::String
end

"""
    UnconditionalInclude

Represents an unconditional include condition.
Equivalent of a where clause with `true` condition.
"""
struct UnconditionalInclude <: AbstractSQLCondition end

"""
    UnconditionalExclude

Represents an unconditional exclude condition.
Equivalent of a where clause with `false` condition.
"""
struct UnconditionalExclude <: AbstractSQLCondition end

const SQL_OP_MAP = Dict{String,String}(
    "eq" => "=",
    "neq" => "!=",
    "gt" => ">",
    "gte" => ">=",
    "lt" => "<",
    "lte" => "<=",
    "equal" => "=",
    "internal.member_2" => "in",
    "bits.and" => "&",
    "bits.or" => "|",
    "bits.xor" => "#",
    "bits.negate" => "~",
    "bits.lsh" => "<<",
    "bits.rsh" => ">>",
    "plus" => "+",
    "minus" => "-",
)

const VALID_SQL_OPS = Set(keys(SQL_OP_MAP))

"""
    SQLVisitor

Visitor that converts an OPA partial compile AST to a SQL condition.

It requires two dictionaries to be passed in the constructor:
- `schema_map`: maps OPA package names to database schema names
- `table_map`: maps OPA rule names to database table names

Input to the visitor must be a partial compile result from OPA already converted to a julia representation using `ASTWalker.AST.ASTVisitor`.
Walking the AST using this visitor will result in a SQL condition that can be appended to a SQL query using a `where` clause.
Output, that is returned from the `walk` method, is an `AbstractSQLCondition`. It can be one of:

- `SQLCondition`: represents a SQL condition. Contains the SQL string that represents the condition that can be used in the query with a "where" clause.
- `UnconditionalInclude`: represents an unconditional include condition. Which means that the SQL query should return all rows.
- `UnconditionalExclude`: represents an unconditional exclude condition. Which means that the SQL query should not return any rows.
"""
struct SQLVisitor <: Visitor
    schema_map::Dict{String, String}
    table_map::Dict{String, String}
    result_stack::Vector{Any}

    function SQLVisitor(schema_map::Dict{String, String}, table_map::Dict{String, String})
        return new(schema_map, table_map, Any[])
    end
end

function strip_quote(var)
    if startswith(var, "'") && endswith(var, "'")
        return var[2:end-1]
    else
        return var
    end
end

before(::SQLVisitor, _node) = nothing
after(visitor::SQLVisitor, _node) = pop!(visitor.result_stack)

function visit(visitor::SQLVisitor, ::Nothing)
    push!(visitor.result_stack, UnconditionalExclude())
    return nothing
end

function visit(visitor::SQLVisitor, queryset::AST.QuerySet)
    filters = [walk(visitor, q) for q in queryset.queries]
    if any(isempty, filters)
        # if any of the filters are fully satisfied, then the query is fully satisfied
        push!(visitor.result_stack, UnconditionalInclude())
    else
        push!(visitor.result_stack,  SQLCondition(join(filters, " or\n")))
    end
    return nothing
end

function visit(visitor::SQLVisitor, query::AST.OPAQuery)
    filters = [walk(visitor, expr) for expr in query.expressions]
    push!(visitor.result_stack, join(filters, " and "))
end

function visit(visitor::SQLVisitor, term::AST.OPATerm)
    resp = walk(visitor, term.value)
    push!(visitor.result_stack, resp)
end
function visit(visitor::SQLVisitor, var::AST.OPAVar)
    push!(visitor.result_stack, var.value)
    return nothing
end

function visit(visitor::SQLVisitor, scaler::AST.OPAScalarValue)
    value = scaler.value
    result = (value === nothing) ? "null" :
             (value === true) ? "true" :
             (value === false) ? "false" :
             isa(value, String) ? "'$value'" :
             string(value)
    push!(visitor.result_stack, result)
    return nothing
end

function visit(visitor::SQLVisitor, ref::AST.OPARef)
    col_spec = ref.value

    is_db_column_ref = false
    if length(col_spec) == 4
        selector = walk(visitor, col_spec[3])
        is_db_column_ref = startswith(selector, '$')
    end

    if is_db_column_ref
        # this is a database column reference
        schema = visitor.schema_map[strip_quote(walk(visitor, col_spec[1]))]
        table = visitor.table_map[strip_quote(walk(visitor, col_spec[2]))]
        colname = strip_quote(walk(visitor, col_spec[4]))
        push!(visitor.result_stack, join([schema, table, colname], "."))
    else
        # this is a reference to a variable
        push!(visitor.result_stack, join(strip_quote.([walk(visitor, cs) for cs in col_spec]), '.'))
    end
    return nothing
end

function visit(visitor::SQLVisitor, arr::Union{AST.OPAArray,AST.OPASet})
    push!(visitor.result_stack, string("(", join([walk(visitor, v) for v in arr.value], ", "), ")"))
    return nothing
end

function visit(visitor::SQLVisitor, call::AST.OPACall)
    op_name = walk(visitor, call.operator)
    if !(op_name in VALID_SQL_OPS)
        error("Invalid SQL operator: $op_name")
    end
    op = SQL_OP_MAP[op_name]

    op_operands = call.operands
    @assert length(op_operands) == 2
    op_lhs = walk(visitor, op_operands[1])
    op_rhs = walk(visitor, op_operands[2])

    push!(visitor.result_stack, join(["(", op_lhs, op, op_rhs, ")"], " "))
end

function visit(visitor::SQLVisitor, expr::AST.OPAExpr)
    @assert AST.is_call(expr)

    op_spec = AST.operator(expr)
    op_name = walk(visitor, op_spec)
    if !(op_name in VALID_SQL_OPS)
        error("Invalid SQL operator: $op_name")
    end

    op_operands = AST.operands(expr)
    @assert length(op_operands) == 2
    op_lhs = walk(visitor, op_operands[1])
    op_rhs = walk(visitor, op_operands[2])
    op = SQL_OP_MAP[op_name]

    push!(visitor.result_stack, join(["(", op_lhs, op, op_rhs, ")"], " "))
end

end # module SQL