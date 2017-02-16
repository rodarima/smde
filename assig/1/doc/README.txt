Rodrigo Arias Mallo

Question 1:

To test if a sample data follows a distribution, I am going to use a chi square 
test. I won't be able to say if a sample is correct or not. But I could detect 
if the sample is probably not following a distribution.

The procedure to check a continuous sample is the following. First determine a 
number K of bins. Then compute how to divide the values of the distribution Y, 
such that each bin has the same probability. After, count the number of 
ocurrences in each bin (in the sample), and finally measure the square distance 
with the expected value, and sum all those values. In python:

	def gof(x, k, dist):
		# Compute equally probably chunks
		cuts = dist.ppf(np.linspace(0, 1, k + 1))
		# Count the number of occurrences in each chunk
		f_obs, edges = np.histogram(x, bins=cuts)
		# The expected count is N/K
		f_exp = len(x)/k
		# Calculate the X^2
		X2 = np.sum((f_obs - f_exp)**2 / f_exp)
		return X2

I will try to program it in R if I have time, but for now, I feel very 
confortable doing it in python.

The number returned X2, follows a particular distribution, when the size of the 
sample N grows to infinity. The distribution is the chi square with the degree 
of freedom being K-1.

If the observed value X2 is far away from the expected value of the chi square 
distribution, it is very likely that the sample is not following the 
distribution. Let's assume that the data follows the distribution (H0 
hypothesis). Then, the probability that a random departure from the expected 
value is equal or more as X2 is the p-value.
...

Question 2:

The ANOVA test is based in 3 assumptions. All the populations should be normal 
so a Shaphiro test is performed. All the observations must be independent, so a 
Durbit Watson test is performed. And the samples must have the same variance, so 
a Breusch Pagan test is performed.

If all of the three tests pass, then the ANOVA test can proceed. Every test is 
checked by it's p-value. If is less than alpha (0.05) the significance level, 
the test is assumed as failed. The example code produces:

	[1] "Shapiro-Wilk normality test passed."
	[1] "Durbin-Watson test passed."
	[1] "Studentized Breusch-Pagan test passed."

Finally, the ANOVA test can show if the data has the same mean, if the p-value 
is less than alpha. Or fail trying to prove the null hypothesis. While trying 
with three different normal samples, with different means, we get:

	[1] "The ANOVA test indicates that the data has different mean."
		      Df Sum Sq Mean Sq F value Pr(>F)
	k              1  99744	  99744   94657 <2e-16 ***
	Residuals   1498   1579       1

For example, testing with samples with the same mean, we get:

	[1] "The ANOVA cannot confirm that the data has different mean."
		      Df Sum Sq Mean Sq F value Pr(>F)
	k              1    0.2  0.1643   0.156  0.693
	Residuals   1498 1578.5  1.0537

As expected the ANOVA test can detect if the samples have the same mean. The 
variance between the groups intra class is low (0.2) as well as between groups 
(1.0537). However, when the means of the samples are diferent, intra groups we 
have 99744 which is very largo compared with 1 between groups.

Question 3:

The "prediction" of the time that an athlete should take, could be based on the 
other parameters of the competition. To check that his time is not a complete 
random variable, first we need to check if is there any relationship between the 
time of the 1500m and any other column.


