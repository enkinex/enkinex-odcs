import .common as srv

schema GlueServer:
    """
    AWS Glue Server.

    Attributes
    ----------
    account: str, default is Undefined, required.
        The AWS Glue account. For example, `1234-5678-9012`.
    database: str, default is Undefined, required.
        The AWS Glue database name. For example, `my_database`.
    location: str, default is Undefined, optional.
        The AWS S3 path. Must be in the form of a URL. For example, `s3://datacontract-example-orders-latest/data/{model}`.
    format: str, default is Undefined, optional.
        The format of the files. For example, `parquet`, `csv`, `json`, `delta`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "glue"
    account: str
    database: str
    location?: str
    format?: str

