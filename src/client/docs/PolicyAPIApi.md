# PolicyAPIApi

All URIs are relative to *http://localhost:8181*

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete_policy_module**](PolicyAPIApi.md#delete_policy_module) | **DELETE** /v1/policies/{id} | Delete a policy module
[**get_policies**](PolicyAPIApi.md#get_policies) | **GET** /v1/policies | List policies
[**get_policy_module**](PolicyAPIApi.md#get_policy_module) | **GET** /v1/policies/{id} | Get a policy module
[**put_policy_module**](PolicyAPIApi.md#put_policy_module) | **PUT** /v1/policies/{id} | Create or update a policy module


# **delete_policy_module**
> delete_policy_module(_api::PolicyAPIApi, id::String; pretty=nothing, metrics=nothing, _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> delete_policy_module(_api::PolicyAPIApi, response_stream::Channel, id::String; pretty=nothing, metrics=nothing, _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Delete a policy module

This API endpoint removes an existing policy module from the server

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **PolicyAPIApi** | API context | 
**id** | **String**| The name of a policy module | [default to nothing]

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]

### Return type

Nothing

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_policies**
> get_policies(_api::PolicyAPIApi; pretty=nothing, _mediaType=nothing) -> Vector{Policy}, OpenAPI.Clients.ApiResponse <br/>
> get_policies(_api::PolicyAPIApi, response_stream::Channel; pretty=nothing, _mediaType=nothing) -> Channel{ Vector{Policy} }, OpenAPI.Clients.ApiResponse

List policies

This API endpoint responds with a list of all policy modules on the server (result response)

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **PolicyAPIApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]

### Return type

[**Vector{Policy}**](Policy.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **get_policy_module**
> get_policy_module(_api::PolicyAPIApi, id::String; pretty=nothing, _mediaType=nothing) -> Policy, OpenAPI.Clients.ApiResponse <br/>
> get_policy_module(_api::PolicyAPIApi, response_stream::Channel, id::String; pretty=nothing, _mediaType=nothing) -> Channel{ Policy }, OpenAPI.Clients.ApiResponse

Get a policy module

This API endpoint returns the details of the specified policy module (`{id}`)

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **PolicyAPIApi** | API context | 
**id** | **String**| The name of a policy module | [default to nothing]

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]

### Return type

[**Policy**](Policy.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **put_policy_module**
> put_policy_module(_api::PolicyAPIApi, id::String, body::String; pretty=nothing, metrics=nothing, _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> put_policy_module(_api::PolicyAPIApi, response_stream::Channel, id::String, body::String; pretty=nothing, metrics=nothing, _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Create or update a policy module

- If the policy module does not exist, it is created. - If the policy module already exists, it is replaced.  If the policy module isn't correctly defined, a *bad request* (400) response is returned.  ### Example policy module ```yaml package opa.examples  import data.servers import data.networks import data.ports  public_servers[server] {   some k, m    server := servers[_]    server.ports[_] == ports[k].id    ports[k].networks[_] == networks[m].id    networks[m].public == true } ```

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **PolicyAPIApi** | API context | 
**id** | **String**| The name of a policy module | [default to nothing]
**body** | **String**|  | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pretty** | **Bool**| If true, response will be in a human-readable format. | [default to nothing]
 **metrics** | **Bool**| If true, compiler performance metrics will be returned in the response. | [default to nothing]

### Return type

Nothing

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: text/plain
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

