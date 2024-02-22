# deser_json

using Serde

abstract type AbstractFoo end

struct Data{A<:AbstractFoo}
    id::Int64
    method::String
    body::A
end

struct Foo1
    count::Int64
end

struct Foo2 <: AbstractFoo
    num::Int64
end

struct Foo3 <: AbstractFoo
    str::String
end

Serde.tag_key(::Type{Data}) = "method"

Serde.tag(::Type{Data}, ::Val{:foo2}) = Data{Foo2}
Serde.tag(::Type{Data}, ::Val{:foo3}) = Data{Foo3}

# deser_json

h1 = " {\"count\":100} "
h2 = " {\"body\":{\"num\":100},\"method\":\"foo2\",\"id\":100} "
h3 = " {\"body\":{\"str\":\"test\"},\"method\":\"foo3\",\"id\":\"100\"} "
h4 = " {\"body\":{\"str\":\"test\"},\"method\":\"foo4\",\"id\":\"100\"} "

Serde.deser_json(Foo1, h1)
Serde.deser_json(Data, h2)
Serde.deser_json(Data, h3)
Serde.deser_json(Data, h4)

Serde.deser_json(Nothing, Vector{UInt8}())
Serde.deser_json(Missing, Vector{UInt8}())
