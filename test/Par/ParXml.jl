# Par/ParXml

@testset verbose = true "ParXml" begin
    @testset "Case №1: XML parse" begin
        xml = """
        <?xml version="1.0" encoding="UTF-8"?>
        <bookstore>
          <book category="one">
            <title lang="en">Julia for Beginners</title>
            <author>Erik Engheim</author>
            <year>2021</year>
          </book>
          <book category="two">
            <title lang="en">Algorithms for Decision Making</title>
            <author>Mykel J. Kochenderfer</author>
            <author>Tim A. Wheeler</author>
            <author>Kyle H. Wray</author>
            <year>2020</year>
          </book>
        </bookstore>
        """
        exp = Dict{String, Any}(
            "book" => Any[
                Dict{String, Any}(
                    "author" => "Erik Engheim", 
                    "year" => "2021", 
                    "title" => Dict{String, Any}(
                        "lang" => "en", 
                        "" => "Julia for Beginners"
                    ), 
                    "category" => "one"
                ), 
                Dict{String, Any}(
                    "author" => Any[
                        "Mykel J. Kochenderfer", 
                        "Tim A. Wheeler", 
                        "Kyle H. Wray"], 
                        "year" => "2020", 
                        "title" => Dict{String, Any}(
                            "lang" => "en", 
                            "" => "Algorithms for Decision Making"
                        ), 
                        "category" => "two"
                    )
                ]
            )
        @test Serde.parse_xml(xml) == exp
    end

    @testset "Case №2: Escaping tests" begin
        xml = """<valid>"'></valid>"""
        exp = "\"'>"
        @test Serde.parse_xml(xml) == exp

        xml = """<valid attribute=">"/>"""
        exp = Dict{String, Any}("attribute" => ">")
        @test Serde.parse_xml(xml) == exp

        xml = """<valid attribute="'"/>"""
        exp = Dict{String, Any}("attribute" => "'")
        @test Serde.parse_xml(xml) == exp

        xml = """<valid attribute='"'/>"""
        exp = Dict{String, Any}("attribute" => "\"")
        @test Serde.parse_xml(xml) == exp

        xml = """
        <valid>
          <!-- "'<>& comment -->
        </valid>
        """
        exp = Dict{String, Any}()
        @test Serde.parse_xml(xml) == exp

        xml = """<valid><![CDATA[<sender>John Smith</sender>]]></valid>"""
        exp = "<sender>John Smith</sender>"
        @test Serde.parse_xml(xml) == exp
    end

    @testset "Case №3: Exceptions tests" begin
        xml = """
        <wrong_order>
          <?xml version="1.0" encoding="UTF-8"?>
        </wrong_order>
        """
        @test_throws Serde.ParXml.XmlSyntaxError Serde.parse_xml(xml)

        xml = """
        <root>
          <base>qwerty</base>
          <unclosed_tag>
        </root>
        """
        @test_throws Serde.ParXml.XmlSyntaxError Serde.parse_xml(xml)

        xml = """
        <wrong_order>
          <tag>
          </wrong_order>
        </tag>
        """
        @test_throws Serde.ParXml.XmlSyntaxError Serde.parse_xml(xml)
    end
end
