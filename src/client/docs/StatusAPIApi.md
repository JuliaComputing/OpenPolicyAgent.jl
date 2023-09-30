# StatusAPIApi

All URIs are relative to *http://localhost:8181*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_status**](StatusAPIApi.md#get_status) | **GET** /v1/status | Get status


# **get_status**
> get_status(_api::StatusAPIApi; pretty=nothing, _mediaType=nothing) -> Dict{String, Any}, OpenAPI.Clients.ApiResponse <br/>
> get_status(_api::StatusAPIApi, response_stream::Channel; pretty=nothing, _mediaType=nothing) -> Channel{ Dict{String, Any} }, OpenAPI.Clients.ApiResponse

Get status

The /status API endpoint returns the status of the OPA server. This includes the status of the bundles and plugins.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **StatusAPIApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]

### Return type

**Dict{String, Any}**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

