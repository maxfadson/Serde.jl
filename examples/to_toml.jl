# to_toml

using Serde
using Serde.SerToml

h = Dict(
    "key1" => [
        Dict("a" => "100", "c" => 200),
        Dict("a" => 100, "c" => 200),
        Dict("a" => 100, "c" => 200),
    ],
    "key2" => Dict("a" => 100, "c" => 200),
    "val1" => [1, 2, 3, 4, 5, 6],
    "val2" => [1, 2, 3, 4, 5, 6],
)

Serde.to_toml(h) |> println

h = Dict(
    "bar" => "test",
    "foo" => Dict(
        "baz" => "hi",
        "conf" => Dict(
            "boo" => "aaa",
            "monf" => Dict(
                "zaa" => "ppp",
                "loo" => "coconut"
            ),
            "tonf" => Dict(
                "lol" => "kek",
                "val1" => [Dict("LOL" => "1"), Dict("LOL" => "2"), Dict("LOL" => "3")],
                "val2" => [1, 2, 3, 4, 5, 6],
            )
        )
    )
)
Serde.to_toml(h) |> println

struct Bar1
    v1::Int64
    v2::String
end

struct Bar2
    v1::Int64
    v2::String
end

struct Foo
    val::Int64
    bar1::Bar1
    bar2::Vector{Bar2}
end

SerToml.ser_name(::Type{Foo}, ::Val{:val}) = :test
SerToml.ser_value(::Type{Foo}, ::Val{:bar1}, x::Bar1) = 1

Serde.to_toml(
    Foo(100, Bar1(100, "ds"), [Bar2(100, "ds"), Bar2(100, "ds")]),
) |> println
