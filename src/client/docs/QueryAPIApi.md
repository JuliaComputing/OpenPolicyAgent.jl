# QueryAPIApi

All URIs are relative to *http://localhost:8181*

Method | HTTP request | Description
------------- | ------------- | -------------
[**query_get**](QueryAPIApi.md#query_get) | **GET** /v1/query | Execute an ad-hoc query and return bindings for variables found in the query.
[**query_post**](QueryAPIApi.md#query_post) | **POST** /v1/query | Execute an ad-hoc query and return bindings for variables found in the query.
[**simple_query**](QueryAPIApi.md#simple_query) | **POST** / | Execute a simple query.


# **query_get**
> query_get(_api::QueryAPIApi, q::String; pretty=nothing, explain=nothing, metrics=nothing, _mediaType=nothing) -> GetDocumentSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> query_get(_api::QueryAPIApi, response_stream::Channel, q::String; pretty=nothing, explain=nothing, metrics=nothing, _mediaType=nothing) -> Channel{ GetDocumentSuccessResponse }, OpenAPI.Clients.ApiResponse

Execute an ad-hoc query and return bindings for variables found in the query.

For queries that have large JSON values it is recommended to use the POST method with the query included as the POST body

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **QueryAPIApi** | API context | 
**q** | **String**| The ad-hoc query to execute. OPA will parse, compile, and execute the query represented by the parameter value. The value MUST be URL encoded. Only used in GET method. For POST method the query is sent as part of the request body and this parameter is not used. | [default to nothing]

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **explain** | **String**| If set to *full*, response will include query explanations in addition to the result. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]

### Return type

[**GetDocumentSuccessResponse**](GetDocumentSuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **query_post**
> query_post(_api::QueryAPIApi, query_parameter_post::QueryParameterPost; pretty=nothing, explain=nothing, metrics=nothing, _mediaType=nothing) -> GetDocumentSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> query_post(_api::QueryAPIApi, response_stream::Channel, query_parameter_post::QueryParameterPost; pretty=nothing, explain=nothing, metrics=nothing, _mediaType=nothing) -> Channel{ GetDocumentSuccessResponse }, OpenAPI.Clients.ApiResponse

Execute an ad-hoc query and return bindings for variables found in the query.

Query included as the POST body. E.g.: ``` {   \"query\": \"input.servers[i].ports[_] = \\\"p2\\\"; input.servers[i].name = name\",   \"input\": {     \"servers\": [ ... ],   } } ```

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **QueryAPIApi** | API context | 
**query_parameter_post** | [**QueryParameterPost**](QueryParameterPost.md)| The query and input document (in JSON format) | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **explain** | **String**| If set to *full*, response will include query explanations in addition to the result. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]

### Return type

[**GetDocumentSuccessResponse**](GetDocumentSuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **simple_query**
> simple_query(_api::QueryAPIApi, request_body::Dict{String, Any}; pretty=nothing, _mediaType=nothing) -> Dict{String, Any}, OpenAPI.Clients.ApiResponse <br/>
> simple_query(_api::QueryAPIApi, response_stream::Channel, request_body::Dict{String, Any}; pretty=nothing, _mediaType=nothing) -> Channel{ Dict{String, Any} }, OpenAPI.Clients.ApiResponse

Execute a simple query.

OPA serves POST requests without a URL path by querying for the document at path `/data/system/main`. The content of that document defines the response entirely.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **QueryAPIApi** | API context | 
**request_body** | [**Dict{String, Any}**](Any.md)| The input document (in JSON format) | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]

### Return type

**Dict{String, Any}**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

