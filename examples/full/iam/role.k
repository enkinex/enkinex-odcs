import enkinex_odcs.iam.role

StrategyReader = role.Role {
    role = "microstrategy_user_opr"
    access = "read"
    firstLevelApprovers = "Reporting Manager"
    secondLevelApprovers = "mandolorian"
}

QueryReader = role.Role {
    role = "bq_queryman_user_opr"
    access = "read"
    firstLevelApprovers = "Reporting Manager"
    secondLevelApprovers = "na"
}

RiskReader = role.Role {
    role = "risk_data_access_opr"
    access = "read"
    firstLevelApprovers = "Reporting Manager"
    secondLevelApprovers = "dathvador"
}

BQWriter = role.Role {
    role = "bq_unica_user_opr"
    access = "write"
    firstLevelApprovers = "Reporting Manager"
    secondLevelApprovers = "mickey"
}
