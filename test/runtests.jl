using Convolution2D
using Test

@testset "Convolution2D" begin
    X = [
        1  4  5  4  4
        1  3  4  5  3
        2  3  5  4  4
        4  4  2  1  1
        3  3  3  2  4
    ]
    kern = [0 1 0
		1 -4 1
		0 1 0]
    out = conv2D(X, kern)
    @test out[3, 3] == -7

    X =  [5  2  5  3
        1  2  2  4
        1  1  1  4
        3  2  4  3]
    @test_broken conv2D(X, kern)
end
