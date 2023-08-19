# 200ExplanationsExplanationInner


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**op** | **String** | The kind of *trace event*  Each trace event represents a step in the query evaluation process. Trace events are emitted at the following points: - enter - before a body or rule is evaluated - exit - after a body or rule has evaluated successfully - eval - before an expression is evaluated - fail - after an expression has evaluated to false. - redo - before evaluation restarts from a body, rule, or expression.  By default, OPA searches for all sets of term bindings that make all expressions in the query evaluate to true. Because there may be multiple answers, the search can restart when OPA determines the query is true or false. When the search restarts, a *redo trace event* is emitted. | [optional] [default to nothing]
**query_id** | **Float64** | The query that the trace event was emitted for. Use this field to distinguish trace events emitted by from different queries. | [optional] [default to nothing]
**parent_id** | **Float64** | The parent query. Use this field to identify trace events from related queries.  For example, if query A references rule R, trace events emitted when evaluating rule R will have the *parent_id* field set to query A’s *query_id*. | [optional] [default to nothing]
**type** | **String** | The type of the **node** field | [optional] [default to nothing]
**node** | [***200ExplanationsExplanationInnerNode**](200ExplanationsExplanationInnerNode.md) |  | [optional] [default to nothing]
**locals** | [**Vector{200ExplanationsExplanationInnerLocalsInner}**](200ExplanationsExplanationInnerLocalsInner.md) | The query&#39;s term bindings at the point when the trace event was emitted. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


