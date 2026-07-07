import enkinex_odcs.contract.sla

LatencySla = sla.ServiceLevelAgreement {
    property = "latency"
    value = 4
    unit = "d"
    element = "tab1.txn_ref_dt"
}

GeneralAvailabilitySla = sla.ServiceLevelAgreement {
    property = "generalAvailability"
    value = "2022-05-12T09:30:10-08:00"
}

EndOfSupportSla = sla.ServiceLevelAgreement {
    property = "endOfSupport"
    value = "2032-05-12T09:30:10-08:00"
}

EndOfLifeSla = sla.ServiceLevelAgreement {
    property = "endOfLife"
    value = "2042-05-12T09:30:10-08:00"
}

RetentionSla = sla.ServiceLevelAgreement {
    property = "retention"
    value = 3
    unit = "y"
    element = "tab1.txn_ref_dt"
}

FrequencySla = sla.ServiceLevelAgreement {
    property = "frequency"
    value = 1
    valueExt = 1
    unit = "d"
    element = "tab1.txn_ref_dt"
}

RegulatoryTimeOfAvailabilitySla = sla.ServiceLevelAgreement {
    property = "timeOfAvailability"
    value = "09:00-08:00"
    element = "tab1.txn_ref_dt"
    driver = "regulatory"
}

AnalyticsTimeOfAvailabilitySla = sla.ServiceLevelAgreement {
    property = "timeOfAvailability"
    value = "08:00-08:00"
    element = "tab1.txn_ref_dt"
    driver = "analytics"
}
