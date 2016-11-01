import numpy as np
import scipy.stats as stats

N = 500
K = 50
norm = stats.norm

def divide_equal_prob(vec, k, dist):
	cuts = np.zeros(k-1) -99
	prob = np.zeros(k)-99
	vmin = min(vec)
	vmax = max(vec)
	cuts = np.linspace(vmin, vmax, k-1)
	
	#print(cuts)

	for i in range(1, k-1):
		r = cuts[i]
		l = cuts[i-1]
		p = dist.cdf(r) - dist.cdf(l)
		#print("Probability of {} < x < {} = {}".format(l, r, p))
		prob[i] = p
	prob[0] = dist.cdf(vmin)
	prob[k-1] = 1 - dist.cdf(vmax)

	
	#print(prob)
	#print(sum(prob))

	chunks = np.zeros(k)
	v = sorted(vec)
	count, edges = np.histogram(v, bins=cuts)
	observed = np.concatenate(([0], count, [0]))
	expected = prob*N

	msq = np.sum((observed - expected)**2 / expected)
	#print(msq)
	chi, pvalue = stats.chisquare(observed, f_exp=expected)
	#print(chi, pvalue)
	#alpha = 0.05
	#crit = stats.chi2.ppf(q = 1-alpha, df = k-1)
	#print("The value X = {:.2f} should be > {:.2f} only {:.2}% of the time".format(
	#		msq, crit, alpha*100))
	#print("in a infinite sampling")
	return msq

def gof(x, k, dist):
	# Compute equaly probably chunks
	cuts = dist.ppf(np.linspace(0, 1, k + 1))
	# Count the number of occurrences in each chunk
	f_obs, edges = np.histogram(x, bins=cuts)
	# The expected count is N/K
	f_exp = len(x)/k
	# Calculate the X^2
	X2 = np.sum((f_obs - f_exp)**2 / f_exp)
	#crit = stats.chi2.ppf(q = 1 - alpha, df = k-1)
	#print(msq, crit)
	return X2



R = 1000
r = np.zeros(R)
alpha = 0.05

for i in range(R):
	sample = np.random.normal(loc=0.0, scale=1.0, size=N)
	#r[i] = divide_equal_prob(sample, K, norm)
	r[i] = gof(sample, K, norm)


crit_max = stats.chi2.ppf(q = 1-alpha, df = K-1)
crit_min = stats.chi2.ppf(q = alpha, df = K-1)
print("H0 should be rejected if X^2 < {:.2f} or X^2 > {:.2f}".format(
	crit_min, crit_max))
print("mean(X^2) = {:.2f}".format(np.mean(r)))
#print(np.sum(crit > r) / R)
#print(r)

ps = stats.chi2.cdf(r, df = K-1)

#print(ps)
#print(np.mean(ps))
