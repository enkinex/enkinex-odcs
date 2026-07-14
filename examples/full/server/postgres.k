import enkinex_odcs.server.postgres

LocalPostgresServer = postgres.PostgresServer {
    server = "my-postgres"
    host = "localhost"
    port = 5432
    database = "pypl-edw"
    $schema = "pp_access_views"
}
