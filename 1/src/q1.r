printf <- function(...) invisible(print(sprintf(...)))
source('chisqgof.R')

# Load generated data to be tested
data_dir = "../data/"

data_exponetial <- read.table(sprintf("%s%s", data_dir, "exponential.csv"))$V1
data_normal <- read.table(sprintf("%s%s", data_dir, "normal.csv"))$V1
data_binomial <- read.table(sprintf("%s%s", data_dir, "binomial.csv"))$V1
data_geometric <- read.table(sprintf("%s%s", data_dir, "geometric.csv"))$V1
data_uniform <- read.table(sprintf("%s%s", data_dir, "uniform.csv"))$V1

# WARNING: This method should not be used before cautious analysis

chi_compare <- function(x1, x2, k, dist) {
	xmin = min(x1,x2)
	xmax = max(x1,x2)
	cuts = seq(xmin, xmax, length.out = k+1)
	print(cuts)
	length(cuts)


	x1_count = cut(x1, cuts, labels=FALSE)
	x2_count = cut(x2, cuts, labels=FALSE)

	x1_table = table(factor(x1_count, levels=1:k))
	x2_table = table(factor(x2_count, levels=1:k))

	#print(x1_table)
	#print(x2_table)
	#tab = cbind(x1_table)
	#print(tab)
	prob = x2_table/length(x2)
	print(sum(prob))
	chi = chisq.test(cbind(x1_table, x2_table))
	print(chi)
	#print(chi$observed)
	#print(chi$expected)
	printf("Comparing the distribution %s", dist)
	gof1 = chisq.gof(x1, dist = dist, cut.points=cuts)
	gof2 = chisq.gof(x2, dist = dist, cut.points=cuts)
	print(gof1)
	print(gof2)
}

r_normal = rnorm(500, mean=0, sd=1)
chi_compare(data_normal, r_normal, 50, 'normal')
