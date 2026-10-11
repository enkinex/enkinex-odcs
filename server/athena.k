import .spec as server

schema AthenaServer(server.Server):
    """
    AWS Athena Server.

    Attributes
    ----------
    schema: str, default is Undefined, required.
        Identify the schema in the data source in which your tables exist.
    stagingDir: str, default is Undefined, optional.
        Amazon Athena automatically stores query results and metadata information for each query that runs in a query result location that you can specify in Amazon S3.
        Optional since ODCS v3.2.0: a workgroup can set the result location instead.
        Examples: "s3://my_storage_account_name/my_container/path"
    catalog: str, default is "awsdatacatalog", optional.
        Identify the name of the Data Source, also referred to as a Catalog.
    regionName: str, default is Undefined, optional.
        The region your AWS account uses.
        Examples: "eu-west-1"
    workgroup: str, default is Undefined, optional.
        The Athena workgroup that runs the queries; it may define the query result location.
        Examples: "primary", "analytics"

    Examples
    --------
    athena = AthenaServer {
        server = "athena-sales"
        $schema = "sales"
        workgroup = "analytics"
        regionName = "eu-west-1"
    }
    """
    $type = "athena"
    $schema: str
    stagingDir?: str
    catalog?: str = "awsdatacatalog"
    regionName?: str
    workgroup?: str
