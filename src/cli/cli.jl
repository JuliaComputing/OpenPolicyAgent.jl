"""
CLI for opa.
Open Policy Agent (OPA)

Generated via @__MODULE__. Do not edit directly.
Edit the specification file and run the generator instead.
"""
module CLI


"""
The base CLI command.
Open Policy Agent (OPA)
"""
function opa()
    return `opa`
end

""" opa
Run the opa command.
Open Policy Agent (OPA)

Options:
- help::Bool - Help for opa
 """
function opa(parent::Cmd; help::Union{Nothing,Bool} = false, )
    cmd = opa()

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" bench
Run the bench subcommand of opa command.
Benchmark a Rego query

Options:
- benchmem::Bool - Report memory allocations with benchmark results
- bundle::AbstractString - Set bundle file(s) or directory path(s). This flag can be repeated
- count::AbstractString - Number of times to repeat each benchmark
- data::AbstractString - Set policy or data file(s). This flag can be repeated
- fail::Bool - Exits with non-zero exit code on undefined/empty result and errors
- format::AbstractString - Set output format
- ignore::AbstractString - Set file and directory names to ignore during loading (e.g., '.*' excludes hidden files)
- _import::AbstractString - Set query import(s). This flag can be repeated
- input::AbstractString - Set input file path
- metrics::Bool - Report query performance metrics
- package::AbstractString - Set query package
- partial::Bool - Perform partial evaluation
- schema::AbstractString - Set schema file path or directory path
- stdin::Bool - Read query from stdin
- stdin_input::Bool - Read input document from stdin
- target::AbstractString - Set the runtime to exercise
- unknowns::AbstractString - Set paths to treat as unknown during partial evaluation
- help::Bool - Help for bench
 """
function bench(parent::Cmd; benchmem::Union{Nothing,Bool} = false, bundle::Union{Nothing,AbstractString} = nothing, count::Union{Nothing,AbstractString} = "1", data::Union{Nothing,AbstractString} = nothing, fail::Union{Nothing,Bool} = false, format::Union{Nothing,AbstractString} = "pretty", ignore::Union{Nothing,AbstractString} = nothing, _import::Union{Nothing,AbstractString} = nothing, input::Union{Nothing,AbstractString} = nothing, metrics::Union{Nothing,Bool} = false, package::Union{Nothing,AbstractString} = nothing, partial::Union{Nothing,Bool} = false, schema::Union{Nothing,AbstractString} = nothing, stdin::Union{Nothing,Bool} = false, stdin_input::Union{Nothing,Bool} = false, target::Union{Nothing,AbstractString} = "rego", unknowns::Union{Nothing,AbstractString} = "[input]", help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) bench`

    if !isnothing(benchmem) && benchmem
        cmd = `$(cmd) --benchmem`
    end

    if !isnothing(bundle)
        cmd = `$(cmd) --bundle=$(bundle)`
    end

    if !isnothing(count)
        cmd = `$(cmd) --count=$(count)`
    end

    if !isnothing(data)
        cmd = `$(cmd) --data=$(data)`
    end

    if !isnothing(fail) && fail
        cmd = `$(cmd) --fail`
    end

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(ignore)
        cmd = `$(cmd) --ignore=$(ignore)`
    end

    if !isnothing(_import)
        cmd = `$(cmd) --import=$(_import)`
    end

    if !isnothing(input)
        cmd = `$(cmd) --input=$(input)`
    end

    if !isnothing(metrics) && metrics
        cmd = `$(cmd) --metrics`
    end

    if !isnothing(package)
        cmd = `$(cmd) --package=$(package)`
    end

    if !isnothing(partial) && partial
        cmd = `$(cmd) --partial`
    end

    if !isnothing(schema)
        cmd = `$(cmd) --schema=$(schema)`
    end

    if !isnothing(stdin) && stdin
        cmd = `$(cmd) --stdin`
    end

    if !isnothing(stdin_input) && stdin_input
        cmd = `$(cmd) --stdin-input`
    end

    if !isnothing(target)
        cmd = `$(cmd) --target=$(target)`
    end

    if !isnothing(unknowns)
        cmd = `$(cmd) --unknowns=$(unknowns)`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" build
Run the build subcommand of opa command.
Build an OPA bundle

Options:
- bundle::Bool - Load paths as bundle files or root directories
- capabilities::AbstractString - Set capabilities.json file path
- claims_file::AbstractString - Set path of JSON file containing optional claims (see: https://openpolicyagent.org/docs/latest/management/#signature-format)
- debug::Bool - Enable debug output
- entrypoint::AbstractString - Set slash separated entrypoint path
- exclude_files_verify::AbstractString - Set file names to exclude during bundle verification
- ignore::AbstractString - Set file and directory names to ignore during loading (e.g., '.*' excludes hidden files)
- optimize::AbstractString - Set optimization level
- output::AbstractString - Set the output filename
- revision::AbstractString - Set output bundle revision
- scope::AbstractString - Scope to use for bundle signature verification
- signing_alg::AbstractString - Name of the signing algorithm
- signing_key::AbstractString - Set the secret (HMAC) or path of the PEM file containing the private key (RSA and ECDSA)
- signing_plugin::AbstractString - Name of the plugin to use for signing/verification (see https://openpolicyagent.org/docs/latest/management/#signature-plugin
- target::AbstractString - Set the output bundle target type
- verification_key::AbstractString - Set the secret (HMAC) or path of the PEM file containing the public key (RSA and ECDSA)
- verification_key_id::AbstractString - Name assigned to the verification key used for bundle verification
- help::Bool - Help for build
 """
function build(parent::Cmd; bundle::Union{Nothing,Bool} = false, capabilities::Union{Nothing,AbstractString} = nothing, claims_file::Union{Nothing,AbstractString} = nothing, debug::Union{Nothing,Bool} = false, entrypoint::Union{Nothing,AbstractString} = nothing, exclude_files_verify::Union{Nothing,AbstractString} = nothing, ignore::Union{Nothing,AbstractString} = nothing, optimize::Union{Nothing,AbstractString} = "0", output::Union{Nothing,AbstractString} = "bundle.tar.gz", revision::Union{Nothing,AbstractString} = nothing, scope::Union{Nothing,AbstractString} = nothing, signing_alg::Union{Nothing,AbstractString} = "RS256", signing_key::Union{Nothing,AbstractString} = nothing, signing_plugin::Union{Nothing,AbstractString} = nothing, target::Union{Nothing,AbstractString} = "rego", verification_key::Union{Nothing,AbstractString} = nothing, verification_key_id::Union{Nothing,AbstractString} = "default", help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) build`

    if !isnothing(bundle) && bundle
        cmd = `$(cmd) --bundle`
    end

    if !isnothing(capabilities)
        cmd = `$(cmd) --capabilities=$(capabilities)`
    end

    if !isnothing(claims_file)
        cmd = `$(cmd) --claims-file=$(claims_file)`
    end

    if !isnothing(debug) && debug
        cmd = `$(cmd) --debug`
    end

    if !isnothing(entrypoint)
        cmd = `$(cmd) --entrypoint=$(entrypoint)`
    end

    if !isnothing(exclude_files_verify)
        cmd = `$(cmd) --exclude-files-verify=$(exclude_files_verify)`
    end

    if !isnothing(ignore)
        cmd = `$(cmd) --ignore=$(ignore)`
    end

    if !isnothing(optimize)
        cmd = `$(cmd) --optimize=$(optimize)`
    end

    if !isnothing(output)
        cmd = `$(cmd) --output=$(output)`
    end

    if !isnothing(revision)
        cmd = `$(cmd) --revision=$(revision)`
    end

    if !isnothing(scope)
        cmd = `$(cmd) --scope=$(scope)`
    end

    if !isnothing(signing_alg)
        cmd = `$(cmd) --signing-alg=$(signing_alg)`
    end

    if !isnothing(signing_key)
        cmd = `$(cmd) --signing-key=$(signing_key)`
    end

    if !isnothing(signing_plugin)
        cmd = `$(cmd) --signing-plugin=$(signing_plugin)`
    end

    if !isnothing(target)
        cmd = `$(cmd) --target=$(target)`
    end

    if !isnothing(verification_key)
        cmd = `$(cmd) --verification-key=$(verification_key)`
    end

    if !isnothing(verification_key_id)
        cmd = `$(cmd) --verification-key-id=$(verification_key_id)`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" check
Run the check subcommand of opa command.
Check Rego source files

Options:
- bundle::Bool - Load paths as bundle files or root directories
- capabilities::AbstractString - Set capabilities.json file path
- format::AbstractString - Set output format
- ignore::AbstractString - Set file and directory names to ignore during loading (e.g., '.*' excludes hidden files)
- max_errors::AbstractString - Set the number of errors to allow before compilation fails early
- schema::AbstractString - Set schema file path or directory path
- strict::Bool - Enable compiler strict mode
- help::Bool - Help for check
 """
function check(parent::Cmd; bundle::Union{Nothing,Bool} = false, capabilities::Union{Nothing,AbstractString} = nothing, format::Union{Nothing,AbstractString} = "pretty", ignore::Union{Nothing,AbstractString} = nothing, max_errors::Union{Nothing,AbstractString} = "10", schema::Union{Nothing,AbstractString} = nothing, strict::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) check`

    if !isnothing(bundle) && bundle
        cmd = `$(cmd) --bundle`
    end

    if !isnothing(capabilities)
        cmd = `$(cmd) --capabilities=$(capabilities)`
    end

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(ignore)
        cmd = `$(cmd) --ignore=$(ignore)`
    end

    if !isnothing(max_errors)
        cmd = `$(cmd) --max-errors=$(max_errors)`
    end

    if !isnothing(schema)
        cmd = `$(cmd) --schema=$(schema)`
    end

    if !isnothing(strict) && strict
        cmd = `$(cmd) --strict`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" completion
Run the completion subcommand of opa command.
Generate the autocompletion script for the specified shell

Options:
- help::Bool - Help for completion
 """
function completion(parent::Cmd; help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) completion`

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" deps
Run the deps subcommand of opa command.
Analyze Rego query dependencies

Options:
- bundle::AbstractString - Set bundle file(s) or directory path(s). This flag can be repeated
- data::AbstractString - Set policy or data file(s). This flag can be repeated
- format::AbstractString - Set output format
- ignore::AbstractString - Set file and directory names to ignore during loading (e.g., '.*' excludes hidden files)
- help::Bool - Help for deps
 """
function deps(parent::Cmd; bundle::Union{Nothing,AbstractString} = nothing, data::Union{Nothing,AbstractString} = nothing, format::Union{Nothing,AbstractString} = "pretty", ignore::Union{Nothing,AbstractString} = nothing, help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) deps`

    if !isnothing(bundle)
        cmd = `$(cmd) --bundle=$(bundle)`
    end

    if !isnothing(data)
        cmd = `$(cmd) --data=$(data)`
    end

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(ignore)
        cmd = `$(cmd) --ignore=$(ignore)`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" eval
Run the eval subcommand of opa command.
Evaluate a Rego query

Options:
- bundle::AbstractString - Set bundle file(s) or directory path(s). This flag can be repeated
- capabilities::AbstractString - Set capabilities.json file path
- count::AbstractString - Number of times to repeat each benchmark
- coverage::Bool - Report coverage
- data::AbstractString - Set policy or data file(s). This flag can be repeated
- disable_early_exit::Bool - Disable 'early exit' optimizations
- disable_indexing::Bool - Disable indexing optimizations
- disable_inlining::AbstractString - Set paths of documents to exclude from inlining
- explain::AbstractString - Enable query explanations
- fail::Bool - Exits with non-zero exit code on undefined/empty result and errors
- fail_defined::Bool - Exits with non-zero exit code on defined/non-empty result and errors
- format::AbstractString - Set output format
- ignore::AbstractString - Set file and directory names to ignore during loading (e.g., '.*' excludes hidden files)
- _import::AbstractString - Set query import(s). This flag can be repeated
- input::AbstractString - Set input file path
- instrument::Bool - Enable query instrumentation metrics (implies --metrics)
- metrics::Bool - Report query performance metrics
- package::AbstractString - Set query package
- partial::Bool - Perform partial evaluation
- pretty_limit::AbstractString - Set limit after which pretty output gets truncated
- profile::Bool - Perform expression profiling
- profile_limit::AbstractString - Set number of profiling results to show
- profile_sort::AbstractString - Set sort order of expression profiler results
- schema::AbstractString - Set schema file path or directory path
- shallow_inlining::Bool - Disable inlining of rules that depend on unknowns
- stdin::Bool - Read query from stdin
- stdin_input::Bool - Read input document from stdin
- strict_builtin_errors::Bool - Treat built-in function errors as fatal
- target::AbstractString - Set the runtime to exercise
- timeout::AbstractString - Set eval timeout (default unlimited)
- unknowns::AbstractString - Set paths to treat as unknown during partial evaluation
- help::Bool - Help for eval
 """
function eval(parent::Cmd; bundle::Union{Nothing,AbstractString} = nothing, capabilities::Union{Nothing,AbstractString} = nothing, count::Union{Nothing,AbstractString} = "1", coverage::Union{Nothing,Bool} = false, data::Union{Nothing,AbstractString} = nothing, disable_early_exit::Union{Nothing,Bool} = false, disable_indexing::Union{Nothing,Bool} = false, disable_inlining::Union{Nothing,AbstractString} = nothing, explain::Union{Nothing,AbstractString} = "off", fail::Union{Nothing,Bool} = false, fail_defined::Union{Nothing,Bool} = false, format::Union{Nothing,AbstractString} = "json", ignore::Union{Nothing,AbstractString} = nothing, _import::Union{Nothing,AbstractString} = nothing, input::Union{Nothing,AbstractString} = nothing, instrument::Union{Nothing,Bool} = false, metrics::Union{Nothing,Bool} = false, package::Union{Nothing,AbstractString} = nothing, partial::Union{Nothing,Bool} = false, pretty_limit::Union{Nothing,AbstractString} = "80", profile::Union{Nothing,Bool} = false, profile_limit::Union{Nothing,AbstractString} = "10", profile_sort::Union{Nothing,AbstractString} = nothing, schema::Union{Nothing,AbstractString} = nothing, shallow_inlining::Union{Nothing,Bool} = false, stdin::Union{Nothing,Bool} = false, stdin_input::Union{Nothing,Bool} = false, strict_builtin_errors::Union{Nothing,Bool} = false, target::Union{Nothing,AbstractString} = "rego", timeout::Union{Nothing,AbstractString} = "0s", unknowns::Union{Nothing,AbstractString} = "[input]", help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) eval`

    if !isnothing(bundle)
        cmd = `$(cmd) --bundle=$(bundle)`
    end

    if !isnothing(capabilities)
        cmd = `$(cmd) --capabilities=$(capabilities)`
    end

    if !isnothing(count)
        cmd = `$(cmd) --count=$(count)`
    end

    if !isnothing(coverage) && coverage
        cmd = `$(cmd) --coverage`
    end

    if !isnothing(data)
        cmd = `$(cmd) --data=$(data)`
    end

    if !isnothing(disable_early_exit) && disable_early_exit
        cmd = `$(cmd) --disable-early-exit`
    end

    if !isnothing(disable_indexing) && disable_indexing
        cmd = `$(cmd) --disable-indexing`
    end

    if !isnothing(disable_inlining)
        cmd = `$(cmd) --disable-inlining=$(disable_inlining)`
    end

    if !isnothing(explain)
        cmd = `$(cmd) --explain=$(explain)`
    end

    if !isnothing(fail) && fail
        cmd = `$(cmd) --fail`
    end

    if !isnothing(fail_defined) && fail_defined
        cmd = `$(cmd) --fail-defined`
    end

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(ignore)
        cmd = `$(cmd) --ignore=$(ignore)`
    end

    if !isnothing(_import)
        cmd = `$(cmd) --import=$(_import)`
    end

    if !isnothing(input)
        cmd = `$(cmd) --input=$(input)`
    end

    if !isnothing(instrument) && instrument
        cmd = `$(cmd) --instrument`
    end

    if !isnothing(metrics) && metrics
        cmd = `$(cmd) --metrics`
    end

    if !isnothing(package)
        cmd = `$(cmd) --package=$(package)`
    end

    if !isnothing(partial) && partial
        cmd = `$(cmd) --partial`
    end

    if !isnothing(pretty_limit)
        cmd = `$(cmd) --pretty-limit=$(pretty_limit)`
    end

    if !isnothing(profile) && profile
        cmd = `$(cmd) --profile`
    end

    if !isnothing(profile_limit)
        cmd = `$(cmd) --profile-limit=$(profile_limit)`
    end

    if !isnothing(profile_sort)
        cmd = `$(cmd) --profile-sort=$(profile_sort)`
    end

    if !isnothing(schema)
        cmd = `$(cmd) --schema=$(schema)`
    end

    if !isnothing(shallow_inlining) && shallow_inlining
        cmd = `$(cmd) --shallow-inlining`
    end

    if !isnothing(stdin) && stdin
        cmd = `$(cmd) --stdin`
    end

    if !isnothing(stdin_input) && stdin_input
        cmd = `$(cmd) --stdin-input`
    end

    if !isnothing(strict_builtin_errors) && strict_builtin_errors
        cmd = `$(cmd) --strict-builtin-errors`
    end

    if !isnothing(target)
        cmd = `$(cmd) --target=$(target)`
    end

    if !isnothing(timeout)
        cmd = `$(cmd) --timeout=$(timeout)`
    end

    if !isnothing(unknowns)
        cmd = `$(cmd) --unknowns=$(unknowns)`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" exec
Run the exec subcommand of opa command.
Execute against input files

Options:
- bundle::AbstractString - Set bundle file(s) or directory path(s). This flag can be repeated
- config_file::AbstractString - Set path of configuration file
- decision::AbstractString - Set decision to evaluate
- format::AbstractString - Set output format
- log_format::AbstractString - Set log format
- log_level::AbstractString - Set log level
- set::AbstractString - Override config values on the command line (use commas to specify multiple values)
- set_file::AbstractString - Override config values with files on the command line (use commas to specify multiple values)
- help::Bool - Help for exec
 """
function exec(parent::Cmd; bundle::Union{Nothing,AbstractString} = nothing, config_file::Union{Nothing,AbstractString} = nothing, decision::Union{Nothing,AbstractString} = nothing, format::Union{Nothing,AbstractString} = "pretty", log_format::Union{Nothing,AbstractString} = "json", log_level::Union{Nothing,AbstractString} = "error", set::Union{Nothing,AbstractString} = nothing, set_file::Union{Nothing,AbstractString} = nothing, help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) exec`

    if !isnothing(bundle)
        cmd = `$(cmd) --bundle=$(bundle)`
    end

    if !isnothing(config_file)
        cmd = `$(cmd) --config-file=$(config_file)`
    end

    if !isnothing(decision)
        cmd = `$(cmd) --decision=$(decision)`
    end

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(log_format)
        cmd = `$(cmd) --log-format=$(log_format)`
    end

    if !isnothing(log_level)
        cmd = `$(cmd) --log-level=$(log_level)`
    end

    if !isnothing(set)
        cmd = `$(cmd) --set=$(set)`
    end

    if !isnothing(set_file)
        cmd = `$(cmd) --set-file=$(set_file)`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" fmt
Run the fmt subcommand of opa command.
Format Rego source files

Options:
- diff::Bool - Only display a diff of the changes
- fail::Bool - Non zero exit code on reformat
- list::Bool - List all files who would change when formatted
- write::Bool - Overwrite the original source file
- help::Bool - Help for fmt
 """
function fmt(parent::Cmd; diff::Union{Nothing,Bool} = false, fail::Union{Nothing,Bool} = false, list::Union{Nothing,Bool} = false, write::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) fmt`

    if !isnothing(diff) && diff
        cmd = `$(cmd) --diff`
    end

    if !isnothing(fail) && fail
        cmd = `$(cmd) --fail`
    end

    if !isnothing(list) && list
        cmd = `$(cmd) --list`
    end

    if !isnothing(write) && write
        cmd = `$(cmd) --write`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" inspect
Run the inspect subcommand of opa command.
Inspect OPA bundle(s)

Options:
- format::AbstractString - Set output format
- help::Bool - Help for inspect
 """
function inspect(parent::Cmd; format::Union{Nothing,AbstractString} = "pretty", help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) inspect`

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" parse
Run the parse subcommand of opa command.
Parse Rego source file

Options:
- format::AbstractString - Set output format
- help::Bool - Help for parse
 """
function parse(parent::Cmd; format::Union{Nothing,AbstractString} = "pretty", help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) parse`

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" run
Run the run subcommand of opa command.
Start OPA in interactive or server mode

Options:
- addr::AbstractString - Set listening address of the server (e.g., [ip]:<port> for TCP, unix://<path> for UNIX domain socket)
- authentication::AbstractString - Set authentication scheme
- authorization::AbstractString - Set authorization scheme
- bundle::Bool - Load paths as bundle files or root directories
- config_file::AbstractString - Set path of configuration file
- diagnostic_addr::AbstractString - Set read-only diagnostic listening address of the server for /health and /metric APIs (e.g., [ip]:<port> for TCP, unix://<path> for UNIX domain socket)
- exclude_files_verify::AbstractString - Set file names to exclude during bundle verification
- format::AbstractString - Set shell output format, i.e, pretty, json
- h2c::Bool - Enable H2C for HTTP listeners
- history::AbstractString - Set path of history file
- ignore::AbstractString - Set file and directory names to ignore during loading (e.g., '.*' excludes hidden files)
- log_format::AbstractString - Set log format
- log_level::AbstractString - Set log level
- max_errors::AbstractString - Set the number of errors to allow before compilation fails early
- min_tls_version::AbstractString - Set minimum TLS version to be used by OPA's server
- pprof::Bool - Enables pprof endpoints
- ready_timeout::AbstractString - Wait (in seconds) for configured plugins before starting server (value <= 0 disables ready check)
- scope::AbstractString - Scope to use for bundle signature verification
- server::Bool - Start the runtime in server mode
- set::AbstractString - Override config values on the command line (use commas to specify multiple values)
- set_file::AbstractString - Override config values with files on the command line (use commas to specify multiple values)
- shutdown_grace_period::AbstractString - Set the time (in seconds) that the server will wait to gracefully shut down
- shutdown_wait_period::AbstractString - Set the time (in seconds) that the server will wait before initiating shutdown
- signing_alg::AbstractString - Name of the signing algorithm
- skip_verify::Bool - Disables bundle signature verification
- skip_version_check::Bool - Disables anonymous version reporting (see: https://openpolicyagent.org/docs/latest/privacy)
- tls_ca_cert_file::AbstractString - Set path of TLS CA cert file
- tls_cert_file::AbstractString - Set path of TLS certificate file
- tls_cert_refresh_period::AbstractString - Set certificate refresh period
- tls_private_key_file::AbstractString - Set path of TLS private key file
- verification_key::AbstractString - Set the secret (HMAC) or path of the PEM file containing the public key (RSA and ECDSA)
- verification_key_id::AbstractString - Name assigned to the verification key used for bundle verification
- watch::Bool - Watch command line files for changes
- help::Bool - Help for run
 """
function run(parent::Cmd; addr::Union{Nothing,AbstractString} = "[:8181]", authentication::Union{Nothing,AbstractString} = "off", authorization::Union{Nothing,AbstractString} = "off", bundle::Union{Nothing,Bool} = false, config_file::Union{Nothing,AbstractString} = nothing, diagnostic_addr::Union{Nothing,AbstractString} = nothing, exclude_files_verify::Union{Nothing,AbstractString} = nothing, format::Union{Nothing,AbstractString} = "pretty", h2c::Union{Nothing,Bool} = false, history::Union{Nothing,AbstractString} = nothing, ignore::Union{Nothing,AbstractString} = nothing, log_format::Union{Nothing,AbstractString} = "json", log_level::Union{Nothing,AbstractString} = "info", max_errors::Union{Nothing,AbstractString} = "10", min_tls_version::Union{Nothing,AbstractString} = "1.2", pprof::Union{Nothing,Bool} = false, ready_timeout::Union{Nothing,AbstractString} = "0", scope::Union{Nothing,AbstractString} = nothing, server::Union{Nothing,Bool} = false, set::Union{Nothing,AbstractString} = nothing, set_file::Union{Nothing,AbstractString} = nothing, shutdown_grace_period::Union{Nothing,AbstractString} = "10", shutdown_wait_period::Union{Nothing,AbstractString} = "0", signing_alg::Union{Nothing,AbstractString} = "RS256", skip_verify::Union{Nothing,Bool} = false, skip_version_check::Union{Nothing,Bool} = false, tls_ca_cert_file::Union{Nothing,AbstractString} = nothing, tls_cert_file::Union{Nothing,AbstractString} = nothing, tls_cert_refresh_period::Union{Nothing,AbstractString} = "0s", tls_private_key_file::Union{Nothing,AbstractString} = nothing, verification_key::Union{Nothing,AbstractString} = nothing, verification_key_id::Union{Nothing,AbstractString} = "default", watch::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) run`

    if !isnothing(addr)
        cmd = `$(cmd) --addr=$(addr)`
    end

    if !isnothing(authentication)
        cmd = `$(cmd) --authentication=$(authentication)`
    end

    if !isnothing(authorization)
        cmd = `$(cmd) --authorization=$(authorization)`
    end

    if !isnothing(bundle) && bundle
        cmd = `$(cmd) --bundle`
    end

    if !isnothing(config_file)
        cmd = `$(cmd) --config-file=$(config_file)`
    end

    if !isnothing(diagnostic_addr)
        cmd = `$(cmd) --diagnostic-addr=$(diagnostic_addr)`
    end

    if !isnothing(exclude_files_verify)
        cmd = `$(cmd) --exclude-files-verify=$(exclude_files_verify)`
    end

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(h2c) && h2c
        cmd = `$(cmd) --h2c`
    end

    if !isnothing(history)
        cmd = `$(cmd) --history=$(history)`
    end

    if !isnothing(ignore)
        cmd = `$(cmd) --ignore=$(ignore)`
    end

    if !isnothing(log_format)
        cmd = `$(cmd) --log-format=$(log_format)`
    end

    if !isnothing(log_level)
        cmd = `$(cmd) --log-level=$(log_level)`
    end

    if !isnothing(max_errors)
        cmd = `$(cmd) --max-errors=$(max_errors)`
    end

    if !isnothing(min_tls_version)
        cmd = `$(cmd) --min-tls-version=$(min_tls_version)`
    end

    if !isnothing(pprof) && pprof
        cmd = `$(cmd) --pprof`
    end

    if !isnothing(ready_timeout)
        cmd = `$(cmd) --ready-timeout=$(ready_timeout)`
    end

    if !isnothing(scope)
        cmd = `$(cmd) --scope=$(scope)`
    end

    if !isnothing(server) && server
        cmd = `$(cmd) --server`
    end

    if !isnothing(set)
        cmd = `$(cmd) --set=$(set)`
    end

    if !isnothing(set_file)
        cmd = `$(cmd) --set-file=$(set_file)`
    end

    if !isnothing(shutdown_grace_period)
        cmd = `$(cmd) --shutdown-grace-period=$(shutdown_grace_period)`
    end

    if !isnothing(shutdown_wait_period)
        cmd = `$(cmd) --shutdown-wait-period=$(shutdown_wait_period)`
    end

    if !isnothing(signing_alg)
        cmd = `$(cmd) --signing-alg=$(signing_alg)`
    end

    if !isnothing(skip_verify) && skip_verify
        cmd = `$(cmd) --skip-verify`
    end

    if !isnothing(skip_version_check) && skip_version_check
        cmd = `$(cmd) --skip-version-check`
    end

    if !isnothing(tls_ca_cert_file)
        cmd = `$(cmd) --tls-ca-cert-file=$(tls_ca_cert_file)`
    end

    if !isnothing(tls_cert_file)
        cmd = `$(cmd) --tls-cert-file=$(tls_cert_file)`
    end

    if !isnothing(tls_cert_refresh_period)
        cmd = `$(cmd) --tls-cert-refresh-period=$(tls_cert_refresh_period)`
    end

    if !isnothing(tls_private_key_file)
        cmd = `$(cmd) --tls-private-key-file=$(tls_private_key_file)`
    end

    if !isnothing(verification_key)
        cmd = `$(cmd) --verification-key=$(verification_key)`
    end

    if !isnothing(verification_key_id)
        cmd = `$(cmd) --verification-key-id=$(verification_key_id)`
    end

    if !isnothing(watch) && watch
        cmd = `$(cmd) --watch`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" sign
Run the sign subcommand of opa command.
Generate an OPA bundle signature

Options:
- bundle::Bool - Load paths as bundle files or root directories
- claims_file::AbstractString - Set path of JSON file containing optional claims (see: https://openpolicyagent.org/docs/latest/management/#signature-format)
- output_file_path::AbstractString - Set the location for the .signatures.json file
- signing_alg::AbstractString - Name of the signing algorithm
- signing_key::AbstractString - Set the secret (HMAC) or path of the PEM file containing the private key (RSA and ECDSA)
- signing_plugin::AbstractString - Name of the plugin to use for signing/verification (see https://openpolicyagent.org/docs/latest/management/#signature-plugin
- help::Bool - Help for sign
 """
function sign(parent::Cmd; bundle::Union{Nothing,Bool} = false, claims_file::Union{Nothing,AbstractString} = nothing, output_file_path::Union{Nothing,AbstractString} = ".", signing_alg::Union{Nothing,AbstractString} = "RS256", signing_key::Union{Nothing,AbstractString} = nothing, signing_plugin::Union{Nothing,AbstractString} = nothing, help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) sign`

    if !isnothing(bundle) && bundle
        cmd = `$(cmd) --bundle`
    end

    if !isnothing(claims_file)
        cmd = `$(cmd) --claims-file=$(claims_file)`
    end

    if !isnothing(output_file_path)
        cmd = `$(cmd) --output-file-path=$(output_file_path)`
    end

    if !isnothing(signing_alg)
        cmd = `$(cmd) --signing-alg=$(signing_alg)`
    end

    if !isnothing(signing_key)
        cmd = `$(cmd) --signing-key=$(signing_key)`
    end

    if !isnothing(signing_plugin)
        cmd = `$(cmd) --signing-plugin=$(signing_plugin)`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" test
Run the test subcommand of opa command.
Execute Rego test cases

Options:
- bench::Bool - Benchmark the unit tests
- benchmem::Bool - Report memory allocations with benchmark results
- bundle::Bool - Load paths as bundle files or root directories
- count::AbstractString - Number of times to repeat each test
- coverage::Bool - Report coverage (overrides debug tracing)
- exit_zero_on_skipped::Bool - Skipped tests return status 0
- explain::AbstractString - Enable query explanations
- format::AbstractString - Set output format
- ignore::AbstractString - Set file and directory names to ignore during loading (e.g., '.*' excludes hidden files)
- max_errors::AbstractString - Set the number of errors to allow before compilation fails early
- run::AbstractString - Run only test cases matching the regular expression
- show_failure_line::Bool - Show test failure line
- target::AbstractString - Set the runtime to exercise
- threshold::AbstractString - Set coverage threshold and exit with non-zero status if coverage is less than threshold %
- timeout::AbstractString - Set test timeout (default 5s, 30s when benchmarking)
- verbose::Bool - Set verbose reporting mode
- help::Bool - Help for test
 """
function test(parent::Cmd; bench::Union{Nothing,Bool} = false, benchmem::Union{Nothing,Bool} = false, bundle::Union{Nothing,Bool} = false, count::Union{Nothing,AbstractString} = "1", coverage::Union{Nothing,Bool} = false, exit_zero_on_skipped::Union{Nothing,Bool} = false, explain::Union{Nothing,AbstractString} = "fails", format::Union{Nothing,AbstractString} = "pretty", ignore::Union{Nothing,AbstractString} = nothing, max_errors::Union{Nothing,AbstractString} = "10", run::Union{Nothing,AbstractString} = nothing, show_failure_line::Union{Nothing,Bool} = false, target::Union{Nothing,AbstractString} = "rego", threshold::Union{Nothing,AbstractString} = "0", timeout::Union{Nothing,AbstractString} = "0s", verbose::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) test`

    if !isnothing(bench) && bench
        cmd = `$(cmd) --bench`
    end

    if !isnothing(benchmem) && benchmem
        cmd = `$(cmd) --benchmem`
    end

    if !isnothing(bundle) && bundle
        cmd = `$(cmd) --bundle`
    end

    if !isnothing(count)
        cmd = `$(cmd) --count=$(count)`
    end

    if !isnothing(coverage) && coverage
        cmd = `$(cmd) --coverage`
    end

    if !isnothing(exit_zero_on_skipped) && exit_zero_on_skipped
        cmd = `$(cmd) --exit-zero-on-skipped`
    end

    if !isnothing(explain)
        cmd = `$(cmd) --explain=$(explain)`
    end

    if !isnothing(format)
        cmd = `$(cmd) --format=$(format)`
    end

    if !isnothing(ignore)
        cmd = `$(cmd) --ignore=$(ignore)`
    end

    if !isnothing(max_errors)
        cmd = `$(cmd) --max-errors=$(max_errors)`
    end

    if !isnothing(run)
        cmd = `$(cmd) --run=$(run)`
    end

    if !isnothing(show_failure_line) && show_failure_line
        cmd = `$(cmd) --show-failure-line`
    end

    if !isnothing(target)
        cmd = `$(cmd) --target=$(target)`
    end

    if !isnothing(threshold)
        cmd = `$(cmd) --threshold=$(threshold)`
    end

    if !isnothing(timeout)
        cmd = `$(cmd) --timeout=$(timeout)`
    end

    if !isnothing(verbose) && verbose
        cmd = `$(cmd) --verbose`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" version
Run the version subcommand of opa command.
Print the version of OPA

Options:
- check::Bool - Check for latest OPA release
- help::Bool - Help for version
 """
function version(parent::Cmd; check::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) version`

    if !isnothing(check) && check
        cmd = `$(cmd) --check`
    end

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

""" help
Run the help subcommand of opa command.
Help about any command

Options:
- help::Bool - Help for help
 """
function help(parent::Cmd; help::Union{Nothing,Bool} = false, )
    parentcmd = opa()
    cmd = `$(parentcmd) help`

    if !isnothing(help) && help
        cmd = `$(cmd) --help`
    end

    return cmd
end

end # module CLI

