import .spec as server

schema ExasolServer(server.Server):
    """
    Exasol Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        Host of the Exasol server. May be a cluster connection range.
        Examples: "exasol.acme.com", "n11..14.acme.com"
    port: Port, default is 8563, optional.
        Port of the Exasol server.
    schema: str, default is Undefined, optional.
        Name of the schema.

    Examples
    --------
    exasol = ExasolServer {
        server = "exasol-analytics"
        host = "exasol.acme.com"
        $schema = "sales"
    }
    """
    $type = "exasol"
    host: str
    port?: server.Port = 8563
    $schema?: str
