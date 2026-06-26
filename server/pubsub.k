import .common as srv

schema PubSubServer:
    """
    Google Cloud Pub/Sub Server.

    Attributes
    ----------
    project: str, default is Undefined, required.
        The GCP project name.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "pubsub"
    project: str

