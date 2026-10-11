import runtime
import yaml

import common.variable
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

test_variable_tokens_survive_export = lambda {
    c = odcs.DataContract {
        id = "c1"
        version = "1.0.0"
        contractCreatedTs = variable.variable("CREATED_AT")
        domain = r"${DOMAIN:-sales}"
    }
    exported = yaml.encode(c)
    assert r"contractCreatedTs: ${CREATED_AT}" in exported
    assert r"domain: ${DOMAIN:-sales}" in exported
    assert "contractCreatedTs must be an ISO-8601 timestamp" in runtime.catch(lambda {
        odcs.DataContract {id = "c1", version = "1.0.0", contractCreatedTs = "yesterday"}
    })
}
