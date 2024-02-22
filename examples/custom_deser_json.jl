# custom_deser_json

using Serde

abstract type AbstractFoo end

struct Data{A<:AbstractFoo}
    id::Int64
    method::String
    body::A
end

struct Foo2 <: AbstractFoo
    num::Int64
end

struct Foo3 <: AbstractFoo
    str::String
end

# deser_json

h2 = " {\"body\":{\"num\":100},\"method\":\"Foo2\",\"id\":100} "
h3 = " {\"body\":{\"str\":\"test\"},\"method\":\"Foo3\",\"id\":\"100\"} "
h4 = " {\"body\":{\"str\":\"test\"},\"method\":\"Foo2\",\"id\":\"100\"} "

keymap = Dict{String,Type}(
    "Foo2" => Data{Foo2},
    "Foo3" => Data{Foo3}
)

function type(keymap, object, key)::DataType
    method = try
        object[key]
    catch
        throw(Serde.ParamError(key))
    end

    try
        keymap[method]
    catch
        throw(Serde.TagError(method))
    end
end

Serde.deser_json(object -> type(keymap, object, "method"), h2)
Serde.deser_json(object -> type(keymap, object, "method"), h3)
Serde.deser_json(object -> type(keymap, object, "method"), h4)
