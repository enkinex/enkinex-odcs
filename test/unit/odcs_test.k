import runtime

import odcs

schema OrgContract(odcs.DataContract):
    """
    An organization closing the open `status` to the `StatusType` values.
    """
    status?: odcs.StatusType

test_status_is_optional_and_open = lambda {
    assert odcs.DataContract {id = "c1", version = "1.0.0"}.status == Undefined
    assert odcs.DataContract {id = "c1", version = "1.0.0", status = "in development"}.status == "in development"
}

test_status_narrows_in_a_subschema = lambda {
    status = "in " + "development"
    assert OrgContract {id = "c1", version = "1.0.0", status = "active"}.status == "active"
    assert "expect \"proposed\" | \"draft\"" in runtime.catch(lambda {
        OrgContract {id = "c1", version = "1.0.0", status = status}
    })
}

test_api_version_is_pinned_to_v3_2_0 = lambda {
    assert odcs.DataContract {id = "c1", version = "1.0.0"}.apiVersion == "v3.2.0"
}
