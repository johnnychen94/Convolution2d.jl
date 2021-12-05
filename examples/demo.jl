using Convolution2D
using Images, TestImages

camera = imresize(testimage("cameraman"), 255, 255)
kern = [0 1 0
		1 -4 1
		0 1 0]

X = float.(camera)
conv2D(X, kern)
imfilter(X, kern)
