import regex

import ..common.custom

type RelationshipType = "foreignKey"

# Verbatim from the ODCS JSON schema `FullyQualifiedReference` and `ShorthandReference` patterns:
# id segments follow the RFC-0026a StableId denylist; shorthand names allow hyphens and any depth.
fullyQualifiedReference = r"^(?:(?:https?:\/\/)?[A-Za-z0-9._\-\/]+\.ya?ml#)?\/?[A-Za-z_][A-Za-z0-9_]*\/[^\s.#/\\@!%&^]+(?:\/[A-Za-z_][A-Za-z0-9_]*\/[^\s.#/\\@!%&^]+)*$"
shorthandReference = r"^[A-Za-z_][A-Za-z0-9_\-]*(\.[A-Za-z_][A-Za-z0-9_\-]*)+$"

refOk = lambda r: any -> bool {
    regex.match(r, shorthandReference) or regex.match(r, fullyQualifiedReference)
}

allRefsOk = lambda v: str | [str] -> bool {
    refs = [v] if typeof(v) == "str" else v
    all r in refs {refOk(r)}
}

schema RelationshipBase(custom.StableIdCustomizable):
    """
    Base definition for relationships between elements, typically for foreign key constraints.
    Inherited via StableIdCustomizable: id, customProperties.

    Attributes
    ----------
    id: str, default is Undefined, optional.
        Stable identifier for this relationship, unique within its containing relationships array (RFC 0047).
        SHOULD remain stable across contract versions. Follows the StableId denylist.
    type: RelationshipType, default is "foreignKey", optional.
        The type of relationship.
    to: str | [str], default is Undefined, required.
        Target element reference using fully qualified or shorthand notation; Or an array of target elements for composite keys.
        Shorthand: dot-separated names of any depth, hyphens allowed (`accounts.address.street`, `my-table.col-1`).
        Fully qualified: `section/id[/properties/id...]`, ids following the StableId denylist, optionally prefixed by `file.yaml#` or `file.yml#`.
    """
    $type?: RelationshipType = "foreignKey"
    to: str | [str]

    check:
        to == Undefined or allRefsOk(to), "each 'to' reference must use shorthand or fully-qualified notation"

schema RelationshipSchemaLevel(RelationshipBase):
    """
    Relationship definition at schema level, requiring both 'from' and 'to' fields with matching types.
    Single-column relationship - both fields must be strings.
    Composite key relationship - both fields must be arrays with matching lengths.

    Attributes
    ----------
    from: str | [str], default is Undefined, required.
        Source object reference using fully qualified or shorthand notation; Or an array of source objects for composite keys.

    Examples
    --------
    usersRelationships = [
        RelationshipSchemaLevel {
            $type = "foreignKey"
            from = "schema/users_tbl/properties/user_account_id"
            to = "schema/accounts_tbl/properties/acct_id_pk"
        }
        RelationshipSchemaLevel {
            id = "fk_users_account"
            $type = "foreignKey"
            from = "users.account_id"
            to = "accounts.id"
        }
    ]

    orderItemsRelationships = [
        RelationshipSchemaLevel {
            $type = "foreignKey"
            from = [
                "schema/order_items_tbl/properties/item_order_id"
                "schema/order_items_tbl/properties/item_product_id"
            ]
            to = [
                "schema/product_inventory_tbl/properties/inv_order_id"
                "schema/product_inventory_tbl/properties/inv_product_id"
            ]
        }
    ]
    """
    from: str | [str]

    check:
        from == Undefined or allRefsOk(from), "each 'from' reference must use shorthand or fully-qualified notation"
        from == Undefined or to == Undefined or (typeof(from) == "str") == (typeof(to) == "str"), "'from' and 'to' must both be strings or both be arrays"
        from == Undefined or to == Undefined or typeof(from) == "str" or len(from) == len(to), "composite keys must have matching lengths"

schema RelationshipPropertyLevel(RelationshipBase):
    """
    Relationship definition at property level, where 'from' is implicitly the current property.

    Examples
    --------
    ownerRelationships = [
        RelationshipPropertyLevel { to = "schema/accounts_tbl/properties/owner_id_field" }
        RelationshipPropertyLevel { to = "accounts.owner_id" }
        RelationshipPropertyLevel { id = "fk_owner_address", to = "accounts.address.owner-id" }
    ]
    """
