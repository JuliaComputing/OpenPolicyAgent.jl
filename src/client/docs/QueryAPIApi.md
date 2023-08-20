# QueryAPIApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_query**](QueryAPIApi.md#get_query) | **GET** /v1/query | Execute an ad-hoc query (simple)
[**post_query**](QueryAPIApi.md#post_query) | **POST** /v1/query | Execute an ad-hoc query (complex)
[**post_simple_query**](QueryAPIApi.md#post_simple_query) | **POST** / | Execute a simple query


# **get_query**
> get_query(_api::QueryAPIApi, q::String; pretty=nothing, explain=nothing, metrics=nothing, _mediaType=nothing) -> GetQuery200Response, OpenAPI.Clients.ApiResponse <br/>
> get_query(_api::QueryAPIApi, response_stream::Channel, q::String; pretty=nothing, explain=nothing, metrics=nothing, _mediaType=nothing) -> Channel{ GetQuery200Response }, OpenAPI.Clients.ApiResponse

Execute an ad-hoc query (simple)

This API endpoint returns bindings for the variables in the query.  For more complex JSON queries, use `POST /v1/query` instead.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **QueryAPIApi** | API context | 
**q** | **String**| The [URL-encoded](https://www.w3schools.com/tags/ref_urlencode.ASP) ad-hoc query to execute. | [default to nothing]

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **explain** | **String**| If set to *full*, response will include query explanations in addition to the result. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]

### Return type

[**GetQuery200Response**](GetQuery200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **post_query**
> post_query(_api::QueryAPIApi, request_body::Dict{String, Any}; pretty=nothing, explain=nothing, metrics=nothing, _mediaType=nothing) -> GetQuery200Response, OpenAPI.Clients.ApiResponse <br/>
> post_query(_api::QueryAPIApi, response_stream::Channel, request_body::Dict{String, Any}; pretty=nothing, explain=nothing, metrics=nothing, _mediaType=nothing) -> Channel{ GetQuery200Response }, OpenAPI.Clients.ApiResponse

Execute an ad-hoc query (complex)

This API endpoint returns bindings for the variables in the query.  For simpler JSON queries, you may use `GET /v1/query` instead.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **QueryAPIApi** | API context | 
**request_body** | [**Dict{String, Any}**](Any.md)| The test of the query (in JSON format) | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **explain** | **String**| If set to *full*, response will include query explanations in addition to the result. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]

### Return type

[**GetQuery200Response**](GetQuery200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-yaml
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **post_simple_query**
> post_simple_query(_api::QueryAPIApi, request_body::Dict{String, Any}; pretty=nothing, _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> post_simple_query(_api::QueryAPIApi, response_stream::Channel, request_body::Dict{String, Any}; pretty=nothing, _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Execute a simple query

This API queries the document at */data/system/main* by default (however, you can [configure OPA](https://www.openpolicyagent.org/docs/latest/configuration/) to use a different path to serve these queries). That document defines the response. For example, use the following in `PUT /v1/policies/{path}`) to define a rule that will produce a value for the */data/system/main* document:    ```yaml   package system   main = msg {     msg := sprintf(\"hello, %v\", input.user)   }   ```  The server will return a *not found* (404) response if */data/system/main* is undefined.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **QueryAPIApi** | API context | 
**request_body** | [**Dict{String, Any}**](Any.md)| The text of the input document (in JSON format) | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]

### Return type

Nothing

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

