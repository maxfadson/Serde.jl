# to_query

using Serde
using Serde.SerQuery

using Dates

struct FooQuery
    d::DateTime
    b::String
    a::Int64
    v::Vector{String}
end

function SerQuery.ser_value(
    ::Type{FooQuery},
    ::Val{:d},
    v::DateTime
)::String
    return Dates.format(v, "dd/mm/yy")
end

Serde.to_query(FooQuery(now(), "test", 100, ["lol", "kek"]))
Serde.to_query(Dict{String,Any}("a" => 100, "d" => 300, "v" => ["aaa", "oooo"]))
Serde.to_query(FooQuery(now(), "test", 100, ["lol", "kek"]), sort_keys=true, escape=false)
Serde.to_query(Dict{String,Any}("v" => 100, "d" => 300, "a" => ["aaa", "oooo"]), sort_keys=true)

function Serde.SerQuery.ser_pair(
    ::Type{StructType},
    ::Type{ValueType},
    key::String,
    value::ValueType,
)::Tuple{Vector{String},Vector{String}} where {StructType<:FooQuery,ValueType<:AbstractVector}
    keys = [key for _ in value]
    return (keys, value)
end

Serde.to_query(FooQuery(now(), "test lol", 100, ["lol", "kek"]), sort_keys=true, escape=false)