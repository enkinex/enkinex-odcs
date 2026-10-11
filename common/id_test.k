import regex
import runtime

test_stable_id_accepts_what_the_denylist_allows = lambda {
    assert all id in ["fdir:ISU:TAD", "urn:uuid:c47a1e10-0001-4c00", "café", r"${ID}", "a-b_c", "x+y=z"] {
        regex.match(id, stableIdPattern)
    }
}

test_stable_id_rejects_each_denied_character = lambda {
    assert not any id in ["fdir.dataset", "a#b", "a/b", r"a\b", "a@b", "a!b", "a%b", "a&b", "x^y", "a b", "tab\tid", ""] {
        regex.match(id, stableIdPattern)
    }
    assert "id must match" in runtime.catch(lambda {
        StableId {id = "fdir.dataset"}
    })
}
