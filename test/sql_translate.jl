
module OPASQL

# References:
# - https://github.com/open-policy-agent/contrib/tree/main/data_filter_example
# - https://github.com/open-policy-agent/contrib/tree/main/data_filter_elasticsearch

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

#-------------------------------------------------

struct OPAExpr
    index::Int64
    value::Union{OPATerm, Vector{OPATerm}}
end

function is_call(expr::OPAExpr)
    return isa(expr.value, Vector)
end

function from_data(::Type{OPAExpr}, data)
    index = data["index"]
    terms = data["terms"]

    if isa(terms, Vector)
        terms = [from_data(OPATerm, t) for t in terms]
    else
        terms = from_data(OPATerm, terms)
    end

    return OPAExpr(index, terms)
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

function from_data(::Type{OPAQuery}, data)
    return OPAQuery([from_data(OPAExpr, e) for e in data])
end

struct QuerySet
    queries::Vector{OPAQuery}
end

function from_data(::Type{QuerySet}, data)
    return QuerySet([from_data(OPAQuery, q) for q in data])
end

#-------------------------------------------------

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


from_data(::Type{OPAScalarValue}, data) = OPAScalarValue(data)
from_data(::Type{OPAVar}, data) = OPAVar(data)
from_data(::Type{OPATerm}, data) = OPATerm(from_data(TERM_TYPE_MAP[data["type"]], data["value"]))
from_data(::Type{OPARef}, data) = OPARef([from_data(OPATerm, t) for t in data])
from_data(::Type{OPAArray}, data) = OPAArray([from_data(OPATerm, t) for t in data])
from_data(::Type{OPASet}, data) = OPASet([from_data(OPATerm, t) for t in data])
from_data(::Type{OPAObject}, data) = OPAObject([Pair(from_data(OPATerm, t[1]), from_data(OPATerm, t[2])) for t in data])
function from_data(::Type{OPACall}, data)
    terms = [from_data(OPATerm, t) for t in data]
    return OPACall(popfirst!(terms), terms)
end
function from_data(::Type{OPAArrayComprehension}, data)
    return OPAArrayComprehension(from_data(OPATerm, data["term"]), from_data(OPAQuery, data["body"]))
end
function from_data(::Type{OPASetComprehension}, data)
    return OPASetComprehension(from_data(OPATerm, data["term"]), from_data(OPAQuery, data["body"]))
end
function from_data(::Type{OPAObjectComprehension}, data)
    return OPAObjectComprehension(from_data(OPATerm, data["key"]), from_data(OPATerm, data["value"]), from_data(OPAQuery, data["body"]))
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

#------------------------------------------------------------
const SQL_OP_MAP = Dict{String,String}(
    "eq" => "=",
    "neq" => "!=",
    "gt" => ">",
    "gte" => ">=",
    "lt" => "<",
    "lte" => "<=",
    "equal" => "=",
    "internal.member_2" => "in",
)

const VALID_SQL_OPS = Set(keys(SQL_OP_MAP))

to_sql(var::OPAVar) = var.value
function strip_quote(var)
    if startswith(var, "'") && endswith(var, "'")
        return var[2:end-1]
    else
        return var
    end
end

function to_sql(scaler::OPAScalarValue)
    value = scaler.value
    if value === nothing
        return "null"
    elseif value === true
        return "true"
    elseif value === false
        return "false"
    elseif isa(value, String)
        return "'$value'"
    else
        return string(value)
    end
end

function to_sql(ref::OPARef)
    col_spec = ref.value
    if length(col_spec) == 4 && startswith(to_sql(col_spec[3]), '$')
        # this is a database column reference
        schema = SCHEMA_MAP[strip_quote(to_sql(col_spec[1]))]
        table = TABLE_MAP[strip_quote(to_sql(col_spec[2]))]
        colname = strip_quote(to_sql(col_spec[4]))
        return join([schema, table, colname], ".")    
    else
        # this is a reference to a variable
        return join(strip_quote.(to_sql.(col_spec)), '.')
    end
end

function to_sql(arr::OPAArray)
    return string("(", join(to_sql.(arr.value), ", "), ")")
end

const SCHEMA_MAP = Dict{String, String}(
    "data" => "public",
    "public" => "public",
)

const TABLE_MAP = Dict{String, String}(
    "reports" => "juliahub_reports",
)

to_sql(term::OPATerm) = to_sql(term.value)
function to_sql(expr::OPAExpr)
    @assert is_call(expr)

    op_spec = operator(expr)
    op_name = to_sql(op_spec)
    if !(op_name in VALID_SQL_OPS)
        error("Invalid SQL operator: $op_name")
    end

    op_operands = operands(expr)
    @assert length(op_operands) == 2

    op = SQL_OP_MAP[op_name]
    op_lhs = to_sql(op_operands[1])
    op_rhs = to_sql(op_operands[2])

    return join([op_lhs, op, op_rhs], " ")
end

function to_sql(query::OPAQuery)
    join(to_sql.(query.expressions), " and ")
end

function to_sql(queryset::QuerySet)
    filters = to_sql.(queryset.queries)
    if any(isempty, filters)
        # if any of the filters are fully satisfied, then the query is fully satisfied
        return ""
    else
        return join(filters, " or\n")
    end
end

function translate(result::Dict{String, Any})
    if haskey(result, "queries") && length(result["queries"]) > 0
        return to_sql(from_data(QuerySet, result["queries"]))
    else
        # if there are no partial queries, then either query is fully satisfied or undefined
        return "false"
    end
end

end # module OPASQL