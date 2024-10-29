module Server

import ..CLI
import ..CLI: CommandLine
import Base: Process

const DEFAULT_PORT = 8181

"""
    MonitoredOPAServer(
        cmdline::CommandLine,
        configfile::String;
        host::String = "localhost",
        port::Int = DEFAULT_PORT,
        stdout = nothing,
        stderr = nothing,
    )

A server that is monitored and restarted if it dies.

Arguments:
- `cmdline`: The `CLI.CommandLine` instrance that wraps an opa executable.
- `configfile`: The path to the OPA configuration file.

Keyword arguments:
- `host`: The host to bind to.
- `port`: The port to bind to.
- `stdout`: The stream or file to redirect stdout to.
- `stderr`: The stream or file to redirect stderr to.
"""
struct MonitoredOPAServer
    configfile::String
    host::String
    port::Int
    stdout::Any
    stderr::Any
    cmdline::CommandLine
    monitor_task::Ref{Union{Nothing, Task}}
    server_proc::Ref{Union{Nothing, Process}}
    stopped::Ref{Bool}
    lck::ReentrantLock

    function MonitoredOPAServer(
        cmdline::CommandLine,
        configfile::String;
        host::String = "localhost",
        port::Int = DEFAULT_PORT,
        stdout = nothing,
        stderr = nothing,
    )
        cmdline.runopts[:wait] = false

        return new(configfile,
            host, port,
            stdout, stderr,
            cmdline,
            Ref{Union{Nothing, Task}}(nothing),
            Ref{Union{Nothing, Process}}(nothing),
            Ref{Bool}(true),
            ReentrantLock()
        )
    end
end

MonitoredOPAServer(exec::Function, configfile::String; kwargs...) = MonitoredOPAServer(CommandLine(exec), configfile; kwargs...)

function start_opa_server!(server::MonitoredOPAServer)
    ctx = server.cmdline
    if !isnothing(server.stdout)
        ctx.pipelineopts[:stdout] = server.stdout
    end
    if !isnothing(server.stderr)
        ctx.pipelineopts[:stderr] = server.stderr
    end
    server.server_proc[] = CLI.run(ctx;
        server = true,
        config_file = server.configfile,
        addr = "$(server.host):$(server.port)"
    )
    return server.server_proc[]
end

"""
    start!(server::MonitoredOPAServer)

Starts the server. If the server is already started, an error is thrown.
Monitors the server and restarts it if it dies.
"""
function start!(server::MonitoredOPAServer)
    lock(server.lck) do
        if !isnothing(server.monitor_task[]) && !istaskdone(server.monitor_task[])
            error("Server already started")
        end
        server.stopped[] = false
        server.monitor_task[] = @async monitor(server)
    end
end

"""
    stop!(server::MonitoredOPAServer)

Stops the server. If the server is not started, an error is thrown.
"""
function stop!(server::MonitoredOPAServer)
    lock(server.lck) do
        if server.stopped[] || isnothing(server.monitor_task[]) || istaskdone(server.monitor_task[])
            error("Server not started")
        end
        server.stopped[] = true
        kill(server.server_proc[])
        wait(server.monitor_task[])
    end
end

function monitor(server::MonitoredOPAServer)
    while !server.stopped[]
        try
            if server.server_proc[] !== nothing
                @warn("Server died, restarting")
                server.server_proc[] = nothing
            end
            proc = nothing
            lock(server.lck) do
                proc = server.server_proc[]
                if (proc === nothing)
                    proc = start_opa_server!(server)
                end
            end
            wait(proc)
        catch ex
            server.stopped[] || @warn("Server exception: $ex")
        finally
            server.stopped[] || sleep(1)
        end
    end
end

end # module Server