# OPA Client

OPA exposes domain-agnostic APIs that your service can call to manage and enforce policies. Read this page if you want to integrate an application, service, or tool with OPA. The REST APIs are grouped into the following categories:

- **Policy API** - manage policy loaded into the OPA instance.
- **Data API** - evaluate rules and retrieve data.
- **Query API** - execute adhoc queries.
- **Compile API** - access Rego’s Partial Evaluation functionality.
- **Health API** - access instance operational health information.
- **Config API** - view instance configuration.
- **Status API** - view instance status state.

The `OpenPolicyAgent.Client` module includes methods to help interact with the OPA server using the OpenAPI client.

```julia
opa_client = OpenPolicyAgent.Client.DataApi(openapi_client)

response, _http_resp = OpenPolicyAgent.Client.get_document(
    opa_client,
    "policies/server/rest/allowed"
);
@test response.result == false
```

Complete reference is available in the Reference section.

OpenAPI [API Documents](https://github.com/JuliaComputing/OpenPolicyAgent.jl/blob/main/src/client/README.md) also give more details on the API methods.
