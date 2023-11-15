module ASTWalker

    """
        Visitor
    
    Abstract type for AST visitors.
    Visitors must implement the `before`, `visit` and `after` methods.
    Visitors can keep state, the same visitor instance will be passed to all invocations of `before`, `visit` and `after` that happen while walking the AST.
    """
    abstract type Visitor end

    """
        before(visitor, node)
    
    Called before visiting a node. The node that will be visited is passed as the second argument.
    Any preparatory work that needs to be done before visiting the node can be done here.
    Return value is ignored.
    """
    before(visitor::Visitor, node) = error("Not implemented: before($(typeof(visitor)), $(typeof(node)))")

    """
        visit(visitor, node)
    
    Called when visiting a node. The node that is being visited is passed as the second argument.
    The actual action to be performed when visiting a node must be implemented here.
    The visit method must also call `walk` on the visitor to visit the children of the node.
    The result must be stored in the visitor state. Return value is ignored.
    """
    visit(visitor::Visitor, node) = error("Not implemented: visit($(typeof(visitor)), $(typeof(node)))")

    """
        after(visitor, node)
    
    Called after visiting a node. The node that was visited is passed as the second argument.
    Any cleanup work that needs to be done after visiting the node can be done here.
    This is the last method called when visiting a node.
    Must return the result of visiting the node.
    """
    after(visitor::Visitor, node) = error("Not implemented: after($(typeof(visitor)), $(typeof(node)))")

    """
        walk(visitor, node)
    
    Walks the AST rooted at `node` using the `visitor`.
    Calls `before`, `visit` and `after` methods of the `visitor` in sequence while walking the tree.
    """
    function walk(visitor::Visitor, node)
        before(visitor, node)
        visit(visitor, node)
        return after(visitor, node)
    end

    include("ast.jl")
    include("sql.jl")
    
end # end module