# AST Walker

OPA has a feature called partial evaluation which has several interesting applications. With partial evaluation, callers specify that certain inputs or pieces of data are unknown. OPA evaluates as much of the policy as possible without touching parts that depend on unknown values. The result of partial evaluation is a new policy that can be evaluated more efficiently than the original. The new policy is returned to the caller as an AST.

The returned AST thus represents a strategy, rather than a result. It may be cached and reused. It may also be converted to other forms, e.g. a SQL query condition, or elastic search query.

The `ASTWalker` module provides a framework to traverse the AST returned from a partial evaluattion. It specifies a `Visitor` interface that callers can implement to perform custom operations on the AST. The `ASTWalker` module also provides a default implementation of the `Visitor` interface that can be used to perform common operations on the AST.

Included in the `ASTWalker` module are implementations of the `Visitor` interface that can be used to:
- Create a easy to use Julia representation of the AST. This is provided by the `ASTWalker.AST.ASTVisitor` type.
- Create a SQL query condition from the Julia representation of the AST. This is provided by the `ASTWalker.SQL.SQLVisitor` type.

An example of how it can be used is shown below:
```julia
import OpenPolicyAgent: ASTWalker
import OpenPolicyAgent.ASTWalker: AST, SQL
import OpenPolicyAgent.ASTWalker.AST: ASTVisitor
import OpenPolicyAgent.ASTWalker.SQL: SQLVisitor, SQLCondition, UnconditionalInclude, UnconditionalExclude

# invoke the partial evaluation endpoint
partial_query_schema = OpenPolicyAgent.Client.PartialQuerySchema(; ...)
response, _http_resp = OpenPolicyAgent.Client.post_compile(
    compile_client;
    partial_query_schema = partial_query_schema,
)

# crete a Julia representation of the AST
ast = OpenPolicyAgent.ASTWalker.walk(ASTVisitor(), result)

# Provide a mapping of schema names and table names that can be used to convert policy paths to SQL table names
const SCHEMA_MAP = Dict{String, String}(
    "data" => "public",
    "public" => "public",
)

const TABLE_MAP = Dict{String, String}(
    "reports" => "juliahub_reports",
)

# create a SQL query condition from the AST
sqlvisitor = SQLVisitor(SCHEMA_MAP, TABLE_MAP)
sqlcondition = OpenPolicyAgent.ASTWalker.walk(sqlvisitor, ast)

# sql condition should be a SQLCondition object
if isa(sqlcondition, UnconditionalExclude)
    # all rows should be excluded
elseif isa(sqlcondition, UnconditionalInclude)
    # all rows should be included
else
    # `sqlcondition.sql` contains a string with the SQL query condition
end
```

More details of AST walker, and the included visitors can be found in the reference documentation.