import .base

schema BigQueryServer(base.ServerObject):
    """
    Google BigQuery Server.

    Attributes
    ----------
    project: str, default is Undefined, required.
        The GCP project name.
    dataset: str, default is Undefined, required.
        The GCP dataset name.
    """
    $type = "bigquery"
    project: str
    dataset: str

