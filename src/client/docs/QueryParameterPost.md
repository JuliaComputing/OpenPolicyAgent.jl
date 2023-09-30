# QueryParameterPost


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**query** | **String** | The ad-hoc query to execute. OPA will parse, compile, and execute the query represented by the parameter value. The value MUST be URL encoded. Only used in GET method. For POST method the query is sent as part of the request body and this parameter is not used. | [optional] [default to nothing]
**input** | **Dict{String, Any}** | The input document (in JSON format) | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


