using Serde
using Serde.SerXml

bookshelf_dict = Dict(
    "book" => Dict[
        Dict(
            "author" => Dict("_" => "Erik Engheim"),
            "year" => Dict("_" => "2021"),
            "title" => Dict("lang" => "en", "_" => "Julia for Beginners"),
            "category" => "one",
        ),
        Dict(
            "author" => Dict[
                Dict("_" => "Mykel J. Kochenderfer"),
                Dict("_" => "Tim A. Wheeler"),
                Dict("_" => "Kyle H. Wray"),
            ],
            "year" => Dict("_" => "2020"),
            "title" => Dict("lang" => "en", "_" => "Algorithms for Decision Making"),
            "category" => "two",
        ),
    ],
)

Serde.to_xml(bookshelf) |> println

struct Author
    _::String
end

struct Year
    _::String
end

struct Title
    lang::String
    _::String
end

struct Book
    author::Vector{Author}
    year::Year
    title::Title
    category::String
end

struct Bookshelf
    book::Vector{Book}
end

bookshelf_obj = Bookshelf([
    Book([Author("Erik Engheim")], Year("2021"), Title("en", "Julia for Beginners"), "one"),
    Book(
        [Author("Mykel J. Kochenderfer"), Author("Tim A. Wheeler"), Author("Kyle H. Wray")],
        Year("2020"),
        Title("en", "Algorithms for Decision Making"),
        "two",
    ),
],)

Serde.to_xml(bookshelf) |> println
