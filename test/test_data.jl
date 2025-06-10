const opa_config_template = joinpath(@__DIR__, "conf", "config.yaml")
const bundle_root = joinpath(@__DIR__, "bundle_root")
const data_bundle_root = joinpath(bundle_root, "data_bundle")
const policies_bundle_root = joinpath(bundle_root, "policies_bundle")
const bundle_args = Dict(
    :bundle => true,
    :signing_alg => "HS512",
    :signing_key => "secret",
)

const EXAMPLE_POLICY = """package opa.examples
    import data.servers
    import data.networks
    import data.ports

    public_servers contains server if {
    some k, m
        server := servers[_]
        server.ports[_] == ports[k].id
        ports[k].networks[_] == networks[m].id
        networks[m].public == true
    }
"""

const PARTIAL_COMPILE_CASES = [
    (
        policy = """package example
        allow if {
            input.subject.clearance_level >= data.reports[_].clearance_level
        }""",
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "( 4 >= public.juliahub_reports.clearance_level )",
    ),
    (
        policy = """package example

        allow if {
            input.subject.group == "admin"
        }
        allow if {
            data.reports[_].public == true
        }
        allow if {
            input.subject.clearance_level >= data.reports[_].clearance_level
            input.subject.id == data.reports[_].owner
        }
        """,
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4,
                "id" => "bob",
                "group" => "eng"
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "( public.juliahub_reports.public = true ) or\n( 4 >= public.juliahub_reports.clearance_level ) and ( 'bob' = public.juliahub_reports.owner )",
    ),
    (
        # always allowed if the policy is fully satisfied with the given input for any one condition
        policy = """package example

        allow if {
            input.subject.group == "admin"
        }
        allow if {
            data.reports[_].public == true
        }
        allow if {
            input.subject.clearance_level >= data.reports[_].clearance_level
            input.subject.id == data.reports[_].owner
        }
        """,
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4,
                "id" => "sally",
                "group" => "admin"
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "",
    ),
    (
        # always allowed if the policy with only one condition is fully satisfied with the given input
        policy = """package example
        default allow = false
        allow if {
            input.subject.group == "admin"
        }
        """,
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "id" => "sally",
                "group" => "admin"
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "",
    ),
    (
        # not allowed if the required policy is not defined
        policy = """package example
        default allow = false
        allow if {
            input.subject.group == "admin"
        }
        """,
        query = "data.example.undefinedallow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "id" => "sally",
                "group" => "admin"
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "false",
    ),
    (
        policy = """package example
        import rego.v1

        allow if {
            input.subject.group in ["admin", "superadmin"]
        }
        allow if {
            data.reports[_].category in ["public", "pinned"]
        }
        allow if {
            input.subject.clearance_level >= data.reports[_].clearance_level
        }
        """,
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4,
                "group" => "eng",
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "( public.juliahub_reports.category in ('public', 'pinned') ) or\n( 4 >= public.juliahub_reports.clearance_level )",
    ),
    (
        policy = """package example
        allow if {
            bits.and(data.reports[_].clearance_level, input.subject.clearance_level) >= input.subject.clearance_level
        }""",
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "( ( public.juliahub_reports.clearance_level & 4 ) >= 4 )",
    ),
    (
        policy = """package example
        allow if {
            bits.or(data.reports[_].clearance_level, input.subject.clearance_level) >= input.subject.clearance_level
        }""",
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "( ( public.juliahub_reports.clearance_level | 4 ) >= 4 )",
    ),
    (
        policy = """package example
        allow if {
            (data.reports[_].clearance_level + input.subject.clearance_level) >= input.subject.clearance_level
        }""",
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "( ( public.juliahub_reports.clearance_level + 4 ) >= 4 )",
    ),
    (
        policy = """package example
        allow if {
            (data.reports[_].clearance_level - input.subject.clearance_level) >= 0
        }""",
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "( ( public.juliahub_reports.clearance_level - 4 ) >= 0 )",
    ),
    (
        policy = """package example
        import rego.v1
        allow if {
            data.reports[_].category in {"public"}
        }
        """,
        query = "data.example.allow == true",
        input = Dict{String,Any}(
            "subject" => Dict{String,Any}(
                "clearance_level" => 4
            )
        ),
        options = Dict{String,Any}(
            "disableInlining" => []
        ),
        unknowns = ["data.reports"],
        sql = "( public.juliahub_reports.category in ('public') )",
    ),
]

const EXAMPLE_QUERY = """input.servers[i].ports[_] = "p2"; input.servers[i].name = name"""
const EXAMPLE_QUERY_INPUT = Dict{String,Any}(
    "servers" => [
        Dict{String,Any}(
            "id" => "s1",
            "name" => "app",
            "ports" => ["p1", "p2", "p3"],
            "protocols" => ["https", "ssh"]
        ),
        Dict{String,Any}(
            "id" => "s4",
            "name" => "dev",
            "ports" => ["p1", "p2"],
            "protocols" => ["http"]
        )
    ]
)

const SCHEMA_MAP = Dict{String, String}(
    "data" => "public",
    "public" => "public",
)

const TABLE_MAP = Dict{String, String}(
    "reports" => "juliahub_reports",
)
