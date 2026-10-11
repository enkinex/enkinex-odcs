import runtime

test_shorthand_references_allow_depth_and_hyphens = lambda {
    assert all r in ["users.id", "a.b.c", "accounts.address.street", "my-table.col-1", "table-x.col-y"] {
        refOk(r)
    }
    assert not any r in ["users", ".users.id", "users.", "1users.id", "users..id"] {
        refOk(r)
    }
}

test_fully_qualified_references_follow_the_stable_id_denylist = lambda {
    assert all r in ["schema/users_tbl/properties/user_id", "/schema/fdir:ISU:TAD/properties/x", "contract.yml#/schema/fdir:ISU:TAD/properties/x", "https://example.com/c.yaml#schema/t/properties/c"] {
        refOk(r)
    }
    assert not any r in ["schema/users.tbl", "schema/a b/properties/c", "schema"] {
        refOk(r)
    }
}

test_relationship_ids_are_stable_ids = lambda {
    assert RelationshipPropertyLevel {id = "fk_order_customer", to = "customers.id"}.id == "fk_order_customer"
    assert "id must match" in runtime.catch(lambda {
        RelationshipPropertyLevel {id = "fk/order", to = "customers.id"}
    })
}
