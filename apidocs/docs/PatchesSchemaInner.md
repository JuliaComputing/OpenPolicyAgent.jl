# PatchesSchemaInner


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**op** | **String** | JSON patch operation type | [default to nothing]
**path** | **String** | A [JSON pointer](https://tools.ietf.org/html/rfc6901) to a location within the target document where the operation is performed.  The *effective path* is this value prefixed with the API call&#39;s &#x60;path&#x60; parameter.  The server will return a *bad request* (404) response if:  - The *parent* of the effective path does not refer to an existing document - For **remove** and **replace** operations, the effective path does not refer to an existing document. | [default to nothing]
**value** | **Dict{String, Any}** | The value to add, replace or test. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


