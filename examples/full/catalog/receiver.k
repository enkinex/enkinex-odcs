  - id: receivers_obj
    name: receivers
    physicalName: receivers_master
    physicalType: table
    businessName: Receivers Master Data
    description: Master data for all receivers
    tags: [ 'master-data', 'receivers' ]
    properties:
      - id: receiver_id_prop
        name: id
        primaryKey: true
        primaryKeyPosition: 1
        businessName: receiver identifier
        logicalType: string
        physicalType: varchar(18)
        required: true
        description: Unique identifier for receiver
        unique: true
        classification: restricted
      - id: country_code_prop
        name: country_code
        primaryKey: true
        primaryKeyPosition: 2
        businessName: receiver country
        logicalType: string
        physicalType: varchar(2)
        required: true
        description: Country code of the receiver
        classification: public
      - id: receiver_name_prop
        name: receiver_name
        businessName: receiver name
        logicalType: string
        physicalType: varchar(255)
        required: true
        description: Name of the receiver
        classification: restricted
      - id: receiver_type_prop
        name: receiver_type
        businessName: receiver type
        logicalType: string
        physicalType: varchar(20)
        required: false
        description: Type of receiver (individual, business, etc.)
        classification: public
        # Example of nested reference
        relationships:
          - to: receiver_types.type_code
            customProperties:
              - property: description
                value: "Links to receiver type definitions"