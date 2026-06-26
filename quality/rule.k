import .operator

import ..common.authoritative as ad
import ..common.minixs as mix
import ..common.property as prop

schema DataQuality:
    """
    Data quality rule with all the relevant information for setup and execution.

    Attributes
    ----------
    name: str, default is Undefined, optional.
        Name of the data quality check.
    description: str, default is Undefined, optional.
        Describe the quality check to be completed.
    type: "library" | "sql" | "text" | "custom", default is "library", optional.
        The type of quality check. `text` is human-readable text that describes the quality of the data. `library` is a set of maintained predefined quality attributes such as row count or unique. `sql` is an individual SQL query that returns a value that can be compared. `custom` is quality attributes that are vendor-specific, such as Soda or Great Expectations.
    metric: str, default is Undefined, otpional.
        Define a data quality check based on the predefined metrics as per ODCS. For example, `nullValues`, `missingValues`, `invalidValues`, `duplicateValues`, `rowCount`.
    arguments: str, default is Undefined, otpional.
        Additional arguments for the metric, if needed.
    unit: str, default is Undefined, optional.
        Unit the rule is using, popular values are `rows` or `percent`, but any value is allowed.
    query: str, default is Undefined, optional.
        Required for `sql` DQ rules: the SQL query to be executed. Note that it should match the target SQL engine/database, no transalation service are provided here.
    engine: str, default is Undefined, optional.
        Required for `custom` DQ rule: name of the engine which executes the data quality checks. For example, `soda`, `great-expectations`, `monte-carlo`, `dbt`.
    implementation: str, default is Undefined, optional.
        A text (non-parsed) block of code required for the third-party DQ engine to run.
    dimension: str, default is Undefined, optional.
        The key performance indicator (KPI) or dimension for data quality. Valid values are listed after the table.
    method: str, default is Undefined, optional.
        Values are open and include `reconciliation`.
    severity: str, default is Undefined, optional.
        The severity of the DQ rule.
    businessImpact: str, default is Undefined, optional.
        Consequences of the rule failure.
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.
    authoritativeDefinitions: [ad.AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the data contract.
    scheduler: str, default is Undefined, optional.
        Name of the scheduler, can be `cron` or any tool your organization support.
    schedule: str, default is Undefined, optional.
        Configuration information for the scheduling tool, for cron a possible value is `0 20 * * *`.

    Examples
    --------
    noNullID = DataQuality {
        id = "order_id_no_nulls"
        metric = "nullValues"
        mustBe = 0
        description = "There must be no null values in the column."
    }

    percentNullStatus = DataQuality {
        id = "order_status_null_percent"
        metric = "nullValues"
        mustBeLessThan = 1
        unit = "percent"
        description = "There must be less than 1% null values in the column."
    }
    """
    mixin [
        mix.OptionalStableIdMixin,
        operator.MustBeMixin,
        operator.MustNotBeMixin,
        operator.MustBeGreaterThanMixin,
        operator.MustBeGreaterOrEqualToMixin,
        operator.MustBeLessThanMixin,
        operator.MustBeLessOrEqualToMixin,
        operator.MustBeBetweenMixin,
        operator.MustBeNotBetweenMixin
    ]
    name?: str
    description?: str
    $type?: "library" | "sql" | "text" | "custom" = "library"
    metric?: str
    arguments?: str
    unit?: str
    query?: str
    engine?: str
    implementation?: str
    dimension?: str
    method?: str
    severity?: str
    businessImpact?: str
    customProperties?: [prop.CustomProperty]
    tags?: [str]
    authoritativeDefinitions?: [ad.AuthoritativeDefinition]
    scheduler?: str
    schedule?: str

