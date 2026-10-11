import .spec as server

schema SftpServer(server.Server):
    """
    SFTP Server.

    Attributes
    ----------
    location: str, default is Undefined, required.
        SFTP URL, starting with `sftp://`.
        Examples: "sftp://123.123.12.123/{model}/*.json"
    format: str, default is Undefined, optional.
        File format.
        Examples: "parquet", "delta", "json", "csv"
    delimiter: str, default is Undefined, optional.
        Only for format = json.
        How multiple json documents are delimited within one file.
        Examples: "new_line", "array"
    encoding: str, default is "UTF-8", optional.
        Character encoding of the data (RFC 0043). The default comes from the ODCS prose.
        Examples: "UTF-8", "ISO-8859-1", "UTF-16"

    Examples
    --------
    sftp = SftpServer {
        server = "sftp-exports"
        location = "sftp://files.acme.com/exports/orders.csv"
        format = "csv"
        delimiter = ","
        encoding = "ISO-8859-1"
    }
    """
    $type = "sftp"
    location: str
    format?: str
    delimiter?: str
    encoding?: str = "UTF-8"
