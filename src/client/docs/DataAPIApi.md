# DataAPIApi

All URIs are relative to *http://localhost:8181*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_document**](DataAPIApi.md#create_document) | **PUT** /v1/data/{path} | Create or overwrite a document.
[**delete_document**](DataAPIApi.md#delete_document) | **DELETE** /v1/data/{path} | Delete a document
[**get_document**](DataAPIApi.md#get_document) | **GET** /v1/data/{path} | Get a document
[**get_document_from_webhook**](DataAPIApi.md#get_document_from_webhook) | **POST** /v0/data/{path} | Get a document from a webhook.
[**get_document_with_path**](DataAPIApi.md#get_document_with_path) | **POST** /v1/data/{path} | Get a document that required an input
[**patch_document**](DataAPIApi.md#patch_document) | **PATCH** /v1/data/{path} | Patch a document


# **create_document**
> create_document(_api::DataAPIApi, path::String, request_body::Dict{String, Any}; metrics=nothing, _mediaType=nothing) -> CreateDocumentSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> create_document(_api::DataAPIApi, response_stream::Channel, path::String, request_body::Dict{String, Any}; metrics=nothing, _mediaType=nothing) -> Channel{ CreateDocumentSuccessResponse }, OpenAPI.Clients.ApiResponse

Create or overwrite a document.

If the path does not refer to an existing document, the server will attempt to create all of the necessary containing documents. This behavior is similar in principle to the Unix command mkdir -p. The server will respect the If-None-Match header if it is set to *. In this case, the server will not overwrite an existing document located at the path.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **DataAPIApi** | API context | 
**path** | **String**| A backslash (/) delimited path to access values inside object and array documents. If the path points to an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404. | [default to nothing]
**request_body** | [**Dict{String, Any}**](Any.md)| The document to create or overwrite (in JSON format) | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]

### Return type

[**CreateDocumentSuccessResponse**](CreateDocumentSuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **delete_document**
> delete_document(_api::DataAPIApi, path::String; metrics=nothing, _mediaType=nothing) -> DeleteDocumentSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> delete_document(_api::DataAPIApi, response_stream::Channel, path::String; metrics=nothing, _mediaType=nothing) -> Channel{ DeleteDocumentSuccessResponse }, OpenAPI.Clients.ApiResponse

Delete a document

The server processes the DELETE method as if the client had sent a PATCH request containing a single remove operation.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **DataAPIApi** | API context | 
**path** | **String**| A backslash (/) delimited path to access values inside object and array documents. If the path points to an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404. | [default to nothing]

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]

### Return type

[**DeleteDocumentSuccessResponse**](DeleteDocumentSuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_document**
> get_document(_api::DataAPIApi, path::String; input=nothing, pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, strict_builtin_errors=nothing, _mediaType=nothing) -> GetDocumentSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> get_document(_api::DataAPIApi, response_stream::Channel, path::String; input=nothing, pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, strict_builtin_errors=nothing, _mediaType=nothing) -> Channel{ GetDocumentSuccessResponse }, OpenAPI.Clients.ApiResponse

Get a document

This API endpoint returns the document specified by `path`.  The path separator is used to access values inside object and array documents. If the path indexes into an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404.  The server will return a *bad request* (400) response if either: - The query requires an input document and you do not provide it - You provide the input document but the query has already defined it.

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
 **strict_builtin_errors** | **Bool**| Treat built-in function call errors as fatal and return an error immediately. | [default to nothing]

### Return type

[**GetDocumentSuccessResponse**](GetDocumentSuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_document_from_webhook**
> get_document_from_webhook(_api::DataAPIApi, path::String, request_body::Dict{String, Any}; pretty=nothing, _mediaType=nothing) -> GetDocumentSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> get_document_from_webhook(_api::DataAPIApi, response_stream::Channel, path::String, request_body::Dict{String, Any}; pretty=nothing, _mediaType=nothing) -> Channel{ GetDocumentSuccessResponse }, OpenAPI.Clients.ApiResponse

Get a document from a webhook.

Use this API if you are enforcing policy decisions via webhooks that have pre-defined request/response formats. Note, the API path prefix is /v0 instead of /v1. The request message body defines the content of the The input Document. The request message body may be empty. The path separator is used to access values inside object and array documents.

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

### Return type

[**GetDocumentSuccessResponse**](GetDocumentSuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_document_with_path**
> get_document_with_path(_api::DataAPIApi, path::String, request_body::Dict{String, Any}; pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, strict_builtin_errors=nothing, _mediaType=nothing) -> GetDocumentSuccessResponse, OpenAPI.Clients.ApiResponse <br/>
> get_document_with_path(_api::DataAPIApi, response_stream::Channel, path::String, request_body::Dict{String, Any}; pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, strict_builtin_errors=nothing, _mediaType=nothing) -> Channel{ GetDocumentSuccessResponse }, OpenAPI.Clients.ApiResponse

Get a document that required an input

The request body contains an object that specifies a value for the input document.  The path separator is used to access values inside object and array documents. If the path indexes into an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404.  The server will return a *bad request* (400) response if either: - The query requires an input document and you do not provide it - You provided an input document but the query has already defined it.

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
 **strict_builtin_errors** | **Bool**| Treat built-in function call errors as fatal and return an error immediately. | [default to nothing]

### Return type

[**GetDocumentSuccessResponse**](GetDocumentSuccessResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **patch_document**
> patch_document(_api::DataAPIApi, path::String, patch_operation::Vector{PatchOperation}; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> patch_document(_api::DataAPIApi, response_stream::Channel, path::String, patch_operation::Vector{PatchOperation}; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Patch a document

Update a document. The patch operation is specified in the request body.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **DataAPIApi** | API context | 
**path** | **String**| A backslash (/) delimited path to access values inside object and array documents. If the path points to an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404. | [default to nothing]
**patch_operation** | [**Vector{PatchOperation}**](PatchOperation.md)| The patch operation in application/json-patch+json format | 

### Return type

Nothing

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

