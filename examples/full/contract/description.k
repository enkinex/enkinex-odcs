import enkinex_odcs.contract.description
import enkinex_odcs.common.authoritative

SampleContractDescription = description.Description {
    purpose = "Views built on top of the seller tables."
    limitations = "Data based on seller perspective, no buyer information"
    usage = "Predict sales over time"
    authoritativeDefinitions = [
        authoritative.AuthoritativeDefinition {
            $type = "privacy-statement"
            url = "https://example.com/gdpr.pdf"
        }
    ]
}
