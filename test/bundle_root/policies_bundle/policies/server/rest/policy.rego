package policies.server.rest

default allowed = false

allowed if {
    name := input.name
    data.data.users.users[name].role == "manager"
}
