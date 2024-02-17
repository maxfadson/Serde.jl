module ParXml

export XmlSyntaxError
export parse_xml

using EzXML

"""
    XmlSyntaxError <: Exception

Exception thrown when a [`parse_xml`](@ref) fails due to incorrect XML syntax or any underlying error that occurs during parsing.

## Fields
- `message::String`: The error message.
- `exception::Exception`: The catched exception.
"""
struct XmlSyntaxError <: Exception
    message::String
    exception::EzXML.XMLError
end

Base.show(io::IO, e::XmlSyntaxError) = print(io, e.message)

function xml_to_dict(xml_string::AbstractString, dict_type::Type=Dict{String,Any}; kw...)
    xml = parsexml(xml_string)
    r = xml_to_dict(xml, dict_type; kw...)
    return r
end

function xml_to_dict(xml::EzXML.Document, dict_type::Type=Dict{String,Any}; declaration_struct=false, kw...)
    r = dict_type()
    r["version"] = version(xml)
    try
        r["encoding"] = encoding(xml)
    catch
    end
    root_name = nodename(root(xml))
    r[root_name] = xml_to_dict(root(xml), dict_type; kw...)
    return (declaration_struct ? r : r[root_name])
end

is_text(n::EzXML.Node) = istext(n) || iscdata(n)

function is_empty(n::EzXML.Node)
    c = nodecontent(n)
    return isempty(c) || all(isspace, c)
end

has_text(n::EzXML.Node) = is_text(n) && !is_empty(n)

function xml_to_dict(n::EzXML.Node, dict_type::Type=Dict{String,Any}; strip_text=false, kw...)
    r = dict_type()
    for a in eachattribute(n)
        r[nodename(a)] = nodecontent(a)
    end

    element_has_text = any(has_text, eachnode(n))
    
    element_has_mixed_tags = false

    tags = []

    for c in eachelement(n)
        tag = nodename(c)
        if isempty(tags) || tag != tags[end]
            if tag in tags
                element_has_mixed_tags = true
                break
            end
            push!(tags, tag)
        end
    end

    if element_has_text || element_has_mixed_tags
        r[""] = Any[]
    end

    for c in eachnode(n)
        if iselement(c)
            n = nodename(c)
            v = xml_to_dict(c, dict_type; strip_text=strip_text)
            if haskey(r, "")
                push!(r[""], dict_type(n => v))
            elseif haskey(r, n)
                a = isa(r[n], Array) ? r[n] : Any[r[n]]
                push!(a, v)
                r[n] = a
            else
                r[n] = v
            end
        elseif is_text(c) && haskey(r, "")
            push!(r[""], nodecontent(c))
        end
    end

    if haskey(r, "")
        v = r[""]
        if length(v) == 1 && isa(v[1], AbstractString)
            if strip_text
                v[1] = strip(v[1])
            end
            r[""] = v[1]
            if length(r) == 1
                r = r[""]
            end
        end
    end

    return r
end

"""
    parse_xml(x::AbstractString; kw...) -> Dict{String,Any}
    parse_xml(x::Vector{UInt8}; kw...) -> Dict{String,Any}

Parse a XML string `x` (or vector of UInt8) into a dictionary. All value types are considered a string by default.

## Keyword arguments
- `declaration_struct::Bool = false`: If false, only the contents of the root node are returned. If true, the declaration tags and the entire root node are returned.
- `strip_text::Bool = false`: Defines text strip usage.

## Examples

```julia-repl
julia> xml = \"\"\"
       <?xml version="1.0" encoding="UTF-8" ?>
       <root>
       <string>qwerty</string>
       <vector>1</vector>
       <vector>2</vector>
       <vector>3</vector>
       <dictionary>
           <string>123</string>
       </dictionary>
       </root>
       \"\"\";

julia> parse_xml(xml)
Dict{String, Any} with 3 entries:
  "string"     => "qwerty"
  "vector"     => Any["1", "2", "3"]
  "dictionary" => Dict{String, Any}("string"=>"123")
```
"""
function parse_xml end

function parse_xml(x::S; kw...) where {S<:AbstractString}
    try
        xml_to_dict(x; kw...)
    catch e
        throw(XmlSyntaxError("invalid XML syntax", e))
    end
end

function parse_xml(x::Vector{UInt8}; kw...)
    return parse_xml(unsafe_string(pointer(x), length(x)); kw...)
end

end
