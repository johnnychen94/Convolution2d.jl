using Documenter
using Images, TestImages
using Convolution2D

format = Documenter.HTML(edit_link = "master",
                         prettyurls = get(ENV, "CI", nothing) == "true")

makedocs(modules  = [Convolution2D],
         format   = format,
         sitename = "Convolution2D",
         pages    = ["index.md"])

deploydocs(repo   = "github.com/johnnychen94/Convolution2d.jl.git")
