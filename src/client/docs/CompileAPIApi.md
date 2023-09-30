# CompileAPIApi

All URIs are relative to *http://localhost:8181*

Method | HTTP request | Description
------------- | ------------- | -------------
[**post_compile**](CompileAPIApi.md#post_compile) | **POST** /v1/compile | Compile


# **post_compile**
> post_compile(_api::CompileAPIApi; pretty=nothing, explain=nothing, metrics=nothing, instrument=nothing, partial_query_schema=nothing, _mediaType=nothing) -> CompileSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> post_compile(_api::CompileAPIApi, response_stream::Channel; pretty=nothing, explain=nothing, metrics=nothing, instrument=nothing, partial_query_schema=nothing, _mediaType=nothing) -> Channel{ CompileSuccessResponse }, OpenAPI.Clients.ApiResponse

Compile

This API endpoint allows you to partially evaluate Rego queries and obtain a simplified version of the policy. The example below assumes that OPA has been given the following policy (use `PUT /v1/policies/{path}`):  ```yaml package example allow {   input.subject.clearance_level >= data.reports[_].clearance_level } ``` Compile API **request body** so that it contain the following fields:  | Field | Type | Required | Description | | --- | --- | --- | --- | | `query` | `string` | Yes | The query to partially evaluate and compile. | | `input` | `any` | No | The input document to use during partial evaluation (default: undefined). | | `unknowns` | `array[string]` | No | The terms to treat as unknown during partial evaluation (default: `[\"input\"]`]). |  For example:  ```json {   \"query\": \"data.example.allow == true\",   \"input\": {     \"subject\": {       \"clearance_level\": 4     }   },   \"unknowns\": [     \"data.reports\"     ] } ``` ### Partial evaluation In some cases, the result of partial valuation is a conclusive, unconditional answer. See [the guidance](https://www.openpolicyagent.org/docs/latest/rest-api/#unconditional-results-from-partial-evaluation) for details.

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

