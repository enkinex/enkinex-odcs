import enkinex_odcs.common.property

RulesetProperty = property.CustomProperty {
    property = "refRulesetName"
    value = "gcsc.ruleset.name"
}

SomeProperty = property.CustomProperty {
    property = "somePropertyName"
    value = "property.value"
}

DataprocClusterProperty = property.CustomProperty {
    property = "dataprocClusterName"
    value = ["cluster name"]
}
