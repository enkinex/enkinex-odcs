import .common as server

schema PubSubServer:
    """
    Google Cloud Pub/Sub Server.

    Attributes
    ----------
    project: str, default is Undefined, required.
        The GCP project name.
    """
    mixin [
        server.ServerMixin
    ]
    $type = "pubsub"
    project: str

