schema Pricing:
    """
    This section covers pricing when you bill your customer for using this data product.

    Attributes
    ----------
    id: str, default is Undefined, optional.
        A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.
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
    id?: str
    priceAmount?: str
    priceCurrency?: str
    priceUnit?: str

