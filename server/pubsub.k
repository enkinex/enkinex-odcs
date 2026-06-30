import .base

schema PubSubServer(base.ServerObject):
    """
    Google Cloud Pub/Sub Server.

    Attributes
    ----------
    project: str, default is Undefined, required.
        The GCP project name.
    """
    $type = "pubsub"
    project: str

