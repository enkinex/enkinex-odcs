import .spec as server

schema BigQueryServer(server.Server):
    """
    Google BigQuery Server.

    Attributes
    ----------
    project: str, default is Undefined, required.
        The GCP project name.
    dataset: str, default is Undefined, required.
        The GCP dataset name.

    Examples
    --------
    bigquery = BigQueryServer {
        server = "bq-sales"
        project = "acme-analytics"
        dataset = "sales"
    }
    """
    $type = "bigquery"
    project: str
    dataset: str
