import ..common.minixs as mix
import ..common.property as prop

schema Support:
    """
    Support and communication channels help consumers find help regarding their use of the data contract.

    Attributes
    ----------
    channel: str, default is Undefined, required.
        Channel name or identifier.
    url: str, default is Undefined, optional.
        Access URL using normal [URL scheme](https://en.wikipedia.org/wiki/URL#Syntax) (https, mailto, etc.).
    description: str, default is Undefined, optional.
        Description of the channel, free text.
    tool: str, default is Undefined, optional.
        Name of the tool, value can be `email`, `slack`, `teams`, `discord`, `ticket`, `googlechat`, or `other`.
    scope: str, default is Undefined, optional.
        Scope can be: `interactive`, `announcements`, `issues`, `notifications`.
    invitationUrl: str, default is Undefined, optional.
        Some tools uses invitation URL for requesting or subscribing. Follows the [URL scheme](https://en.wikipedia.org/wiki/URL#Syntax).
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.

    Examples
    --------
    announcements = Support {
        id = "all_announcements"
        channel = "channel-name-or-identifier-for-all-announcement"
        description = "All announcement for all data contracts"
        tool = "teams"
        scope = "announcements"
        url = "https://bitol.io/teams/channel/all-announcements"
    }

    email = Support {
        id = "email_announcements"
        channel = "channel-name-or-identifier"
        tool = "email"
        scope = "announcements"
        url = "mailto:datacontract-ann@bitol.io"
    }

    ticket = Support {
        id = "ticket_support"
        channel = "channel-name-or-identifier"
        tool = "ticket"
        url = "https://bitol.io/ticket/my-product"
    }
    """
    mixin [
        mix.OptionalStableIdMixin
    ]
    channel: str
    url?: str
    description?: str
    tool?: str
    scope?: str
    invitationUrl?: str
    customProperties?: [prop.CustomProperty]

