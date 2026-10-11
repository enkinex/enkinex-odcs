import .spec as server

schema HanaServer(server.Server):
    """
    SAP HANA Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        Host of the HANA server.
    port: Port, default is Undefined, optional.
        Port of the HANA server.
    database: str, default is Undefined, optional.
        Name of the database (tenant).
    schema: str, default is Undefined, optional.
        Name of the schema.

    Examples
    --------
    hana = HanaServer {
        server = "hana-erp"
        host = "hana.acme.com"
        port = 30015
        database = "HXE"
        $schema = "SALES"
    }
    """
    $type = "hana"
    host: str
    port?: server.Port
    database?: str
    $schema?: str
