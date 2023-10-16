# OPA Command Line

The OPA (Open Policy Agent) command-line tool is a versatile utility that empowers users to interact with and manage OPA policies and data. It allows users to perform various tasks, such as evaluating policies, testing Rego expressions, and querying data, all from the command line. This tool is invaluable for policy development, debugging, and troubleshooting, providing an accessible way to work with OPA without the need for complex integration. It's an essential companion for developers and administrators working with OPA, simplifying the process of authoring, testing, and refining policies to ensure robust and consistent policy enforcement across software systems.

The OPA command line is made available in the `OpenPolicyAgent.CLI` module. To use, import the module. E.g.:

```julia
julia> using OpenPolicyAgent

julia> import OpenPolicyAgent: CLI

julia> ctx = CLI.CommandLine();

julia> CLI.opa(ctx; help=true);
An open source project to policy-enable your service.

Usage:
  opa [command]

Available Commands:
  bench        Benchmark a Rego query
  build        Build an OPA bundle
  capabilities Print the capabilities of OPA
  check        Check Rego source files
  completion   Generate the autocompletion script for the specified shell
  deps         Analyze Rego query dependencies
  eval         Evaluate a Rego query
  exec         Execute against input files
  fmt          Format Rego source files
  help         Help about any command
  inspect      Inspect OPA bundle(s)
  parse        Parse Rego source file
  run          Start OPA in interactive or server mode
  sign         Generate an OPA bundle signature
  test         Execute Rego test cases
  version      Print the version of OPA

Flags:
  -h, --help   help for opa

Use "opa [command] --help" for more information about a command.
```
