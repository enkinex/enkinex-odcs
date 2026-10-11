import .spec as server

schema KinesisServer(server.Server):
    """
    AWS Kinesis Data Streams Server.

    Attributes
    ----------
    stream: str, default is Undefined, optional.
        The name of the Kinesis data stream.
    region: str, default is Undefined, optional.
        AWS region.
        Examples: "eu-west-1"
    format: str, default is Undefined, optional.
        The format of the record.
        Examples: "json", "avro", "protobuf"
    encoding: str, default is "UTF-8", optional.
        Character encoding of the data (RFC 0043). The default comes from the ODCS prose.
        Examples: "UTF-8", "ISO-8859-1", "UTF-16"

    Examples
    --------
    kinesis = KinesisServer {
        server = "kinesis-orders"
        stream = "orders-events"
        region = "eu-west-1"
        format = "json"
    }
    """
    $type = "kinesis"
    stream?: str
    region?: str
    format?: str
    encoding?: str = "UTF-8"
