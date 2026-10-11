import .spec as server

schema S3Server(server.Server):
    """
    Amazon S3 Server.

    Attributes
    ----------
    location: str, default is Undefined, required.
        S3 URL, starting with `s3://`.
        Examples: "s3://datacontract-example-orders-latest/data/{model}/*.json"
    endpointUrl: str, default is Undefined, optional.
        The server endpoint for S3-compatible servers.
        Examples: "https://minio.example.com`"
    format: str, default is Undefined, optional.
        File format.
        Examples: "parquet", "delta", "json", "csv"
    delimiter: str, default is Undefined, optional.
        Only for format = json.
        How multiple json documents are delimited within one file.
        Examples: "new_line", "array"
    encoding: str, default is "UTF-8", optional.
        Character encoding of the data (RFC 0043). The default comes from the ODCS prose.
        Examples: "UTF-8", "ISO-8859-1", "UTF-16"

    Examples
    --------
    s3 = S3Server {
        server = "s3-orders"
        location = "s3://acme-lake/sales/orders/*.parquet"
        format = "parquet"
    }
    """
    $type = "s3"
    location: str
    endpointUrl?: str
    format?: str
    delimiter?: str
    encoding?: str = "UTF-8"
