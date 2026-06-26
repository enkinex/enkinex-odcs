import .common as srv

schema S3Server:
    """
    Amazon S3 Server.

    Attributes
    ----------
    location: str, default is Undefined, required.
        S3 URL, starting with `s3://`. For example, `s3://datacontract-example-orders-latest/data/{model}/*.json`.
    endpointUrl: str, default is Undefined, optional.
        The server endpoint for S3-compatible servers. For example, `https://minio.example.com`.
    format: str, default is Undefined, optional.
        File format. For example, `parquet`, `delta`, `json`, `csv`.
    delimiter: str, default is Undefined, optional.
        Only for format = json. How multiple json documents are delimited within one file. For example, `new_line`, `array`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "s3"
    location: str
    endpointUrl?: str
    format?: str
    delimiter?: str
