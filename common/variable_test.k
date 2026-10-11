test_variable_builds_reference_tokens = lambda {
    assert variable("DB_HOST") == r"${DB_HOST}"
    assert variable("DB_PORT", "5432") == r"${DB_PORT:-5432}"
    assert variable("DB_PORT", "") == r"${DB_PORT}"
}

test_is_variable_matches_one_whole_reference = lambda {
    assert all v in [r"${CREATED_AT}", r"${DB_PORT:-5432}", r"${X:-}", r"${_private_1}"] {
        isVariable(v)
    }
    assert not any v in [r"prefix-${X}", r"${X}-suffix", r"${X}${Y}", r"${1X}", r"${X-Y}", r"$X", r"{X}", r"${X", ""] {
        isVariable(v)
    }
}

test_has_variable_finds_references_anywhere = lambda {
    assert all v in [r"prefix-${X}", r"SELECT * FROM ${TABLE} WHERE d > ${CUTOFF:-2024-01-01}", r"${X}"] {
        hasVariable(v)
    }
    assert not any v in ["plain text", r"$X", r"${1X}", r"${X"] {
        hasVariable(v)
    }
}
