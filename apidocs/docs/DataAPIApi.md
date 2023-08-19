# DataAPIApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete_document**](DataAPIApi.md#delete_document) | **DELETE** /v1/data/{path} | Delete a document
[**get_document**](DataAPIApi.md#get_document) | **GET** /v1/data/{path} | Get a document
[**get_document_with_path**](DataAPIApi.md#get_document_with_path) | **POST** /v1/data/{path} | Get a document (with input)
[**get_document_with_web_hook**](DataAPIApi.md#get_document_with_web_hook) | **POST** /v0/data/{path} | Get a document (with webhook)
[**patch_document**](DataAPIApi.md#patch_document) | **PATCH** /v1/data/{path} | Update a document
[**put_document**](DataAPIApi.md#put_document) | **PUT** /v1/data/{path} | Create or overwrite a document


# **delete_document**
> delete_document(_api::DataAPIApi, path::String; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> delete_document(_api::DataAPIApi, response_stream::Channel, path::String; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Delete a document

This API endpoint deletes an existing document from the server

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **DataAPIApi** | API context | 
**path** | **String**| A backslash (/) delimited path to access values inside object and array documents. If the path points to an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404. | [default to nothing]

### Return type

Nothing

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_document**
> get_document(_api::DataAPIApi, path::String; input=nothing, pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, _mediaType=nothing) -> DeletePolicyModule200Response, OpenAPI.Clients.ApiResponse <br/>
> get_document(_api::DataAPIApi, response_stream::Channel, path::String; input=nothing, pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, _mediaType=nothing) -> Channel{ DeletePolicyModule200Response }, OpenAPI.Clients.ApiResponse

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

[**DeletePolicyModule200Response**](DeletePolicyModule200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_document_with_path**
> get_document_with_path(_api::DataAPIApi, path::String, request_body::Dict{String, Any}; pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, _mediaType=nothing) -> DeletePolicyModule200Response, OpenAPI.Clients.ApiResponse <br/>
> get_document_with_path(_api::DataAPIApi, response_stream::Channel, path::String, request_body::Dict{String, Any}; pretty=nothing, provenance=nothing, explain=nothing, metrics=nothing, instrument=nothing, _mediaType=nothing) -> Channel{ DeletePolicyModule200Response }, OpenAPI.Clients.ApiResponse

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

[**DeletePolicyModule200Response**](DeletePolicyModule200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-yaml
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_document_with_web_hook**
> get_document_with_web_hook(_api::DataAPIApi, path::String, request_body::Dict{String, Any}; pretty=nothing, _mediaType=nothing) -> DeletePolicyModule200Response, OpenAPI.Clients.ApiResponse <br/>
> get_document_with_web_hook(_api::DataAPIApi, response_stream::Channel, path::String, request_body::Dict{String, Any}; pretty=nothing, _mediaType=nothing) -> Channel{ DeletePolicyModule200Response }, OpenAPI.Clients.ApiResponse

Get a document (with webhook)

The example given here assumes you have created a policy (with `PUT /v1/policies/{path}`), such as:    ```yaml   package opa.examples   import input.example.flag   allow_request { flag == true }   ```  The server will return a *not found* (404) response if the requested document is missing or undefined. 

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

[**DeletePolicyModule200Response**](DeletePolicyModule200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-yaml
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **patch_document**
> patch_document(_api::DataAPIApi, path::String, patches_schema_inner::Vector{PatchesSchemaInner}; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> patch_document(_api::DataAPIApi, response_stream::Channel, path::String, patches_schema_inner::Vector{PatchesSchemaInner}; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Update a document

This API endpoint updates an existing document on the server by describing the changes required (using [JSON patch operations](http://jsonpatch.com/))

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **DataAPIApi** | API context | 
**path** | **String**| A backslash (/) delimited path to access values inside object and array documents. If the path points to an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404. | [default to nothing]
**patches_schema_inner** | [**Vector{PatchesSchemaInner}**](PatchesSchemaInner.md)| The list of JSON patch operations. | 

### Return type

Nothing

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **put_document**
> put_document(_api::DataAPIApi, path::String, body::Any; if_none_match=nothing, _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> put_document(_api::DataAPIApi, response_stream::Channel, path::String, body::Any; if_none_match=nothing, _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Create or overwrite a document

If the path does not refer to an existing document (for example *us-west/servers*), the server will attempt to create all the necessary containing documents.  This behavior is similar to the Unix command [mkdir -p](https://en.wikipedia.org/wiki/Mkdir#Options).

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **DataAPIApi** | API context | 
**path** | **String**| A backslash (/) delimited path to access values inside object and array documents. If the path points to an array, the server will attempt to convert the array index to an integer. If the path element cannot be converted to an integer, the server will respond with 404. | [default to nothing]
**body** | **Any**| The JSON document to write to the specified path. | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **if_none_match** | **String**| The server will respect the If-None-Match header if it is set to * (in other words, it will not overwrite an existing document located at the specified &#x60;path&#x60;). | [default to nothing]

### Return type

Nothing

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

