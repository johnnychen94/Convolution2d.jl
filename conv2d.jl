# v1.0.0

using Images, TestImages

function zero_pad(X, sz)
	out = zeros(eltype(X), sz)
	c = sz .÷ 2 .+ 1
	r = size(X) .÷ 2
	out[c[1]-r[1]:c[1]+r[1], c[2]-r[2]:c[2]+r[2]] .= X
	out
end

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

camera = imresize(testimage("cameraman"), 255, 255)
kern = [0 1 0
		1 -4 1
		0 1 0]

X = float.(camera)
conv2D(X, kern)
imfilter(X, kern)
