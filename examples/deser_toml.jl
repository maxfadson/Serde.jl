# deser_toml

using Serde

toml = """
    val = 100

    [bar1]
    v1 = 100
    v2 = "ds"

    [[bar2]]
    v1 = 100
    v2 = "ds"

    [[bar2]]
    v1 = 100
    v2 = "ds"
"""

struct Bar1
    v1::Int64
    v2::String
end

struct Bar2
    v1::Int64
    v2::String
end

struct TomlStruct
    val::Int64
    bar1::Bar1
    bar2::Vector{Bar2}
end

Serde.deser_toml(TomlStruct, toml)