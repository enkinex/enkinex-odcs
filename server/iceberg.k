import .spec as server

schema IcebergServer(server.Server):
    """
    Apache Iceberg REST catalog.

    Attributes
    ----------
    catalog: str, default is Undefined, required.
        Catalog name as registered in the query engine or catalog service.
        Examples: "my_catalog"
    catalogUrl: str, default is Undefined, required.
        URL of the Iceberg compatible REST catalog service (Polaris, S3 Tables, Nessie, Unity Catalog, Glue, etc.).
        Examples: "https://my-catalog-service.com"
    namespace: str, default is Undefined, optional.
        Dot-separated namespace or schema path within the catalog.
        Examples: "db.schema", "db"
    warehouse: str, default is Undefined, optional.
        Logical catalog or base location for the catalog to use.
        Examples: "s3://my-bucket/warehouse/sales/", "production"

    Examples
    --------
    iceberg = IcebergServer {
        server = "iceberg-lakehouse"
        catalog = "sales_catalog"
        catalogUrl = "https://polaris.acme.com/api/catalog"
        namespace = "sales.orders"
        warehouse = "s3://acme-lake/warehouse/sales/"
    }
    """
    $type = "iceberg"
    catalog: str
    catalogUrl: str
    namespace?: str
    warehouse?: str
