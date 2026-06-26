import .common as srv

schema KinesisServer:
    """
    AWS Kinesis Data Streams Server.

    Attributes
    ----------
    region: str, default is Undefined, optional.
        AWS region. For example, `eu-west-1`.
    format: str, default is Undefined, optional.
        The format of the record. For example, `json`, `avro`, `protobuf`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "kinesis"
    region?: str
    format?: str

