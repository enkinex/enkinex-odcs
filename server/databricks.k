import .common as server

schema DatabricksServer:
    """
    Databricks Server.

    Attributes
    ----------
    catalog: str, default is Undefined, required.
        The name of the Hive or Unity catalog.
    schema: str, default is Undefined, required.
        The schema name in the catalog.
    host: str, default is Undefined, optional.
        The Databricks host.
        Examples: "dbc-abcdefgh-1234.cloud.databricks.com"
    """
    mixin [
        server.ServerMixin
    ]
    $type = "databricks"
    catalog: str
    $schema: str
    host?: str

