import .spec as server

schema LocalServer(server.Server):
    """
    Local File Server.

    Attributes
    ----------
    path: str, default is Undefined, required.
        The relative or absolute path to the data file(s).
        Examples: "./folder/data.parquet", "./folder/*.parquet"
    format: str, default is Undefined, required.
        The format of the file(s).
        Examples: "json", "parquet", "delta", "csv"
    encoding: str, default is "UTF-8", optional.
        Character encoding of the data (RFC 0043). The default comes from the ODCS prose.
        Examples: "UTF-8", "ISO-8859-1", "UTF-16"

    Examples
    --------
    local = LocalServer {
        server = "local-files"
        path = "./data/orders.parquet"
        format = "parquet"
    }
    """
    $type = "local"
    path: str
    format: str
    encoding?: str = "UTF-8"
