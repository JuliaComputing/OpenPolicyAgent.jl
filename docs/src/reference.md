```@contents
Pages = ["reference.md"]
Depth = 3
```

```@meta
CurrentModule = OpenPolicyAgent
```

# API Reference

## Client

```@docs
OpenPolicyAgent.Client
```

### Policy API

```@docs
OpenPolicyAgent.Client.getpolicies
OpenPolicyAgent.Client.getpolicymodule
OpenPolicyAgent.Client.putpolicymodule
OpenPolicyAgent.Client.deletepolicymodule
```

### Data API

```@docs
OpenPolicyAgent.Client.getdocument
OpenPolicyAgent.Client.getdocumentwithpath
OpenPolicyAgent.Client.getdocumentfromwebhook
OpenPolicyAgent.Client.createdocument
OpenPolicyAgent.Client.patchdocument
OpenPolicyAgent.Client.deletedocument
```

### Query API

```@docs
OpenPolicyAgent.Client.queryget
OpenPolicyAgent.Client.querypost
OpenPolicyAgent.Client.simplequery
```

### Compile API

```@docs
OpenPolicyAgent.Client.postcompile
```

### Health API

```@docs
OpenPolicyAgent.Client.gethealth
```

### Config API

```@docs
OpenPolicyAgent.Client.getconfig
```

### Status API

```@docs
OpenPolicyAgent.Client.getstatus
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
OpenPolicyAgent.CLI.evaluate
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
