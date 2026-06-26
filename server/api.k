import .common as srv

schema ApiServer:
    """
    API Server.

    Attributes
    ----------
    location: str, default is Undefined, required.
        The URL to the API, For example, `https://api.example.com/v1`
    """
    mixin [
        srv.ServerMixin
    ]
    $type = "api"
    location: str

