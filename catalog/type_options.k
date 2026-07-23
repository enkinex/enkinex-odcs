type IntegerFormatEnum = "i8" | "i16" | "i32" | "i64" | "i128" | "u8" | "u16" | "u32" | "u64" | "u128"
type NumberFormatEnum = "f32" | "f64"

schema TypeOptions:
    """
    Base type for every logical type options.

    The union of every logical-type option. This is the type of
    `SchemaProperty.logicalTypeOptions`, so its attributes are declared
    directly (not via mixins) to be recognized by KCL dict→schema coercion.
    Being the permissive superset, no attribute carries a default (an unset
    option must read back as `Undefined` so the per-type validation on
    `SchemaProperty` can tell which keys were actually supplied).

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
    maxItems: int, default is Undefined, optional.
        Maximum number of items.
    minItems: int, default is Undefined, optional.
        Minimum number of items.
    uniqueItems: bool, default is Undefined, optional.
        If set to true, all items in the array are unique.
    defaultTimezone: str, default is Undefined, optional.
        The default timezone of the timestamp.
        If timezone is not defined, the default timezone Etc/UTC is used.
    timezone: bool, default is Undefined, optional.
        Whether the timestamp defines the timezone or not.
        If true, timezone information is included in the timestamp.
    multipleOf: int | float, default is Undefined, optional.
        Values must be multiples of this number.
        Examples: multiple of 5 has valid values 0, 5, 10, -5.
    maxProperties: int, default is Undefined, optional.
        Maximum number of properties.
    minProperties: int, default is Undefined, optional.
        Minimum number of properties.
    required: [str], default is Undefined, optional.
        Property names that are required to exist in the object.
    pattern: str, default is Undefined, optional.
        Regular expression pattern to define valid value.
        Follows regular expression syntax from ECMA-262.
        See also: https://262.ecma-international.org/5.1/#sec-15.10.1.
    maxLength: int, default is Undefined, optional.
        Maximum length of the string.
    minLength: int, default is Undefined, optional.
        Minimum length of the string.
    """
    format?: str
    exclusiveMaximum?: str | int | float
    exclusiveMinimum?: str | int | float
    maximum?: str | int | float
    minimum?: str | int | float
    maxItems?: int
    minItems?: int
    uniqueItems?: bool
    defaultTimezone?: str
    timezone?: bool
    multipleOf?: int | float
    maxProperties?: int
    minProperties?: int
    required?: [str]
    pattern?: str
    maxLength?: int
    minLength?: int

    check:
        multipleOf == Undefined or multipleOf > 0, "multipleOf must be positive"
        minLength == Undefined or minLength >= 0, "minLength must be >= 0"
        maxLength == Undefined or maxLength >= 0, "maxLength must be >= 0"
        minLength == Undefined or maxLength == Undefined or minLength <= maxLength, "minLength must be <= maxLength"
        minItems == Undefined or minItems >= 0, "minItems must be >= 0"
        maxItems == Undefined or maxItems >= 0, "maxItems must be >= 0"
        minItems == Undefined or maxItems == Undefined or minItems <= maxItems, "minItems must be <= maxItems"
        minProperties == Undefined or minProperties >= 0, "minProperties must be >= 0"
        maxProperties == Undefined or maxProperties >= 0, "maxProperties must be >= 0"
        minProperties == Undefined or maxProperties == Undefined or minProperties <= maxProperties, "minProperties must be <= maxProperties"
        required == Undefined or len(required) > 0, "required must not be empty"
        required == Undefined or len(required) == len({r: r for r in required}), "required entries must be unique"

schema ArrayOptions:
    """
    Additional metadata options to define the array type.

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

    check:
        minItems == Undefined or minItems >= 0, "minItems must be >= 0"
        maxItems == Undefined or maxItems >= 0, "maxItems must be >= 0"
        minItems == Undefined or maxItems == Undefined or minItems <= maxItems, "minItems must be <= maxItems"

schema DatetimeOptions:
    """
    Additional metadata options to define date, timestamp, and time types.
    The `timezone` and `defaultTimezone` options only apply to timestamp and time types.

    Reference schema documenting the option set: `SchemaProperty.logicalTypeOptions`
    is typed `TypeOptions`, so authored values must be inline dicts that coerce into
    it (see the examples below) — a `DatetimeOptions` instance is not assignable.

    Attributes
    ----------
    format: str, default is "YYYY-MM-DDTHH:mm:ss.SSSZ", optional.
        Format of the date. Default value is using ISO 8601.
        Follows the format as prescribed by [JDK DateTimeFormatter](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html).
        Examples: ["yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss", "HH:mm:ss"]
    defaultTimezone: str, default is "Etc/UTC", optional.
        The default timezone of the timestamp.
        If timezone is not defined, the default timezone Etc/UTC is used.
    timezone: bool, default is Undefined, optional.
        Whether the timestamp defines the timezone or not.
        If true, timezone information is included in the timestamp.
    exclusiveMaximum: str, default is Undefined, optional.
        All values must be strictly less than this value (values < exclusiveMaximum).
    exclusiveMinimum: str, default is Undefined, optional.
        All values must be strictly greater than this value (values > exclusiveMinimum).
    maximum: str, default is Undefined, optional.
        All date values are less than or equal to this value (values <= maximum).
    minimum: str, default is Undefined, optional.
        All date values are greater than or equal to this value (values >= minimum).

    Examples
    --------
    dateOnly = SchemaProperty {
        name = "event_date"
        logicalType = "date"
        logicalTypeOptions = {
          format = "yyyy-MM-dd"
        }
        examples = ["2024-07-10"]
    }

    dateAndTimeUTC = SchemaProperty {
        name = "created_at"
        logicalType = "timestamp"
        logicalTypeOptions = {
            format = "yyyy-MM-ddTHH:mm:ssZ"
        }
        examples = ["2024-03-10T14:22:35Z"]
    }

    dateAndTimeAustraliaSydney = SchemaProperty {
        name = "created_at_sydney"
        logicalType = "timestamp"
        logicalTypeOptions = {
            format = "yyyy-MM-ddTHH:mm:ssZ"
            timezone = True
            defaultTimezone = "Australia/Sydney"
        }
        examples = ["2024-03-10T14:22:35+10:00"]
    }

    timeOnly = SchemaProperty {
        name = "event_start_time"
        logicalType = "time"
        logicalTypeOptions = {
            format = "HH:mm:ss"
        }
        examples = ["08:30:00"]
    }

    physicalDateAndTimeUTC = SchemaProperty {
        name = "event_date"
        logicalType = "timestamp"
        physicalType = "DATETIME"
        logicalTypeOptions = {
            format = "yyyy-MM-ddTHH:mm:ssZ"
        }
        examples = ["2024-03-10T14:22:35Z"]
    }
    """
    format?: str = "YYYY-MM-DDTHH:mm:ss.SSSZ"
    defaultTimezone?: str = "Etc/UTC"
    timezone?: bool
    exclusiveMaximum?: str
    exclusiveMinimum?: str
    maximum?: str
    minimum?: str

schema IntegerOptions:
    """
    Additional metadata options to define the integer type.

    Attributes
    ----------
    format: IntegerFormatEnum, default is "i32", optional.
        Format of the value in terms of how many bits of space it can use and whether it is signed or unsigned.
        Follows the Rust integer types.
    multipleOf: int, default is Undefined, optional.
        Values must be multiples of this number.
        Examples: multiple of 5 has valid values 0, 5, 10, -5.
    exclusiveMaximum: int, default is Undefined, optional.
        All values must be strictly less than this value (values < exclusiveMaximum).
    exclusiveMinimum: int, default is Undefined, optional.
        All values must be strictly greater than this value (values > exclusiveMinimum).
    maximum: int, default is Undefined, optional.
        All values are less than or equal to this value (values <= maximum).
    minimum: int, default is Undefined, optional.
        All values are greater than or equal to this value (values >= minimum).
    """
    format?: IntegerFormatEnum = "i32"
    multipleOf?: int
    exclusiveMaximum?: int
    exclusiveMinimum?: int
    maximum?: int
    minimum?: int

    check:
        multipleOf == Undefined or multipleOf > 0, "multipleOf must be positive"
        minimum == Undefined or maximum == Undefined or minimum <= maximum, "minimum must be <= maximum"

schema NumberOptions:
    """
    Additional metadata options to define the number type.

    Attributes
    ----------
    format: NumberFormatEnum, default is Undefined, optional.
        Format of the value in terms of floating-point precision.
        Follows the Rust float types (f32, f64).
    multipleOf: int | float, default is Undefined, optional.
        Values must be multiples of this number.
        Examples: multiple of 5 has valid values 0, 5, 10, -5.
    exclusiveMaximum: int | float, default is Undefined, optional.
        All values must be strictly less than this value (values < exclusiveMaximum).
    exclusiveMinimum: int | float, default is Undefined, optional.
        All values must be strictly greater than this value (values > exclusiveMinimum).
    maximum: int | float, default is Undefined, optional.
        All values are less than or equal to this value (values <= maximum).
    minimum: int | float, default is Undefined, optional.
        All values are greater than or equal to this value (values >= minimum).
    """
    format?: NumberFormatEnum
    multipleOf?: int | float
    exclusiveMaximum?: int | float
    exclusiveMinimum?: int | float
    maximum?: int | float
    minimum?: int | float

    check:
        multipleOf == Undefined or multipleOf > 0, "multipleOf must be positive"
        minimum == Undefined or maximum == Undefined or minimum <= maximum, "minimum must be <= maximum"

schema ObjectOptions:
    """
    Additional metadata options to define the object type.

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

    check:
        minProperties == Undefined or minProperties >= 0, "minProperties must be >= 0"
        maxProperties == Undefined or maxProperties >= 0, "maxProperties must be >= 0"
        minProperties == Undefined or maxProperties == Undefined or minProperties <= maxProperties, "minProperties must be <= maxProperties"
        required == Undefined or len(required) > 0, "required must not be empty"
        required == Undefined or len(required) == len({r: r for r in required}), "required entries must be unique"

schema StringOptions:
    """
    Additional metadata options to define the string type.

    Attributes
    ----------
    format: str, default is Undefined, optional.
        Provides extra context about what format the string follows.
        Examples: ["password", "byte", "binary", "email", "uuid", "uri", "hostname", "ipv4", "ipv6"]
    pattern: str, default is Undefined, optional.
        Regular expression pattern to define valid value.
        Follows regular expression syntax from ECMA-262.
        See also: https://262.ecma-international.org/5.1/#sec-15.10.1.
    maxLength: int, default is Undefined, optional.
        Maximum length of the string.
    minLength: int, default is Undefined, optional.
        Minimum length of the string.
    """
    format?: str
    pattern?: str
    maxLength?: int
    minLength?: int

    check:
        minLength == Undefined or minLength >= 0, "minLength must be >= 0"
        maxLength == Undefined or maxLength >= 0, "maxLength must be >= 0"
        minLength == Undefined or maxLength == Undefined or minLength <= maxLength, "minLength must be <= maxLength"

