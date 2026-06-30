import .base

schema IBMDB2Server(base.ServerObject):
    """
    IBM DB2 Server.

    Attributes
    ----------
    host: str, default is Undefined, required.
        The host of the IBM DB2 server.
    port: int, default is Undefined, required.
        The port of the IBM DB2 server.
    database: str, default is Undefined, required.
        The name of the database.
    schema: str, default is Undefined, optional.
        The name of the schema.
    """
    $type = "db2"
    host: str
    port: int
    database: str
    $schema?: str

