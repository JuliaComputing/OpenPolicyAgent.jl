package policies.server.rest

default allowed = false

allowed {
    name := input.name
    data.data.users.users[name].role == "manager"
}
