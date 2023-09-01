# DataAPIApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_document**](DataAPIApi.md#get_document) | **GET** /v1/data/{path} | Get a document
[**get_document_with_path**](DataAPIApi.md#get_document_with_path) | **POST** /v1/data/{path} | Get a document (with input)


# **get_document**
> get_document(_api::DataAPIApi, path::String; input=nothing, pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, _mediaType=nothing) -> SuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> get_document(_api::DataAPIApi, response_stream::Channel, path::String; input=nothing, pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, _mediaType=nothing) -> Channel{ SuccessResponse }, OpenAPI.Clients.ApiResponse

Get a document

This API endpoint returns the document specified by `path`.  The server will return a *bad request* (400) response if either: - The query requires an input document and you do not provide it - You provide the input document but the query has already defined it.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **DataAPIApi** | API context | 
**path** | **String**| A backslash (/) delimited path to access values inside object and array documents. If the path points to an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404. | [default to nothing]

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**Dict{String, Any}**](Any.md)| Provide the text for an [input document](https://www.openpolicyagent.org/docs/latest/kubernetes-primer/#input-document) in JSON format | [default to nothing]
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **provenance** | **Bool**| If true, response will include build and version information in addition to the result. | [default to nothing]
 **explain** | **String**| If set to *full*, response will include query explanations in addition to the result. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]
 **instrument** | **Bool**| If true, response will return additional performance metrics in addition to the result and the standard metrics.  **Caution:** This can add significant overhead to query evaluation. The recommendation is to only use this parameter if you are debugging a performance problem. | [default to nothing]

### Return type

[**SuccessResponse**](SuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_document_with_path**
> get_document_with_path(_api::DataAPIApi, path::String, request_body::Dict{String, Any}; pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, _mediaType=nothing) -> SuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> get_document_with_path(_api::DataAPIApi, response_stream::Channel, path::String, request_body::Dict{String, Any}; pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, _mediaType=nothing) -> Channel{ SuccessResponse }, OpenAPI.Clients.ApiResponse

Get a document (with input)

The server will return a *bad request* (400) response if either: - The query requires an input document and you do not provide it - You provided an input document but the query has already defined it.  If `path` indexes into an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, a *not found* response (404) will be returned.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **DataAPIApi** | API context | 
**path** | **String**| A backslash (/) delimited path to access values inside object and array documents. If the path points to an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404. | [default to nothing]
**request_body** | [**Dict{String, Any}**](Any.md)| The input document (in JSON format) | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **provenance** | **Bool**| If true, response will include build and version information in addition to the result. | [default to nothing]
 **explain** | **String**| If set to *full*, response will include query explanations in addition to the result. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]
 **instrument** | **Bool**| If true, response will return additional performance metrics in addition to the result and the standard metrics.  **Caution:** This can add significant overhead to query evaluation. The recommendation is to only use this parameter if you are debugging a performance problem. | [default to nothing]

### Return type

[**SuccessResponse**](SuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-yaml
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

