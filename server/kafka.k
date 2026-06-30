import .base

schema KafkaServer(base.ServerObject):
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
    $type = "kafka"
    host: str
    format?: str = "json"

