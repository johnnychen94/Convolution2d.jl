module Convolution2D

export conv2D

function zero_pad(X, sz)
	out = zeros(eltype(X), sz)
	c = sz .÷ 2 .+ 1
	r = size(X) .÷ 2
	out[c[1]-r[1]:c[1]+r[1], c[2]-r[2]:c[2]+r[2]] .= X
	out
end

"""
    conv2D(X, kern)

Apply 2D convolution kernel `kern` on array `X`.

## Arguments

- `X::AbstractArray`: must be odd size.
- `kern::AbstractArray`: usually small array, must be odd size.

## Examples

```julia
julia> X = rand(1:5, 5, 5)
5×5 Matrix{Int64}:
 3  5  2  3  5
 1  3  2  1  4
 5  1  4  5  2
 2  4  3  4  1
 3  2  5  2  5

julia> kern = [0 1 0; 1 -4 1; 0 1 0]
3×3 Matrix{Int64}:
 0   1  0
 1  -4  1
 0   1  0

julia> conv2D(X, kern)
5×5 Matrix{Int64}:
  -6  -12    2  -4  -13
   7   -3    2  10   -8
 -16   12   -5  -9    2
   4   -8    5  -5    7
  -8    4  -13   6  -17
```
"""
function conv2D(X, K)
	@assert all(isodd, size(K))

	out = similar(X)

	m, n = size(K)
	r = size(K) .÷ 2
	X_padded = zero_pad(X, size(X) .+ size(K) .- 1)
	K = reverse(K)

	function sum2(X, Y)
		rst = zero(eltype(X))
		@inbounds @simd for i in eachindex(X, Y)
			rst += X[i] * Y[i]
		end
		return rst
	end

	for j in axes(out, 2)
		for i in axes(out, 1)
			patch_X = @view X_padded[i:i+m-1, j:j+n-1]

			out[i, j] = sum2(patch_X, K)
		end
	end
	return out
end

end
