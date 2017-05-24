lcg <- function(x) {
	m = 2**31

	a = 1664525
	c = 1013904223

	return((x*a + c) %% m)
}

lcgsample <- function(N, seed=7) {
	v <- rep(0, N)
	x <- seed
	for (i in seq(1, N, 1)) {
		x1 = lcg(x)
		v[i] = x1
		x = x1
	}
	return(v)
}

library('randtests')

r = lcgsample(1000)

bartels.rank.test(r)
cox.stuart.test(r)
difference.sign.test(r)
rank.test(r)
turning.point.test(r)

