import .common as server

schema KinesisServer:
    """
    AWS Kinesis Data Streams Server.

    Attributes
    ----------
    region: str, default is Undefined, optional.
        AWS region.
        Examples: "eu-west-1"
    format: str, default is Undefined, optional.
        The format of the record.
        Examples: "json", "avro", "protobuf"
    """
    mixin [
        server.ServerMixin
    ]
    $type = "kinesis"
    region?: str
    format?: str

