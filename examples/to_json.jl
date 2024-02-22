# to_json

using Serde
using Serde.SerJson

using Dates

struct FooJson
    d::DateTime
    b::String
    a::Int64
end

function SerJson.ser_value(
    ::Type{FooJson},
    ::Val{:d},
    v::DateTime
)::String
    return Dates.format(v, "dd/mm/yy")
end

Serde.to_json(FooJson(now(), "test", 100))
Serde.to_json(Dict{String,Int64}("a" => 100, "d" => 300))
