import .spec as server

schema PubSubServer(server.Server):
    """
    Google Cloud Pub/Sub Server.

    Attributes
    ----------
    project: str, default is Undefined, required.
        The GCP project name.

    Examples
    --------
    pubsub = PubSubServer {
        server = "pubsub-events"
        project = "acme-events"
    }
    """
    $type = "pubsub"
    project: str
