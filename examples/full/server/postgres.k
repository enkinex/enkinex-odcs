import enkinex_odcs.server.common as common_server

LocalPostgresServer = common_server.Server {
    $type = "postgres"
    server = "my-postgres"
    host = "localhost"
    port = 5432
    database = "pypl-edw"
    $schema = "pp_access_views"
}
