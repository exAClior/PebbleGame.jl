using PebbleGame
using Documenter
using DocumenterCitations

DocMeta.setdocmeta!(PebbleGame, :DocTestSetup, :(using PebbleGame); recursive=true)

bib = CitationBibliography(joinpath(@__DIR__,"src/reference.bib"),style=:authoryear)

makedocs(;
    modules=[PebbleGame],
    plugins = [bib],
    authors="Yusheng Zhao <yushengzhao2020@outlook.com> and contributors",
    sitename="PebbleGame.jl",
    format=Documenter.HTML(;
        canonical="https://exAClior.github.io/PebbleGame.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Theory" => "theory.md",
        "Uniformity" => "uniformity.md",
        "Glossary" => "glossary.md",
        "Suggested Readings and References" => "reference.md"
    ],
)

deploydocs(;
    repo="github.com/exAClior/PebbleGame.jl",
)
