M = 100
NFACTORS = 10

rng <- function(x) {
	m = 2**31

	a = 1664525
	c = 1013904223

	return((x*a + c) %% m)
}

rsample <- function(N, seed=7) {
	v <- character(length(N))
	x <- seed
	for (i in seq(1, N, 1)) {
		x1 = rng(x)
		v[i] = x1
		x = x1
	}
	return(v)
}

