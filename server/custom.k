import regex

import ..common.variable
import .base as base_server

# A network port (JSON `Port`): an integer, or a string so that it can hold a variable reference
# such as ${DB_PORT} resolved at runtime (RFC 0050). A string port must be decimal digits or one
# whole reference (decision D10): the JSON accepts any string.
type Port = int | str

portDigitsPattern = r"^[0-9]+$"

# portOk(port): an integer, or a string of decimal digits or one whole variable reference.
portOk = lambda port: any -> bool {
    typeof(port) == "int" or regex.match(port, portDigitsPattern) or variable.isVariable(port)
}

schema CustomServer(base_server.BaseServer):
    """
    Defines the CustomServer source with all properties shared by all types of sources.
    The permissive superset every typed server extends (through `Server`), so a YAML server of any type parses into it;
    `Server` then scopes the type-specific fields.

    Attributes
    ----------
    account: str, default is Undefined, optional.
        Account used by the server.
    catalog: str, default is Undefined, optional.
        Name of the catalog.
    catalogUrl: str, default is Undefined, optional.
        URL of an Iceberg REST catalog service. Only valid for iceberg servers.
    database: str, default is Undefined, optional.
        Name of the database.
    dataset: str, default is Undefined, optional.
        Name of the dataset.
    delimiter: str, default is Undefined, optional.
        Delimiter.
    encoding: str, default is Undefined, optional.
        Character encoding of the data (RFC 0043). Typed file and stream servers default it to "UTF-8".
        Examples: "UTF-8", "ISO-8859-1", "UTF-16"
    endpointUrl: str, default is Undefined, optional.
        Server endpoint.
    format: str, default is Undefined, optional.
        File format.
    host: str, default is Undefined, optional.
        Host name or IP address.
    location: str, default is Undefined, optional.
        A URL to a location.
    namespace: str, default is Undefined, optional.
        Dot-separated namespace within an Iceberg catalog. Only valid for iceberg servers.
    path: str, default is Undefined, optional.
        Relative or absolute path to the data file(s).
    port: Port, default is Undefined, optional.
        Port to the server: an integer, or a string holding decimal digits or a variable reference.
        No default value is assumed for custom servers.
        Examples: 5432, "5432", "${DB_PORT}"
    project: str, default is Undefined, optional.
        Project name.
    region: str, default is Undefined, optional.
        Cloud region.
    regionName: str, default is Undefined, optional.
        Region name.
    schema: str, default is Undefined, optional.
        Name of the schema.
    serviceName: str, default is Undefined, optional.
        Name of the service.
    stagingDir: str, default is Undefined, optional.
        Staging directory.
    stream: str, default is Undefined, optional.
        Name of the data stream.
    warehouse: str, default is Undefined, optional.
        Name of the cluster or warehouse.
    workgroup: str, default is Undefined, optional.
        Athena workgroup. Only valid for athena servers.
    """
    account?: str
    catalog?: str
    catalogUrl?: str
    database?: str
    dataset?: str
    delimiter?: str
    encoding?: str
    endpointUrl?: str
    format?: str
    host?: str
    location?: str
    namespace?: str
    path?: str
    port?: Port
    project?: str
    region?: str
    regionName?: str
    $schema?: str
    serviceName?: str
    stagingDir?: str
    stream?: str
    warehouse?: str
    workgroup?: str

    check:
        port == Undefined or portOk(port), "a string port must be decimal digits or a variable reference"
