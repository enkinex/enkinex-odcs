import ..common.custom

schema Synonym(custom.StableIdCustomizable):
    """
    An alternative name for a named schema element, helping catalogs, AI/LLM tools and natural language
    interfaces resolve business vocabulary to the underlying element (RFC 0041).
    Inherited via StableIdCustomizable: id, customProperties.

    Attributes
    ----------
    synonym: str, default is Undefined, required.
        The synonymous term.
    description: str, default is Undefined, optional.
        Short human-readable note about when or why this synonym is used.
    locale: str, default is Undefined, optional.
        BCP 47 language tag when the synonym is language-specific (not validated).
        Examples: "en-US", "fr-FR"
    source: str, default is Undefined, optional.
        Origin of the synonym.
        Examples: "glossary", "finance-team", "legacy-system"
    status: str, default is Undefined, optional.
        Lifecycle status of the synonym (an open vocabulary).
        Examples: "active", "deprecated"

    Examples
    --------
    revenue = Synonym {
        synonym = "turnover"
        locale = "en-GB"
        source = "glossary"
    }

    chiffreAffaires = Synonym {
        synonym = "chiffre d'affaires"
        locale = "fr-FR"
        description = "Used by the Paris finance team."
    }
    """
    synonym: str
    description?: str
    locale?: str
    source?: str
    status?: str
