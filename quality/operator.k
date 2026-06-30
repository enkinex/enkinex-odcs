mixin MustBeMixin:
    """
    Data quality operator mixin `mustBe`

    Attributes
    ----------
    mustBe: any, default is Undefined, optional.
        Must be equal to the value to be valid. When using numbers, it is equivalent to '='.
    """
    mustBe?: any

mixin MustNotBeMixin:
    """
    Data quality operator mixin `mustNotBe`

    Attributes
    ----------
    mustNotBe: any, default is Undefined, optional.
        Must not be equal to the value to be valid. When using numbers, it is equivalent to '!='.
    """
    mustNotBe?: any

mixin MustBeGreaterThanMixin:
    """
    Data quality operator mixin `mustBeGreaterThan`

    Attributes
    ----------
    mustBeGreaterThan: int | float, default is Undefined, optional.
        Must be greater than the value to be valid. It is equivalent to '>'.
    """
    mustBeGreaterThan?: int | float

mixin MustBeGreaterOrEqualToMixin:
    """
    Data quality operator mixin `mustBeGreaterOrEqualTo`

    Attributes
    ----------
    mustBeGreaterOrEqualTo: int | float, default is Undefined, optional.
        Must be greater than or equal to the value to be valid. It is equivalent to '>='.
    """
    mustBeGreaterOrEqualTo?: int | float

mixin MustBeLessThanMixin:
    """
    Data quality operator mixin `mustBeLessThan`

    Attributes
    ----------
    mustBeLessThan: int | float, default is Undefined, optional.
        Must be less than the value to be valid. It is equivalent to '<'.
    """
    mustBeLessThan?: int | float

mixin MustBeLessOrEqualToMixin:
    """
    Data quality operator mixin `mustBeLessOrEqualTo`

    Attributes
    ----------
    mustBeLessOrEqualTo: int | float, default is Undefined, optional.
        Must be less than or equal to the value to be valid. It is equivalent to '<='.
    """
    mustBeLessOrEqualTo?: int | float

mixin MustBeBetweenMixin:
    """
    Data quality operator mixin `mustBeBetween`

    Attributes
    ----------
    mustBeBetween: [int | float], default is Undefined, optional.
        Must be between the two numbers to be valid. Smallest number first in the array.
    """
    mustBeBetween?: [int | float]

mixin MustNotBeBetweenMixin:
    """
    Data quality operator mixin `mustNotBeBetween`

    Attributes
    ----------
    mustNotBeBetween: [int | float], default is Undefined, optional.
        Must not be between the two numbers to be valid. Smallest number first in the array.
    """
    mustNotBeBetween?: [int | float]

