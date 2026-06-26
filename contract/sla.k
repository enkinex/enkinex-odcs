import ..common.id as id

schema ServiceLevelAgreement:
    """
    This section describes the service-level agreements (SLA).

    Attributes
    ----------
    id: str, default is Undefined, optional.
        A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.
    property: str, default is Undefined, required.
        Specific property in SLA, check the [Data QoS periodic table](https://medium.com/data-mesh-learning/what-is-data-qos-and-why-is-it-critical-c524b81e3cc1). May requires units.
    value: any, default is Undefined, required.
        Agreement value. The label will change based on the property itself.
    valueExt: str, default is Undefined, optional.
        Extended agreement value. The label will change based on the property itself.
    unit: str, default is Undefined, optional.
        Units use the ISO standard. For example: **d**, day, days for days; **y**, yr, years for years, etc.
    element: str, default is Undefined, optional.
        Element(s) to check on. Multiple elements should be extremely rare and, if so, separated by commas.
    driver: str, default is Undefined, optional.
        Describes the importance of the SLA from the list of: `regulatory`, `analytics`, or `operational`.
    description: str, default is Undefined, optional.
        Description of the SLA for humans.
    scheduler: str, default is Undefined, optional.
        Name of the scheduler, can be cron or any tool your organization support.
    schedule: str, default is Undefined, optional.
        Configuration information for the scheduling tool, for cron a possible value is `0 20 * * *`.

    Examples
    --------
    latency = ServiceLevelAgreement {
        id = "latency_4_days"
        property = "latency"
        value = 4
        unit = "d # d, day, days for days; y, yr, years for years"
        element = "tab1.txn_ref_dt"
        scheduler = "cron"
        schedule = "0 30 * * *"
    }

    availability = ServiceLevelAgreement {
        id = "main_ga"
        property = "generalAvailability"
        value = "2022-05-12T09:30:10-08:00"
        description = "GA at 12.5.22"
    }

    regulatory = ServiceLevelAgreement {
        id = "reg_toa"
        property = "timeOfAvailability"
        value = "09:00-08:00"
        element = "tab1.txn_ref_dt"
        driver = "regulatory"
    }

    analytics = = ServiceLevelAgreement {
        id = "analytics_toa"
        property = "timeOfAvailability"
        value = "08:00-08:00"
        element = "tab1.txn_ref_dt"
        driver = "analytics"
    }
    """
    mixin [
        id.OptionalStableIdMixin
    ]
    property: str
    value: any
    valueExt?: str
    unit?: str
    element?: str
    driver?: str
    description?: str
    scheduler?: str
    schedule?: str

