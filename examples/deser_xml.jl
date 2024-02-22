using Serde

struct OperatingSystem
    name::String
    version::String
end

struct Port
    type::String
    version::String
end

struct OS
    type::String
    os::Vector{OperatingSystem}
end

struct Ports
    port::Vector{Port}
end

struct Params
    name::String
    cpu::String
    ram::Int64
    storage::Int64
    release_year::Int64
    has_ssd::Bool
    operating_systems::OS
    ports::Ports
end

struct Tag
    _::Int64
end

struct Computers
    description::String
    computer::Vector{Params}
    tag::Tag
end

xml = """
    <computers description="Office Computers">
        <computer name="Dell" cpu="Intel" ram="16" storage="512" release_year="2020" has_ssd="true">
            <operating_systems type="Desktop">
                <os name="Windows" version="10"/>
                <os name="Ubuntu" version="20.04"/>
            </operating_systems>
            <ports>
                <port type="USB" version="3.0"/>
                <port type="HDMI" version="2.0"/>
            </ports>
        </computer>
        <computer name="Asus" cpu="AMD" ram="8" storage="256" release_year="2021" has_ssd="false">
            <operating_systems type="Gaming">
                <os name="Windows" version="11"/>
                <os name="Fedora" version="33"/>
            </operating_systems>
            <ports>
                <port type="USB" version="3.1"/>
                <port type="DisplayPort" version="1.4"/>
            </ports>
        </computer>
        <tag name="Dell">2000</tag>
    </computers>
"""

# Serde.parse_xml(xml)

computers = Serde.deser_xml(Computers, xml)
