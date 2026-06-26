import .common as srv

schema SftpServer:
    """
    SFTP Server.

    Attributes
    ----------
    location: str, default is Undefined, required.
        SFTP URL, starting with `sftp://`. For example, `sftp://123.123.12.123/{model}/*.json`.
    format: str, default is Undefined, optional.
        File format. For example, `parquet`, `delta`, `json`, `csv`.
    delimiter: str, default is Undefined, optional.
        Only for format = json. How multiple json documents are delimited within one file. For example, `new_line`, `array`.
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "sftp"
    location: str
    format?: str
    delimiter?: str
