import enkinex_odcs.common.property
import enkinex_odcs.contract.support

SlackSupport = support.Support {
    channel = "#product-help"
    tool = "slack"
}

EmailSupport = support.Support {
    channel = "datacontract-ann"
    tool = "email"
    url = "mailto:datacontract-ann@bitol.io"
}

FeedbackSupport = support.Support {
    channel = "Feedback"
    description = "General Product Feedback (Public)"
    url = "https://product-feedback.com"
}

TeamsSupport = support.Support {
    channel = "product-issues"
    tool = "teams"
    scope = "issues"
    customProperties = [
        property.CustomProperty {
            property = "servicehours"
            value = "9-5 CET"
        }
    ]
}
