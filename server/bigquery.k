import .common as srv

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
        srv.ServerMixin
    ]
    $type = "bigquery"
    project: str
    dataset: str

