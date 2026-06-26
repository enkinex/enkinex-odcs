import .common as srv

schema LocalServer:
    """
    Local File Server.

    Attributes
    ----------
    path: str, default is Undefined, required.
        The relative or absolute path to the data file(s). For example, `./folder/data.parquet`, `./folder/*.parquet`.
    format: str, default is Undefined, required.
        The format of the file(s). For example, `json`, `parquet`, `delta`, `csv`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "local"
    path: str
    format: str

