import ..common.mixins

schema Pricing(mixins.StableIdObject):
    """
    This section covers pricing when you bill your customer for using this data product.

    Attributes
    ----------
    priceAmmount: str, default is Undefined, optional.
        Subscription price per unit of measure in `priceUnit`.
    priceCurrency: str, default is Undefined, optional.
        Currency of the subscription price in `price.priceAmount`.
    priceUnit: str, default is Undefined, optional.
        The unit of measure for calculating cost. Examples megabyte, gigabyte.

    Examples
    --------
    price = Pricing {
        priceAmount = "9.95"
        priceCurrency = "USD"
        priceUnit = "megabyte"
    }
    """
    priceAmount?: str
    priceCurrency?: str
    priceUnit?: str

