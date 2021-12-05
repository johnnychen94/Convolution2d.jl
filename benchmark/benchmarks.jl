# Usage:
# julia --project=benchmark
# ```julia
# using PkgBenchmark, Convolution2D
# rst = PkgBenchmark.benchmarkpkg(Convolution2D)
# open("benchmark_report.md", "w") do io
#     PkgBenchmark.export_markdown(io, rst)
# end
# ```
using BenchmarkTools
using ImageFiltering
using ImageTransformations
using TestImages
using Convolution2D

const SUITE = BenchmarkGroup()

X = Float32.(imresize(testimage("cameraman"), (255, 255)))
kern = [0 1 0
    1 -4 1
    0 1 0]
SUITE["Convolution2D_255x255_gray"] = @benchmarkable conv2D($X, $kern)
SUITE["ImageFiltering_255x255_gray"] = @benchmarkable imfilter($X, $kern)
