import .base

schema KinesisServer(base.ServerObject):
    """
    AWS Kinesis Data Streams Server.

    Attributes
    ----------
    stream: str, default is Undefined, required.
        The name of the Kinesis data stream.
    region: str, default is Undefined, optional.
        AWS region.
        Examples: "eu-west-1"
    format: str, default is Undefined, optional.
        The format of the record.
        Examples: "json", "avro", "protobuf"
    """
    $type = "kinesis"
    stream: str
    region?: str
    format?: str

