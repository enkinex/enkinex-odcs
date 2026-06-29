import .common as server

schema LocalServer:
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
    """
    mixin [
        server.ServerMixin
    ]
    $type = "local"
    path: str
    format: str

