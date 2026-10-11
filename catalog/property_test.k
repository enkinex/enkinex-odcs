import runtime

import .enum

test_enum_accepts_labels_and_a_null_member = lambda {
    p = SchemaProperty {
        name = "status"
        logicalType = "string"
        enum = [enum.EnumValue {value = "pending", label = "Pending"}, enum.EnumValue {value = None, label = "Unknown"}]
    }
    assert len(p.enum) == 2
}

test_enum_must_be_non_empty_unique_and_present = lambda {
    assert "enum must not be empty" in runtime.catch(lambda {
        SchemaProperty {name = "s", logicalType = "string", enum = []}
    })
    assert "enum values must be unique" in runtime.catch(lambda {
        SchemaProperty {name = "s", logicalType = "string", enum = [enum.EnumValue {value = "a", label = "A"}, enum.EnumValue {value = "a", label = "B"}]}
    })
    assert "enum value is required" in runtime.catch(lambda {
        enum.EnumValue {label = "no value"}
    })
}

test_enum_values_follow_the_logical_type = lambda {
    assert enumValueFits("a", "string") and enumValueFits(1, "integer") and enumValueFits(1, "number")
    assert enumValueFits(2.5, "number") and enumValueFits(True, "boolean") and enumValueFits(None, "integer")
    assert enumValueFits(1, "date") and enumValueFits("x", Undefined)
    assert not enumValueFits(1, "string") and not enumValueFits("1", "integer") and not enumValueFits(2.5, "integer")
    assert not enumValueFits(True, "string") and not enumValueFits("true", "boolean")
    assert "compatible with the property's logicalType" in runtime.catch(lambda {
        SchemaProperty {name = "s", logicalType = "string", enum = [enum.EnumValue {value = 1}]}
    })
    assert SchemaProperty {name = "p", logicalType = "integer", enum = [enum.EnumValue {value = 1}]}.enum[0].value == 1
}

test_semantic_type_and_deprecated_carry_spec_defaults = lambda {
    p = SchemaProperty {name = "amount"}
    assert p.semanticType == "column"
    assert p.deprecated == False
    role = "met" + "ric"
    assert "got str" in runtime.catch(lambda {
        SchemaProperty {name = "amount", semanticType = role}
    })
}
