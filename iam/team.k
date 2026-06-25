import ..common.authoritative as ad
import ..common.property as prop

schema TeamMember:
    """
    Team member.

    Attributes
    ----------
    id: str, default is Undefined, optional.
        A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.
    username: str, default is Undefined, required.
        The user's username or email.
    name: str, default is Undefined, optional.
        The user's name.
    description: str, default is Undefined, optional.
        The user's description.
    role: str, default is Undefined, optional.
        The user's job role; Examples might be owner, data steward. There is no limit on the role.
    dateIn: str, default is Undefined, optional.
        The date when the user joined the team.
    dateOut: str, default is Undefined, optional.
        The date when the user ceased to be part of the team.
    replacedByUsername: str, default is Undefined, optional.
        The username of the user who replaced the previous user.
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.
    authoritativeDefinitions: [ad.AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the data contract.
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.
    """
    id?: str
    username: str
    name?: str
    description?: str
    role?: str
    dateIn?: str
    dateOut?: str
    replacedByUsername?: str
    customProperties?: [prop.CustomProperty]
    authoritativeDefinitions?: [ad.AuthoritativeDefinition]
    tags?: [str]

schema Team:
    """
    Team information.

    Attributes
    ----------
    id: str, default is Undefined, optional.
        A unique identifier for the element used to create stable, refactor-safe references. Recommended for elements that will be referenced.
    name: str, default is Undefined, optional.
        Team name.
    description: str, default is Undefined, optional.
        Team description.
    members: [TeamMember], default is Undefined, optional.
        List of members.
    customProperties: [prop.CustomProperty], default is Undefined, optional.
        A list of key/value pairs for custom properties.
    authoritativeDefinitions: [ad.AuthoritativeDefinition], default is Undefined, optional.
        List of links to sources that provide more details on the data contract.
    tags: [str], default is Undefined, optional.
        A list of tags that may be assigned to the elements (object or property); the tags keyword may appear at any level. For example, finance, sensitive, employee_record.

    Examples
    --------
    team = Team {
        id = "sc_team"
        name = "TSC"
        description = "The greatest team ever."
        members = [
            TeamMember {
                username = "ceastwood"
                role = "Data Scientist"
                dateIn = "2022-08-02"
                dateOut = "2022-10-01"
                replacedByUsername = "mhopper"
            },
            TeamMember {
                id = "mhopper_member"
                username = "mhopper"
                role = "Data Scientist"
                dateIn = "2022-10-01"
            },
            TeamMember {
                id = "daustin"
                username = "daustin"
                role = "Owner"
                description = "Keeper of the grail"
                name = "David Austin"
                dateIn = "2022-10-01"
            }
        ]
    }
    """
    id?: str
    name?: str
    description?: str
    members?: [TeamMember]
    customProperties?: [prop.CustomProperty]
    authoritativeDefinitions?: [ad.AuthoritativeDefinition]
    tags?: [str]

