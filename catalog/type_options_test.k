import runtime

test_every_option_is_registered = lambda {
    every = TypeOptions {
        format = "f"
        exclusiveMaximum = 1
        exclusiveMinimum = 0
        maximum = 1
        minimum = 0
        maxItems = 1
        minItems = 0
        uniqueItems = True
        defaultTimezone = "Etc/UTC"
        timezone = True
        multipleOf = 1
        maxProperties = 1
        minProperties = 0
        required = ["a"]
        pattern = "p"
        maxLength = 1
        minLength = 0
        dimensions = 3
        elementType = "float32"
        distanceMetric = "cosine"
        normalized = False
        embeddingModel = "m"
        embeddingModelVersion = "v"
    }
    assert sorted([k for k in every]) == sorted([k for k in optionLogicalTypes]), "TypeOptions and optionLogicalTypes must list the same options"
}

test_misplaced_options_names_every_offender = lambda {
    options = TypeOptions {pattern = "^a$", dimensions = 3, maxItems = 2}
    assert misplacedOptions(options, "string") == ["maxItems", "dimensions"]
    assert misplacedOptions(options, "vector") == ["maxItems", "pattern"]
    assert misplacedOptions(Undefined, "string") == []
    assert misplacedOptions(TypeOptions {format = "uuid"}, "string") == []
}

test_vector_options_require_dimensions = lambda {
    assert VectorOptions {dimensions = 768}.elementType == "float32"
    assert VectorOptions {dimensions = 768}.normalized == False
    assert "attribute 'dimensions' of VectorOptions is required" in runtime.catch(lambda {
        VectorOptions {}
    })
    assert "dimensions must be >= 1" in runtime.catch(lambda {
        VectorOptions {dimensions = 0}
    })
}
