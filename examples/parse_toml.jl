# parse_toml

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

Serde.parse_toml(toml)
