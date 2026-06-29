import .common as server

schema AzureServer:
    """
    Azure Blob Storage Server.

    Attributes
    ----------
    location: str, default is Undefined, required.
        Fully qualified path to Azure Blob Storage or Azure Data Lake Storage (ADLS), supports globs.
        Examples: "az://my_storage_account_name.blob.core.windows.net/my_container/path/*.parquet", "abfss://my_storage_account_name.dfs.core.windows.net/my_container_name/path/*.parquet"
    format: str, default is Undefined, required.
        File format.
        Examples: "parquet", "delta", "json", "csv".
    delimiter: str, default is Undefined, optional.
        Only for format = json. How multiple json documents are delimited within one file.
        Examples: "new_line", "array"
    """
    mixin [
        server.ServerMixin
    ]
    $type = "azure"
    location: str
    format: str
    delimiter?: str

