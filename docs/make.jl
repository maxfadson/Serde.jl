using Documenter
using Serde

DocMeta.setdocmeta!(Serde, :DocTestSetup, :(using Serde); recursive = true)

makedocs(
    modules = [Serde],
    sitename = "Serde.jl",
    pages = [
        "Home" => "index.md",
        "API Reference" => [
            "pages/json.md",
            "pages/toml.md",
            "pages/csv.md",
            "pages/query.md",
            "pages/xml.md",
            "pages/utils.md",
            ],
        "For Developers" => [
            "pages/extended_ser.md",
            "pages/extended_de.md",
        ]
    ],
    repo = Documenter.Remotes.GitLab("bhft/Serde.jl"),
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical = "https://bhft.gitlab.io/Serde.jl",
        assets = [],
        sidebar_sitename = true,
        repolink = "https://gitlab.com/bhft/Serde.jl.git",
    ),
    checkdocs = :missing_docs
)
