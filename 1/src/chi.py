import numpy as np
from scipy.stats import *


def gof(x, k, dist):
	# Compute equally probably chunks
	cuts = dist.ppf(np.linspace(0, 1, k + 1))
	# Count the number of occurrences in each chunk
	f_obs, edges = np.histogram(x, bins=cuts)
	# The expected count is N/K
	f_exp = len(x)/k
	# Calculate the X^2
	X2 = np.sum((f_obs - f_exp)**2 / f_exp)
	#crit = chi2.ppf(q = 1 - alpha, df = k-1)
	#print(msq, crit)
	return X2

def test_dist(N, R, K, alpha, dist):
	name = dist.name
	r = np.zeros(R)
	pvalues = np.zeros(R)
	print("------ Test of {} distribution ------".format(name))
	for i in range(R):
		sample = dist.rvs(size=N)
		r[i] = gof(sample, K, dist)
		pvalues[i] = 1 - chi2.cdf(r[i], K-1)
		if pvalues[i] < alpha:
			print("p-value = {:.4f} ***".format(pvalues[i]))
		else:
			print("p-value = {:.4f}".format(pvalues[i]))

	crit_max = chi2.ppf(q = 1-alpha, df = K-1)
	crit_min = chi2.ppf(q = alpha, df = K-1)
	#print("H0 should be rejected if X^2 < {:.2f} or X^2 > {:.2f}".format(
	#	crit_min, crit_max))
	chi_mean = np.mean(r)
	pvalue = 1 - chi2.cdf(chi_mean, K-1)
	#print("mean(X^2) = {:.2f}".format(chi_mean))
	#print("p-value = {:.4f}".format(pvalue))


N = 1000			# Size of each sample
K = 8				# Number of bins for the chi square test
R = 10				# Number of simulation runs
alpha = 0.05		# Significance level

# Fixed random seed
np.random.seed(1)

distributions = [norm, expon, uniform, cauchy, rayleigh]
for dist in distributions:
	test_dist(N, R, K, alpha, dist)

#print(ps)
#print(np.mean(ps))
