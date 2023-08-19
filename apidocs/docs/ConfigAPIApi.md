# ConfigAPIApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_config**](ConfigAPIApi.md#get_config) | **GET** /v1/config | Get configurations


# **get_config**
> get_config(_api::ConfigAPIApi; pretty=nothing, _mediaType=nothing) -> Model200SingleResult, OpenAPI.Clients.ApiResponse <br/>
> get_config(_api::ConfigAPIApi, response_stream::Channel; pretty=nothing, _mediaType=nothing) -> Channel{ Model200SingleResult }, OpenAPI.Clients.ApiResponse

Get configurations

This API endpoint responds with active configuration (result response)  --- **Note** The `credentials` field in the `services` configuration and  The `private_key` and `key` fields in the `keys` configuration will be omitted from the API response  ---

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **ConfigAPIApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]

### Return type

[**Model200SingleResult**](Model200SingleResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

