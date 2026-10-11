import runtime

import .athena
import .postgres
import .s3

test_typed_ports_accept_strings_and_keep_defaults = lambda {
    pg = postgres.PostgresServer {server = "pg", host = "h", port = r"${DB_PORT:-5432}", database = "d", $schema = "s"}
    assert pg.port == r"${DB_PORT:-5432}"
}

test_typed_file_servers_default_encoding = lambda {
    assert s3.S3Server {server = "lake", location = "s3://b/k"}.encoding == "UTF-8"
    assert Server {server = "lake", $type = "s3", location = "s3://b/k"}.encoding == Undefined
}

test_athena_scopes_workgroup = lambda {
    a = athena.AthenaServer {server = "a", $schema = "sales", workgroup = "analytics"}
    assert a.stagingDir == Undefined and a.workgroup == "analytics"
    assert "'workgroup' is only valid for athena servers" in runtime.catch(lambda {
        Server {server = "pg", $type = "postgres", host = "h", port = 5432, database = "d", $schema = "s", workgroup = "w"}
    })
}
