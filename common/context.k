import .discovery

schema VerifiedStatement(discovery.StableIdDiscoverable):
    """
    A canonical question for AI agents and tools, or a verified question and answer pair when `answer` is set.
    Inherited via StableIdDiscoverable: id, customProperties, authoritativeDefinitions, tags.
    The JSON types `id` as a plain string; the library applies the StableId denylist, as for every
    "stable identifier" (decision D11).

    Attributes
    ----------
    question: str, default is Undefined, required.
        The canonical question.
    answer: str, default is Undefined, optional.
        The expected response or result description.
    """
    question: str
    answer?: str

schema ContextConstraint(discovery.StableIdDiscoverable):
    """
    Negative guidance: something AI agents must not do with the entity.
    Inherited via StableIdDiscoverable: id, customProperties, authoritativeDefinitions, tags.
    The JSON types `id` as a plain string; the library applies the StableId denylist (decision D11).

    Attributes
    ----------
    constraint: str, default is Undefined, required.
        The constraint text.
    """
    constraint: str

schema Context:
    """
    AI and semantic context block (RFC 0038): structured guidance for AI agents, LLMs, BI tools and semantic layers.
    Used by `DataContract.context` and `SchemaObject.context`, both typed `str | Context`: a plain string is the
    shorthand for `instructions` only, as in the JSON `oneOf`.

    Attributes
    ----------
    instructions: str, default is Undefined, optional.
        Natural language guidance on how to use the entity, like a system prompt scoped to this level.
    verifiedStatements: [VerifiedStatement], default is Undefined, optional.
        Canonical questions (entries without `answer`) and verified question and answer pairs.
    constraints: [ContextConstraint], default is Undefined, optional.
        What AI agents must not do with the entity.

    Examples
    --------
    ordersContext = Context {
        instructions = "Use for order analytics; amounts are in USD."
        verifiedStatements = [
            VerifiedStatement {
                id = "vs_daily_revenue"
                question = "What was yesterday's revenue?"
                answer = "SUM(amount) for orders with order_date = current_date - 1."
            }
        ]
        constraints = [
            ContextConstraint {
                constraint = "Never join orders to customers on email."
            }
        ]
    }
    """
    instructions?: str
    verifiedStatements?: [VerifiedStatement]
    constraints?: [ContextConstraint]
