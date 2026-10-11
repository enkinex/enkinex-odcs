import .spec as server

schema GlueServer(server.Server):
    """
    AWS Glue Server.

    Attributes
    ----------
    account: str, default is Undefined, required.
        The AWS Glue account.
        Examples: "1234-5678-9012"
    database: str, default is Undefined, required.
        The AWS Glue database name.
        Examples: "my_database"
    location: str, default is Undefined, optional.
        The AWS S3 path. Must be in the form of a URL.
        Examples: "s3://datacontract-example-orders-latest/data/{model}"
    format: str, default is Undefined, optional.
        The format of the files.
        Examples: "parquet", "csv", "json", "delta"
    encoding: str, default is "UTF-8", optional.
        Character encoding of the data (RFC 0043). The default comes from the ODCS prose.
        Examples: "UTF-8", "ISO-8859-1", "UTF-16"

    Examples
    --------
    glue = GlueServer {
        server = "glue-sales"
        account = "123456789012"
        database = "sales"
        location = "s3://acme-lake/sales/"
        format = "parquet"
    }
    """
    $type = "glue"
    account: str
    database: str
    location?: str
    format?: str
    encoding?: str = "UTF-8"
