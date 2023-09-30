# HealthAPIApi

All URIs are relative to *http://localhost:8181*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_health**](HealthAPIApi.md#get_health) | **GET** /health | Health


# **get_health**
> get_health(_api::HealthAPIApi; bundles=nothing, plugins=nothing, _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> get_health(_api::HealthAPIApi, response_stream::Channel; bundles=nothing, plugins=nothing, _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Health

This API endpoint verifies that the server is operational.  The response from the server is either 200 or 500: - **200** - OPA service is healthy. If `bundles` is true, then all configured bundles have been activated. If `plugins` is true, then all plugins are in an 'OK' state. - **500** - OPA service is *not* healthy. If `bundles` is true, at least one of configured bundles has not yet been activated. If `plugins` is true, at least one plugins is in a 'not OK' state.  --- **Note** This check is only for initial bundle activation. Subsequent downloads will not affect the health check.  Use the **status** endpoint (in the (management API)[management.html]) for more fine-grained bundle status monitoring.  ---

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **HealthAPIApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bundles** | **Bool**| Reports on bundle activation status (useful for &#39;ready&#39; checks at startup).  This includes any discovery bundles or bundles defined in the loaded discovery configuration. | [default to nothing]
 **plugins** | **Bool**| Reports on plugin status | [default to nothing]

### Return type

Nothing

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

