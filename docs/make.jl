using PebbleGame
using Documenter

DocMeta.setdocmeta!(PebbleGame, :DocTestSetup, :(using PebbleGame); recursive=true)

makedocs(;
    modules=[PebbleGame],
    authors="Yusheng Zhao <yushengzhao2020@outlook.com> and contributors",
    sitename="PebbleGame.jl",
    format=Documenter.HTML(;
        canonical="https://exAClior.github.io/PebbleGame.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/exAClior/PebbleGame.jl",
    devbranch="main",
)
