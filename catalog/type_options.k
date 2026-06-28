type NumberTypeEnum = "i8" | "i16" | "i32" | "i64" | "i128" | "u8" | "u16" | "u32" | "u64" | "u128" | "f32" | "f64"

mixin ArrayOptionsMixin:
    """
    Array logical type options mixix.

    Attributes
    ----------
    maxItems: int, default is Undefined, optional.
        Maximum number of items.
    minItems: int, default is Undefined, optional.
        Minimum number of items.
    uniqueItems: bool, default is Undefined, optional.
        If set to true, all items in the array are unique.
    """
    maxItems?: int
    minItems?: int
    uniqueItems?: bool

schema ArrayOptions:
    """
    Additional metadata options to define the array type.
    """
    mixin [
        ArrayOptionsMixin
    ]

mixin DatetimeOptionsMixin:
    """
    Datetime logical type options mixix.

    Attributes
    ----------
    defaultTimezone: str, default is "Z", optional.
        The default timezone of the timestamp.
        If timezone is not defined, the default timezone UTC is used.
    timezone: bool, default is Undefined, optional.
        Whether the timestamp defines the timezone or not.
        If true, timezone information is included in the timestamp.
    """
    defaultTimezone?: str = "Z"
    timezone?: bool

schema DatetimeOptions:
    """
    Additional metadata options to define date, timestamp, and time types.

    Attributes
    ----------
    format: str, default is "YYYY-MM-DDTHH:mm:ss.SSSZ", optional.
        Format of the date. Default value is using ISO 8601.
        Follows the format as prescribed by [JDK DateTimeFormatter](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html).
        Examples: ["yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "HH:mm:ss"]

    Examples
    --------
    dateOnly = SchemaProperty {
        name = "event_date"
        logicalType = "date"
        logicalTypeOptions = DatetimeOptions {
          format = "yyyy-MM-dd"
        }
        examples = ["2024-07-10"]
    }

    dateAndTimeUTC = SchemaProperty {
        name = "created_at"
        logicalType = "timestamp"
        logicalTypeOptions = DatetimeOptions {
            format = "yyyy-MM-ddTHH:mm:ssZ"
        }
        examples = ["2024-03-10T14:22:35Z"]
    }

    dateAndTimeAustraliaSydney = SchemaProperty {
        name = "created_at_sydney"
        logicalType = "timestamp"
        logicalTypeOptions = DatetimeOptions {
            format = "yyyy-MM-ddTHH:mm:ssZ"
            timezone = True
            defaultTimezone = "Australia/Sydney"
        }
        examples = ["2024-03-10T14:22:35+10:00"]
    }

    timeOnly = SchemaProperty {
        name = "event_start_time"
        logicalType = "time"
        logicalTypeOptions = DatetimeOptions {
            format = "HH:mm:ss"
        }
        examples = ["08:30:00"]
    }

    physicalDateAndTimeUTC = SchemaProperty {
        name = "event_date"
        logicalType = "timestamp"
        physicalType = "DATETIME"
        logicalTypeOptions = DatetimeOptions {
            format = "yyyy-MM-ddTHH:mm:ssZ"
        }
        examples = ["2024-03-10T14:22:35Z"]
    }
    """
    mixin [
        DatetimeOptionsMixin,
        MinMaxStringOptionsMixin
    ]
    format?: str = "YYYY-MM-DDTHH:mm:ss.SSSZ"

mixin MinMaxStringOptionsMixin:
    """
    Minimum and maximun string logical type options mixix.

    Attributes
    ----------
    exclusiveMaximum: str, default is Undefined, optional.
        All values must be strictly less than this value (values < exclusiveMaximum).
    exclusiveMinimum: str, default is Undefined, optional.
        All values must be strictly greater than this value (values > exclusiveMinimum).
    maximum: str, default is Undefined, optional.
        All date values are less than or equal to this value (values <= maximum).
    minimum: str, default is Undefined, optional.
        All date values are greater than or equal to this value (values >= minimum).
    """
    exclusiveMaximum?: str
    exclusiveMinimum?: str
    maximum?: str
    minimum?: str

mixin MinMaxNumberOptionsMixin:
    """
    Minimum and maximun number type options mixix.

    Attributes
    ----------
    exclusiveMaximum: int | float, default is Undefined, optional.
        All values must be strictly less than this value (values < exclusiveMaximum).
    exclusiveMinimum: int | float, default is Undefined, optional.
        All values must be strictly greater than this value (values > exclusiveMinimum).
    maximum: int | float, default is Undefined, optional.
        All values are less than or equal to this value (values <= maximum).
    minimum: int | float, default is Undefined, optional.
        All values are greater than or equal to this value (values >= minimum).
    """
    exclusiveMaximum?: int | float
    exclusiveMinimum?: int | float
    maximum?: int | float
    minimum?: int | float

mixin NumberOptionsMixin:
    """
    Number logical type options mixix.

    Attributes
    ----------
    multipleOf: int | float, default is Undefined, optional.
        Values must be multiples of this number.
        Examples: multiple of 5 has valid values 0, 5, 10, -5.
    """
    multipleOf?: int | float

schema NumberOptions:
    """
    Additional metadata options to define integer and number types.

    Attributes
    ----------
    format: NumberTypeEnum, default is "i32", optional.
        Format of the value in terms of how many bits of space it can use and whether it is signed or unsigned.
        Follows the Rust integer and float types.
    """
    mixin [
        MinMaxNumberOptionsMixin,
        NumberOptionsMixin
    ]
    format?: NumberTypeEnum

mixin ObjectOptionsMixin:
    """
    Object logical type option mixix.

    Attributes
    ----------
    maxProperties: int, default is Undefined, optional.
        Maximum number of properties.
    minProperties: int, default is Undefined, optional.
        Minimum number of properties.
    required: [str], default is Undefined, optional.
        Property names that are required to exist in the object.
    """
    maxProperties?: int
    minProperties?: int
    required?: [str]

schema ObjectOptions:
    """
    Additional metadata options to define integer and number types.
    """
    mixin [
        ObjectOptionsMixin
    ]

mixin RegexPattternOptionMixin:
    """
    Regex pattern logical type option mixix.

    Attributes
    ----------
    pattern: str, default is Undefined, optional.
        Regular expression pattern to define valid value.
        Follows regular expression syntax from ECMA-262.
        See also: https://262.ecma-international.org/5.1/#sec-15.10.1.
    """
    pattern?: str

mixin StringOptionsMixin:
    """
    String logical type options mixix.

    Attributes
    ----------
    maxLength: int, default is Undefined, optional.
        Maximum length of the string.
    minLength: int, default is Undefined, optional.
        Minimum length of the string.
    """
    maxLength?: int
    minLength?: int

schema StringOptions:
    """
    Additional metadata options to define the string type.

    Attributes
    ----------
    format: str, default is Undefined, optional.
        Provides extra context about what format the string follows.
        Examples: ["password", "byte", "binary", "email", "uuid", "uri", "hostname", "ipv4", "ipv6"]
    """
    mixin [
        RegexPattternOptionMixin,
        StringOptionsMixin
    ]
    format?: str

schema TypeOptions:
    """
    Base type for every logical type options.

    Attributes
    ----------
    format: str, default is Undefined, optional.
        Format for date, number or string.
        Examples: ISO 8601 date "yyyy-MM-dd", zero-padding number "{:05}", string "email".
    exclusiveMaximum: str | int | float, default is Undefined, optional.
        Values must be strictly less than this value (values < exclusiveMaximum).
    exclusiveMinimum: str | int | float, default is Undefined, optional.
        Values must be strictly greater than this value (values > exclusiveMinimum).
    maximum: str | int | float, default is Undefined, optional.
        Values are less than or equal to this value (values <= maximum).
    minimum: str | int | float, default is Undefined, optional.
        Values are greater than or equal to this value (values >= minimum).
    """
    mixin [
        ArrayOptionsMixin,
        DatetimeOptionsMixin,
        NumberOptionsMixin,
        ObjectOptionsMixin,
        RegexPattternOptionMixin,
        StringOptionsMixin
    ]
    format?: str
    exclusiveMaximum?: str | int | float
    exclusiveMinimum?: str | int | float
    maximum?: str | int | float
    minimum?: str | int | float

