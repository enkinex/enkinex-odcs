import .common as server

schema ApiServer:
    """
    API Server.

    Attributes
    ----------
    location: str, default is Undefined, required.
        The URL to the API.
        Examples: "https://api.example.com/v1"
    """
    mixin [
        server.ServerMixin
    ]
    $type = "api"
    location: str

