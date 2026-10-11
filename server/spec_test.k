import runtime

import .athena
import .exasol
import .iceberg
import .poet
import .postgres
import .s3
import .versant

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

test_new_sources_carry_json_defaults = lambda {
    v = versant.VersantServer {server = "nosql", database = "policies"}
    assert v.host == "localhost" and v.port == 5019
    assert poet.PoetServer {server = "parts", database = "catalog"}.host == "LOCAL"
    assert exasol.ExasolServer {server = "x", host = "exasol.acme.com"}.port == 8563
}

test_synonyms_share_their_primary_rule = lambda {
    assert "zen server requires 'host' and 'database'" in runtime.catch(lambda {
        Server {server = "b", $type = "btrieve", database = "d"}
    })
    assert "poet server requires 'database'" in runtime.catch(lambda {
        Server {server = "f", $type = "fastobjects"}
    })
}

test_iceberg_fields_are_scoped = lambda {
    assert iceberg.IcebergServer {server = "i", catalog = "c", catalogUrl = "https://polaris.acme.com", namespace = "db.s"}.namespace == "db.s"
    assert "'catalogUrl' is only valid for iceberg servers" in runtime.catch(lambda {
        Server {server = "c", $type = "custom", catalogUrl = "https://polaris.acme.com"}
    })
}
