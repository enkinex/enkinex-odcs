import .common as server

schema BigQueryServer:
    """
    Google BigQuery Server.

    Attributes
    ----------
    project: str, default is Undefined, required.
        The GCP project name.
    dataset: str, default is Undefined, required.
        The GCP dataset name.
    """
    mixin [
        server.ServerMixin
    ]
    $type = "bigquery"
    project: str
    dataset: str

