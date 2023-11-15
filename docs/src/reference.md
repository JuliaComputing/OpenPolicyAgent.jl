```@contents
Pages = ["reference.md"]
Depth = 3
```

```@meta
CurrentModule = OpenPolicyAgent
```

# API Reference

## Client

### PolicyApi

```@docs
OpenPolicyAgent.Client.get_policies
OpenPolicyAgent.Client.get_policy_module
OpenPolicyAgent.Client.put_policy_module
OpenPolicyAgent.Client.delete_policy_module
```

### DataApi

```@docs
OpenPolicyAgent.Client.get_document
OpenPolicyAgent.Client.get_document_with_path
OpenPolicyAgent.Client.get_document_from_webhook
OpenPolicyAgent.Client.create_document
OpenPolicyAgent.Client.patch_document
OpenPolicyAgent.Client.delete_document
```

### QueryApi

```@docs
OpenPolicyAgent.Client.query_get
OpenPolicyAgent.Client.query_post
OpenPolicyAgent.Client.simple_query
```

### CompileApi

```@docs
OpenPolicyAgent.Client.post_compile
```

### HealthApi

```@docs
OpenPolicyAgent.Client.get_health
```

### ConfigApi

```@docs
OpenPolicyAgent.Client.get_config
```

### StatusApi

```@docs
OpenPolicyAgent.Client.get_status
```

## Server

```@docs
OpenPolicyAgent.Server.MonitoredOPAServer
OpenPolicyAgent.Server.start!
OpenPolicyAgent.Server.stop!
```

## CLI

```@docs
OpenPolicyAgent.CLI.CommandLine
OpenPolicyAgent.CLI.opa
OpenPolicyAgent.CLI.help
OpenPolicyAgent.CLI.version
OpenPolicyAgent.CLI.build
OpenPolicyAgent.CLI.check
OpenPolicyAgent.CLI.completion
OpenPolicyAgent.CLI.deps
OpenPolicyAgent.CLI.eval
OpenPolicyAgent.CLI.exec
OpenPolicyAgent.CLI.fmt
OpenPolicyAgent.CLI.inspect
OpenPolicyAgent.CLI.parse
OpenPolicyAgent.CLI.run
OpenPolicyAgent.CLI.sign
OpenPolicyAgent.CLI.test
OpenPolicyAgent.CLI.bench
```

## AST Walker

```@docs
OpenPolicyAgent.ASTWalker.Visitor
OpenPolicyAgent.ASTWalker.walk
OpenPolicyAgent.ASTWalker.before
OpenPolicyAgent.ASTWalker.visit
OpenPolicyAgent.ASTWalker.after
```

### Included Visitors

```@docs
OpenPolicyAgent.ASTWalker.AST.ASTVisitor
OpenPolicyAgent.ASTWalker.SQL.SQLVisitor
```
