"""
CLI for opa.
Open Policy Agent (OPA)

Generated via FigCLIGen. Do not edit directly.
Edit the specification file and run the generator instead.
"""
module CLI

const OptsType = Base.Dict{Base.Symbol,Base.Any}

"""
CommandLine execution context.

`exec`: a no argument function that provides the base command to execute in a julia `do` block.
`cmdopts`: keyword arguments that should be used to further customize the `Cmd` creation
`pipelineopts`: keyword arguments that should be used to further customize the `pipeline` creation
"""
Base.@kwdef struct CommandLine
    exec::Base.Function = ()->`opa`
    cmdopts::OptsType = OptsType()
    pipelineopts::OptsType = OptsType()
    runopts::OptsType = OptsType()
end

""" opa
Run the opa command.
Open Policy Agent (OPA)

Options:
- help::Bool - Help for opa
 """
function opa(ctx::CommandLine, _args...; help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr]
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
function bench(ctx::CommandLine, _args...; benchmem::Union{Nothing,Bool} = false, bundle::Union{Nothing,AbstractString} = nothing, count::Union{Nothing,AbstractString} = "1", data::Union{Nothing,AbstractString} = nothing, fail::Union{Nothing,Bool} = false, format::Union{Nothing,AbstractString} = "pretty", ignore::Union{Nothing,AbstractString} = nothing, _import::Union{Nothing,AbstractString} = nothing, input::Union{Nothing,AbstractString} = nothing, metrics::Union{Nothing,Bool} = false, package::Union{Nothing,AbstractString} = nothing, partial::Union{Nothing,Bool} = false, schema::Union{Nothing,AbstractString} = nothing, stdin::Union{Nothing,Bool} = false, stdin_input::Union{Nothing,Bool} = false, target::Union{Nothing,AbstractString} = "rego", unknowns::Union{Nothing,AbstractString} = "[input]", help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "bench"]
        !Base.isnothing(benchmem) && benchmem && Base.push!(cmd, "--benchmem")
        Base.isnothing(bundle) || Base.push!(cmd, "--bundle=$(bundle)")
        Base.isnothing(count) || Base.push!(cmd, "--count=$(count)")
        Base.isnothing(data) || Base.push!(cmd, "--data=$(data)")
        !Base.isnothing(fail) && fail && Base.push!(cmd, "--fail")
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        Base.isnothing(ignore) || Base.push!(cmd, "--ignore=$(ignore)")
        Base.isnothing(_import) || Base.push!(cmd, "--import=$(_import)")
        Base.isnothing(input) || Base.push!(cmd, "--input=$(input)")
        !Base.isnothing(metrics) && metrics && Base.push!(cmd, "--metrics")
        Base.isnothing(package) || Base.push!(cmd, "--package=$(package)")
        !Base.isnothing(partial) && partial && Base.push!(cmd, "--partial")
        Base.isnothing(schema) || Base.push!(cmd, "--schema=$(schema)")
        !Base.isnothing(stdin) && stdin && Base.push!(cmd, "--stdin")
        !Base.isnothing(stdin_input) && stdin_input && Base.push!(cmd, "--stdin-input")
        Base.isnothing(target) || Base.push!(cmd, "--target=$(target)")
        Base.isnothing(unknowns) || Base.push!(cmd, "--unknowns=$(unknowns)")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
function build(ctx::CommandLine, _args...; bundle::Union{Nothing,Bool} = false, capabilities::Union{Nothing,AbstractString} = nothing, claims_file::Union{Nothing,AbstractString} = nothing, debug::Union{Nothing,Bool} = false, entrypoint::Union{Nothing,AbstractString} = nothing, exclude_files_verify::Union{Nothing,AbstractString} = nothing, ignore::Union{Nothing,AbstractString} = nothing, optimize::Union{Nothing,AbstractString} = "0", output::Union{Nothing,AbstractString} = "bundle.tar.gz", revision::Union{Nothing,AbstractString} = nothing, scope::Union{Nothing,AbstractString} = nothing, signing_alg::Union{Nothing,AbstractString} = "RS256", signing_key::Union{Nothing,AbstractString} = nothing, signing_plugin::Union{Nothing,AbstractString} = nothing, target::Union{Nothing,AbstractString} = "rego", verification_key::Union{Nothing,AbstractString} = nothing, verification_key_id::Union{Nothing,AbstractString} = "default", help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "build"]
        !Base.isnothing(bundle) && bundle && Base.push!(cmd, "--bundle")
        Base.isnothing(capabilities) || Base.push!(cmd, "--capabilities=$(capabilities)")
        Base.isnothing(claims_file) || Base.push!(cmd, "--claims-file=$(claims_file)")
        !Base.isnothing(debug) && debug && Base.push!(cmd, "--debug")
        Base.isnothing(entrypoint) || Base.push!(cmd, "--entrypoint=$(entrypoint)")
        Base.isnothing(exclude_files_verify) || Base.push!(cmd, "--exclude-files-verify=$(exclude_files_verify)")
        Base.isnothing(ignore) || Base.push!(cmd, "--ignore=$(ignore)")
        Base.isnothing(optimize) || Base.push!(cmd, "--optimize=$(optimize)")
        Base.isnothing(output) || Base.push!(cmd, "--output=$(output)")
        Base.isnothing(revision) || Base.push!(cmd, "--revision=$(revision)")
        Base.isnothing(scope) || Base.push!(cmd, "--scope=$(scope)")
        Base.isnothing(signing_alg) || Base.push!(cmd, "--signing-alg=$(signing_alg)")
        Base.isnothing(signing_key) || Base.push!(cmd, "--signing-key=$(signing_key)")
        Base.isnothing(signing_plugin) || Base.push!(cmd, "--signing-plugin=$(signing_plugin)")
        Base.isnothing(target) || Base.push!(cmd, "--target=$(target)")
        Base.isnothing(verification_key) || Base.push!(cmd, "--verification-key=$(verification_key)")
        Base.isnothing(verification_key_id) || Base.push!(cmd, "--verification-key-id=$(verification_key_id)")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
function check(ctx::CommandLine, _args...; bundle::Union{Nothing,Bool} = false, capabilities::Union{Nothing,AbstractString} = nothing, format::Union{Nothing,AbstractString} = "pretty", ignore::Union{Nothing,AbstractString} = nothing, max_errors::Union{Nothing,AbstractString} = "10", schema::Union{Nothing,AbstractString} = nothing, strict::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "check"]
        !Base.isnothing(bundle) && bundle && Base.push!(cmd, "--bundle")
        Base.isnothing(capabilities) || Base.push!(cmd, "--capabilities=$(capabilities)")
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        Base.isnothing(ignore) || Base.push!(cmd, "--ignore=$(ignore)")
        Base.isnothing(max_errors) || Base.push!(cmd, "--max-errors=$(max_errors)")
        Base.isnothing(schema) || Base.push!(cmd, "--schema=$(schema)")
        !Base.isnothing(strict) && strict && Base.push!(cmd, "--strict")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
end

""" completion
Run the completion subcommand of opa command.
Generate the autocompletion script for the specified shell

Options:
- help::Bool - Help for completion
 """
function completion(ctx::CommandLine, _args...; help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "completion"]
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
function deps(ctx::CommandLine, _args...; bundle::Union{Nothing,AbstractString} = nothing, data::Union{Nothing,AbstractString} = nothing, format::Union{Nothing,AbstractString} = "pretty", ignore::Union{Nothing,AbstractString} = nothing, help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "deps"]
        Base.isnothing(bundle) || Base.push!(cmd, "--bundle=$(bundle)")
        Base.isnothing(data) || Base.push!(cmd, "--data=$(data)")
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        Base.isnothing(ignore) || Base.push!(cmd, "--ignore=$(ignore)")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
end

""" evaluate
Run the evaluate subcommand of opa command.
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
function evaluate(ctx::CommandLine, _args...; bundle::Union{Nothing,AbstractString} = nothing, capabilities::Union{Nothing,AbstractString} = nothing, count::Union{Nothing,AbstractString} = "1", coverage::Union{Nothing,Bool} = false, data::Union{Nothing,AbstractString} = nothing, disable_early_exit::Union{Nothing,Bool} = false, disable_indexing::Union{Nothing,Bool} = false, disable_inlining::Union{Nothing,AbstractString} = nothing, explain::Union{Nothing,AbstractString} = "off", fail::Union{Nothing,Bool} = false, fail_defined::Union{Nothing,Bool} = false, format::Union{Nothing,AbstractString} = "json", ignore::Union{Nothing,AbstractString} = nothing, _import::Union{Nothing,AbstractString} = nothing, input::Union{Nothing,AbstractString} = nothing, instrument::Union{Nothing,Bool} = false, metrics::Union{Nothing,Bool} = false, package::Union{Nothing,AbstractString} = nothing, partial::Union{Nothing,Bool} = false, pretty_limit::Union{Nothing,AbstractString} = "80", profile::Union{Nothing,Bool} = false, profile_limit::Union{Nothing,AbstractString} = "10", profile_sort::Union{Nothing,AbstractString} = nothing, schema::Union{Nothing,AbstractString} = nothing, shallow_inlining::Union{Nothing,Bool} = false, stdin::Union{Nothing,Bool} = false, stdin_input::Union{Nothing,Bool} = false, strict_builtin_errors::Union{Nothing,Bool} = false, target::Union{Nothing,AbstractString} = "rego", timeout::Union{Nothing,AbstractString} = "0s", unknowns::Union{Nothing,AbstractString} = "[input]", help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "evaluate"]
        Base.isnothing(bundle) || Base.push!(cmd, "--bundle=$(bundle)")
        Base.isnothing(capabilities) || Base.push!(cmd, "--capabilities=$(capabilities)")
        Base.isnothing(count) || Base.push!(cmd, "--count=$(count)")
        !Base.isnothing(coverage) && coverage && Base.push!(cmd, "--coverage")
        Base.isnothing(data) || Base.push!(cmd, "--data=$(data)")
        !Base.isnothing(disable_early_exit) && disable_early_exit && Base.push!(cmd, "--disable-early-exit")
        !Base.isnothing(disable_indexing) && disable_indexing && Base.push!(cmd, "--disable-indexing")
        Base.isnothing(disable_inlining) || Base.push!(cmd, "--disable-inlining=$(disable_inlining)")
        Base.isnothing(explain) || Base.push!(cmd, "--explain=$(explain)")
        !Base.isnothing(fail) && fail && Base.push!(cmd, "--fail")
        !Base.isnothing(fail_defined) && fail_defined && Base.push!(cmd, "--fail-defined")
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        Base.isnothing(ignore) || Base.push!(cmd, "--ignore=$(ignore)")
        Base.isnothing(_import) || Base.push!(cmd, "--import=$(_import)")
        Base.isnothing(input) || Base.push!(cmd, "--input=$(input)")
        !Base.isnothing(instrument) && instrument && Base.push!(cmd, "--instrument")
        !Base.isnothing(metrics) && metrics && Base.push!(cmd, "--metrics")
        Base.isnothing(package) || Base.push!(cmd, "--package=$(package)")
        !Base.isnothing(partial) && partial && Base.push!(cmd, "--partial")
        Base.isnothing(pretty_limit) || Base.push!(cmd, "--pretty-limit=$(pretty_limit)")
        !Base.isnothing(profile) && profile && Base.push!(cmd, "--profile")
        Base.isnothing(profile_limit) || Base.push!(cmd, "--profile-limit=$(profile_limit)")
        Base.isnothing(profile_sort) || Base.push!(cmd, "--profile-sort=$(profile_sort)")
        Base.isnothing(schema) || Base.push!(cmd, "--schema=$(schema)")
        !Base.isnothing(shallow_inlining) && shallow_inlining && Base.push!(cmd, "--shallow-inlining")
        !Base.isnothing(stdin) && stdin && Base.push!(cmd, "--stdin")
        !Base.isnothing(stdin_input) && stdin_input && Base.push!(cmd, "--stdin-input")
        !Base.isnothing(strict_builtin_errors) && strict_builtin_errors && Base.push!(cmd, "--strict-builtin-errors")
        Base.isnothing(target) || Base.push!(cmd, "--target=$(target)")
        Base.isnothing(timeout) || Base.push!(cmd, "--timeout=$(timeout)")
        Base.isnothing(unknowns) || Base.push!(cmd, "--unknowns=$(unknowns)")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
function exec(ctx::CommandLine, _args...; bundle::Union{Nothing,AbstractString} = nothing, config_file::Union{Nothing,AbstractString} = nothing, decision::Union{Nothing,AbstractString} = nothing, format::Union{Nothing,AbstractString} = "pretty", log_format::Union{Nothing,AbstractString} = "json", log_level::Union{Nothing,AbstractString} = "error", set::Union{Nothing,AbstractString} = nothing, set_file::Union{Nothing,AbstractString} = nothing, help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "exec"]
        Base.isnothing(bundle) || Base.push!(cmd, "--bundle=$(bundle)")
        Base.isnothing(config_file) || Base.push!(cmd, "--config-file=$(config_file)")
        Base.isnothing(decision) || Base.push!(cmd, "--decision=$(decision)")
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        Base.isnothing(log_format) || Base.push!(cmd, "--log-format=$(log_format)")
        Base.isnothing(log_level) || Base.push!(cmd, "--log-level=$(log_level)")
        Base.isnothing(set) || Base.push!(cmd, "--set=$(set)")
        Base.isnothing(set_file) || Base.push!(cmd, "--set-file=$(set_file)")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
function fmt(ctx::CommandLine, _args...; diff::Union{Nothing,Bool} = false, fail::Union{Nothing,Bool} = false, list::Union{Nothing,Bool} = false, write::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "fmt"]
        !Base.isnothing(diff) && diff && Base.push!(cmd, "--diff")
        !Base.isnothing(fail) && fail && Base.push!(cmd, "--fail")
        !Base.isnothing(list) && list && Base.push!(cmd, "--list")
        !Base.isnothing(write) && write && Base.push!(cmd, "--write")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
end

""" inspect
Run the inspect subcommand of opa command.
Inspect OPA bundle(s)

Options:
- format::AbstractString - Set output format
- help::Bool - Help for inspect
 """
function inspect(ctx::CommandLine, _args...; format::Union{Nothing,AbstractString} = "pretty", help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "inspect"]
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
end

""" parse
Run the parse subcommand of opa command.
Parse Rego source file

Options:
- format::AbstractString - Set output format
- help::Bool - Help for parse
 """
function parse(ctx::CommandLine, _args...; format::Union{Nothing,AbstractString} = "pretty", help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "parse"]
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
- v1_compatible::Bool - Opt-in to OPA features and behaviors that will be enabled by default in a future OPA v1.0 release
- verification_key::AbstractString - Set the secret (HMAC) or path of the PEM file containing the public key (RSA and ECDSA)
- verification_key_id::AbstractString - Name assigned to the verification key used for bundle verification
- watch::Bool - Watch command line files for changes
- help::Bool - Help for run
 """
function run(ctx::CommandLine, _args...; addr::Union{Nothing,AbstractString} = "[:8181]", authentication::Union{Nothing,AbstractString} = "off", authorization::Union{Nothing,AbstractString} = "off", bundle::Union{Nothing,Bool} = false, config_file::Union{Nothing,AbstractString} = nothing, diagnostic_addr::Union{Nothing,AbstractString} = nothing, exclude_files_verify::Union{Nothing,AbstractString} = nothing, format::Union{Nothing,AbstractString} = "pretty", h2c::Union{Nothing,Bool} = false, history::Union{Nothing,AbstractString} = nothing, ignore::Union{Nothing,AbstractString} = nothing, log_format::Union{Nothing,AbstractString} = "json", log_level::Union{Nothing,AbstractString} = "info", max_errors::Union{Nothing,AbstractString} = "10", min_tls_version::Union{Nothing,AbstractString} = "1.2", pprof::Union{Nothing,Bool} = false, ready_timeout::Union{Nothing,AbstractString} = "0", scope::Union{Nothing,AbstractString} = nothing, server::Union{Nothing,Bool} = false, set::Union{Nothing,AbstractString} = nothing, set_file::Union{Nothing,AbstractString} = nothing, shutdown_grace_period::Union{Nothing,AbstractString} = "10", shutdown_wait_period::Union{Nothing,AbstractString} = "0", signing_alg::Union{Nothing,AbstractString} = "RS256", skip_verify::Union{Nothing,Bool} = false, skip_version_check::Union{Nothing,Bool} = false, tls_ca_cert_file::Union{Nothing,AbstractString} = nothing, tls_cert_file::Union{Nothing,AbstractString} = nothing, tls_cert_refresh_period::Union{Nothing,AbstractString} = "0s", tls_private_key_file::Union{Nothing,AbstractString} = nothing, v1_compatible::Union{Nothing,Bool} = false, verification_key::Union{Nothing,AbstractString} = nothing, verification_key_id::Union{Nothing,AbstractString} = "default", watch::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "run"]
        Base.isnothing(addr) || Base.push!(cmd, "--addr=$(addr)")
        Base.isnothing(authentication) || Base.push!(cmd, "--authentication=$(authentication)")
        Base.isnothing(authorization) || Base.push!(cmd, "--authorization=$(authorization)")
        !Base.isnothing(bundle) && bundle && Base.push!(cmd, "--bundle")
        Base.isnothing(config_file) || Base.push!(cmd, "--config-file=$(config_file)")
        Base.isnothing(diagnostic_addr) || Base.push!(cmd, "--diagnostic-addr=$(diagnostic_addr)")
        Base.isnothing(exclude_files_verify) || Base.push!(cmd, "--exclude-files-verify=$(exclude_files_verify)")
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        !Base.isnothing(h2c) && h2c && Base.push!(cmd, "--h2c")
        Base.isnothing(history) || Base.push!(cmd, "--history=$(history)")
        Base.isnothing(ignore) || Base.push!(cmd, "--ignore=$(ignore)")
        Base.isnothing(log_format) || Base.push!(cmd, "--log-format=$(log_format)")
        Base.isnothing(log_level) || Base.push!(cmd, "--log-level=$(log_level)")
        Base.isnothing(max_errors) || Base.push!(cmd, "--max-errors=$(max_errors)")
        Base.isnothing(min_tls_version) || Base.push!(cmd, "--min-tls-version=$(min_tls_version)")
        !Base.isnothing(pprof) && pprof && Base.push!(cmd, "--pprof")
        Base.isnothing(ready_timeout) || Base.push!(cmd, "--ready-timeout=$(ready_timeout)")
        Base.isnothing(scope) || Base.push!(cmd, "--scope=$(scope)")
        !Base.isnothing(server) && server && Base.push!(cmd, "--server")
        Base.isnothing(set) || Base.push!(cmd, "--set=$(set)")
        Base.isnothing(set_file) || Base.push!(cmd, "--set-file=$(set_file)")
        Base.isnothing(shutdown_grace_period) || Base.push!(cmd, "--shutdown-grace-period=$(shutdown_grace_period)")
        Base.isnothing(shutdown_wait_period) || Base.push!(cmd, "--shutdown-wait-period=$(shutdown_wait_period)")
        Base.isnothing(signing_alg) || Base.push!(cmd, "--signing-alg=$(signing_alg)")
        !Base.isnothing(skip_verify) && skip_verify && Base.push!(cmd, "--skip-verify")
        !Base.isnothing(skip_version_check) && skip_version_check && Base.push!(cmd, "--skip-version-check")
        Base.isnothing(tls_ca_cert_file) || Base.push!(cmd, "--tls-ca-cert-file=$(tls_ca_cert_file)")
        Base.isnothing(tls_cert_file) || Base.push!(cmd, "--tls-cert-file=$(tls_cert_file)")
        Base.isnothing(tls_cert_refresh_period) || Base.push!(cmd, "--tls-cert-refresh-period=$(tls_cert_refresh_period)")
        Base.isnothing(tls_private_key_file) || Base.push!(cmd, "--tls-private-key-file=$(tls_private_key_file)")
        !Base.isnothing(v1_compatible) && v1_compatible && Base.push!(cmd, "--v1-compatible")
        Base.isnothing(verification_key) || Base.push!(cmd, "--verification-key=$(verification_key)")
        Base.isnothing(verification_key_id) || Base.push!(cmd, "--verification-key-id=$(verification_key_id)")
        !Base.isnothing(watch) && watch && Base.push!(cmd, "--watch")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
function sign(ctx::CommandLine, _args...; bundle::Union{Nothing,Bool} = false, claims_file::Union{Nothing,AbstractString} = nothing, output_file_path::Union{Nothing,AbstractString} = ".", signing_alg::Union{Nothing,AbstractString} = "RS256", signing_key::Union{Nothing,AbstractString} = nothing, signing_plugin::Union{Nothing,AbstractString} = nothing, help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "sign"]
        !Base.isnothing(bundle) && bundle && Base.push!(cmd, "--bundle")
        Base.isnothing(claims_file) || Base.push!(cmd, "--claims-file=$(claims_file)")
        Base.isnothing(output_file_path) || Base.push!(cmd, "--output-file-path=$(output_file_path)")
        Base.isnothing(signing_alg) || Base.push!(cmd, "--signing-alg=$(signing_alg)")
        Base.isnothing(signing_key) || Base.push!(cmd, "--signing-key=$(signing_key)")
        Base.isnothing(signing_plugin) || Base.push!(cmd, "--signing-plugin=$(signing_plugin)")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
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
function test(ctx::CommandLine, _args...; bench::Union{Nothing,Bool} = false, benchmem::Union{Nothing,Bool} = false, bundle::Union{Nothing,Bool} = false, count::Union{Nothing,AbstractString} = "1", coverage::Union{Nothing,Bool} = false, exit_zero_on_skipped::Union{Nothing,Bool} = false, explain::Union{Nothing,AbstractString} = "fails", format::Union{Nothing,AbstractString} = "pretty", ignore::Union{Nothing,AbstractString} = nothing, max_errors::Union{Nothing,AbstractString} = "10", run::Union{Nothing,AbstractString} = nothing, show_failure_line::Union{Nothing,Bool} = false, target::Union{Nothing,AbstractString} = "rego", threshold::Union{Nothing,AbstractString} = "0", timeout::Union{Nothing,AbstractString} = "0s", verbose::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "test"]
        !Base.isnothing(bench) && bench && Base.push!(cmd, "--bench")
        !Base.isnothing(benchmem) && benchmem && Base.push!(cmd, "--benchmem")
        !Base.isnothing(bundle) && bundle && Base.push!(cmd, "--bundle")
        Base.isnothing(count) || Base.push!(cmd, "--count=$(count)")
        !Base.isnothing(coverage) && coverage && Base.push!(cmd, "--coverage")
        !Base.isnothing(exit_zero_on_skipped) && exit_zero_on_skipped && Base.push!(cmd, "--exit-zero-on-skipped")
        Base.isnothing(explain) || Base.push!(cmd, "--explain=$(explain)")
        Base.isnothing(format) || Base.push!(cmd, "--format=$(format)")
        Base.isnothing(ignore) || Base.push!(cmd, "--ignore=$(ignore)")
        Base.isnothing(max_errors) || Base.push!(cmd, "--max-errors=$(max_errors)")
        Base.isnothing(run) || Base.push!(cmd, "--run=$(run)")
        !Base.isnothing(show_failure_line) && show_failure_line && Base.push!(cmd, "--show-failure-line")
        Base.isnothing(target) || Base.push!(cmd, "--target=$(target)")
        Base.isnothing(threshold) || Base.push!(cmd, "--threshold=$(threshold)")
        Base.isnothing(timeout) || Base.push!(cmd, "--timeout=$(timeout)")
        !Base.isnothing(verbose) && verbose && Base.push!(cmd, "--verbose")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
end

""" version
Run the version subcommand of opa command.
Print the version of OPA

Options:
- check::Bool - Check for latest OPA release
- help::Bool - Help for version
 """
function version(ctx::CommandLine, _args...; check::Union{Nothing,Bool} = false, help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "version"]
        !Base.isnothing(check) && check && Base.push!(cmd, "--check")
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
end

""" help
Run the help subcommand of opa command.
Help about any command

Options:
- help::Bool - Help for help
 """
function help(ctx::CommandLine, _args...; help::Union{Nothing,Bool} = false, )
    ctx.exec() do cmdstr
        cmd = [cmdstr, "help"]
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
end

end # module CLI

