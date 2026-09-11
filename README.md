# OpenPolicyAgent.jl

[![Build Status](https://github.com/JuliaComputing/OpenPolicyAgent.jl/workflows/CI/badge.svg)](https://github.com/JuliaComputing/OpenPolicyAgent.jl/actions?query=workflow%3ACI+branch%3Amain)
[![codecov.io](http://codecov.io/github/JuliaComputing/OpenPolicyAgent.jl/coverage.svg?branch=main)](http://codecov.io/github/JuliaComputing/OpenPolicyAgent.jl?branch=main)

[Open Policy Agent (OPA)](https://www.openpolicyagent.org/) is an open-source, cloud-native policy engine that allows organizations to declaratively enforce policies across their software stack. It provides a unified, flexible, and efficient way to implement and manage policies for access control, security, and compliance in modern, dynamic environments.

This package provides a Julia interface to the OPA server, and the client APIs to interact with the server. It also includes a command-line interface to the OPA command-line tool.

The REST client is generated from the OPA OpenAPI specification with [OpenAPI.jl](https://github.com/JuliaComputing/OpenAPI.jl) 1.x (Julia 1.10 or newer). Version 0.5 changed the client API; see the Client page of the documentation for a migration table.

[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://JuliaComputing.github.io/OpenPolicyAgent.jl)
