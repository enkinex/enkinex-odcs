import runtime

test_port_takes_an_integer_digits_or_a_variable = lambda {
    assert all p in [5432, "5432", r"${DB_PORT}", r"${DB_PORT:-5432}"] {
        portOk(p)
    }
    assert not any p in ["eighty", "54 32", "5432/tcp", r"port ${DB_PORT}", ""] {
        portOk(p)
    }
    assert "a string port must be decimal digits or a variable reference" in runtime.catch(lambda {
        CustomServer {server = "s", port = "eighty"}
    })
}
