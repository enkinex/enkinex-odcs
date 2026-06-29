import .common as server

schema KafkaServer:
    """
    Apache Kafka Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The bootstrap server of the kafka cluster.
    format: str, default is "json", optional.
        The format of the messages.
        Examples: "json", "avro", "protobuf", "xml"
    """
    mixin [
        server.ServerMixin
    ]
    $type = "kafka"
    host: str
    format?: str = "json"

