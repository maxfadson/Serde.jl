# deser_query

using Serde
using Dates

query = """a=1&b=2.5&c="some_c"&d=[some_d,other_d]&x=2023-05-30T14:08:20.964"""

struct Foo
    a::Int64
    b::Float64
    c::String
    d::Union{Vector{String},Nothing}
    x::DateTime
end

function Serde.deser(
    ::Type{T},
    ::Type{S},
    x::String
) where {T<:Foo,S<:DateTime}
    return DateTime(x)
end

q = Serde.deser_query(Foo, query)
