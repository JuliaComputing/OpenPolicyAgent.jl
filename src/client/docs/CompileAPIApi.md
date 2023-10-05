# CompileAPIApi

All URIs are relative to *http://localhost:8181*

Method | HTTP request | Description
------------- | ------------- | -------------
[**post_compile**](CompileAPIApi.md#post_compile) | **POST** /v1/compile | Partially evaluate a query.


# **post_compile**
> post_compile(_api::CompileAPIApi; pretty=nothing, explain=nothing, metrics=nothing, instrument=nothing, partial_query_schema=nothing, _mediaType=nothing) -> CompileSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> post_compile(_api::CompileAPIApi, response_stream::Channel; pretty=nothing, explain=nothing, metrics=nothing, instrument=nothing, partial_query_schema=nothing, _mediaType=nothing) -> Channel{ CompileSuccessResponse }, OpenAPI.Clients.ApiResponse

Partially evaluate a query.

The Compile API allows you to partially evaluate Rego queries and obtain a simplified version of the policy. This is most useful when building integrations where policy logic is to be translated and evaluated in another environment. <br/> For example, [this post](https://blog.openpolicyagent.org/write-policy-in-opa-enforce-policy-in-sql-d9d24db93bf4) on the OPA blog shows how SQL can be generated based on Compile API output. For more details on Partial Evaluation in OPA, please refer to [this blog post](https://blog.openpolicyagent.org/partial-evaluation-162750eaf422). <br/> The example below assumes that OPA has been given the following policy (use `PUT /v1/policies/{path}`): <br/> <pre> package example allow {   input.subject.clearance_level >= data.reports[_].clearance_level } </pre> <br/> Compile API **request body** so that it contain the following fields: <br/> <table> <tr><th>Field</th><th>Type</th><th>Required</th><th>Description</th></tr> <tr><td><code>query</code></td><td><code>string</code></td><td>Yes</td><td>The query to partially evaluate and compile.</td></tr> <tr><td><code>input</code></td><td><code>any</code></td><td>No</td><td>The input document to use during partial evaluation (default: undefined).</td></tr> <tr><td><code>options</code></td><td><code>object[string, any]</code></td><td>No</td><td>Additional options to use during partial evaluation. Only <code>disableInlining</code> option is supported. (default: undefined).</td></tr> <tr><td><code>unknowns</code></td><td><code>array[string]</code></td><td>No</td><td>The terms to treat as unknown during partial evaluation (default: <code>[\"input\"]</code>]).</td></tr> </table> <br/> For example: <br/> <code> {   \"query\": \"data.example.allow == true\",   \"input\": {     \"subject\": {       \"clearance_level\": 4     }   },   \"unknowns\": [     \"data.reports\"     ] } </code> <br/> <b>Unconditional Results from Partial Evaluation</b> When you partially evaluate a query with the Compile API, OPA returns a new set of queries and supporting policies. However, in some cases, the result of Partial Evaluation is a conclusive, unconditional answer. <br/> See [the guidance](https://www.openpolicyagent.org/docs/latest/rest-api/#unconditional-results-from-partial-evaluation) for details.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **CompileAPIApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **explain** | **String**| If set to *full*, response will include query explanations in addition to the result. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]
 **instrument** | **Bool**| If true, response will return additional performance metrics in addition to the result and the standard metrics.  **Caution:** This can add significant overhead to query evaluation. The recommendation is to only use this parameter if you are debugging a performance problem. | [default to nothing]
 **partial_query_schema** | [**PartialQuerySchema**](PartialQuerySchema.md)| The query (in JSON format) | 

### Return type

[**CompileSuccessResponse**](CompileSuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

