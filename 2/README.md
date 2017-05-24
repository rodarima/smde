# SMDE Second assignment (30% of the final mark, individual)

Rodrigo Arias Mallo

## DEFINE YOUR RNG. Select a RNG to use in your analysis.

1. Implement this RNG.
2. Test the correctness of your RNG using at least two tests. You can implement
your tests or can use the RNG tests implemented on R. Explain the main idea
(is not needed to enter on the details) of the test selected.

You can find a source of RNG here:
http://wiki.fib.upc.es/sim/index.php/Main_Page/en
You can implement this RNG on R on in the language you prefer. Remember that
you can define your own functions in R like this:

	My_RNG <- function (x, seed=7) {
	#Do something
	return(x)
	}

Some useful code:

	library(randtests)
	example = My_RNG(1000)
	bartels.rank.test(example)
	cox.stuart.test(example)
	difference.sign.test(example)
	rank.test(example)
	turning.point.test(example)

---

I choose the linear congruential generator, defined as:

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

Then I generate a sample of 1000 values:

	> r = lcgsample(1000)
	> head(r)
	[1] 1025555898 1775940049  483148028 1833871403  211918734 1528078741	

And we apply some tests to check the randomness of the data:

	> difference.sign.test(r)

		Difference Sign Test

	data:  r
	statistic = 1.3686, n = 1000, p-value = 0.1711
	alternative hypothesis: nonrandomness


	> turning.point.test(r)

		Turning Point Test

	data:  r
	statistic = -1.3762, n = 1000, p-value = 0.1687
	alternative hypothesis: non randomness

The tests look for properties in the sample that a random sequenece should 
follow.

The Difference Sign Test measures the difference between each par of 
observations. The number of pairs x,y with x bigger than y should follow a 
binamial distribution.

The Turning Point Test is based on the number of turning points. The turning 
point in the number of maxima and minima in the sequence, and should follow a 
normal distribution.

## Simulate your data.

Define, for each factor (from 1 to 5) a distribution (the RVGs that you prefer,
uniform, normal, exponential, etc.). For the factors 6 to 10 define a function
that uses the previous variables, as an example F6=F1+2F3.

	> N = 1000
	> SDERR = 0.1
	>
	> # Five standard normal distributions x1, x2, ... , x5
	> x1 = rnorm(N)
	> x2 = rnorm(N)
	> x3 = rnorm(N)
	> x4 = rnorm(N)
	> x5 = rnorm(N)
	>
	> x6 = x1 + 2*x2
	> x7 = x2 + 3*x3
	> x8 = x3 + 4*x4
	> x9 = x4 + 5*x5
	> x10 = x1 + x2 + x3
	>
	> err = rnorm(N, sd=SDERR)

Define an answer variable that will be composed by a function that combines
a subset of the previous factors plus a normal distribution you know (to add
some random noise).

	> ans = x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+err
	> d = data.frame(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,err,ans)

## OBTAIN AN EXPRESSION TO GENERATE NEW DATA.

Imagine that you don't know nothing regarding this dataset. You need to explore it
because you want to define an expression to obtain new data for your DOE (you
want to detect the possible relations and the interactions between the factors).

Explore the possible relations of all the factors and the answer variable, you
can use any technique developed during the course.


	> summary(lm(ans~., data=d))

	Call:
	lm(formula = ans ~ ., data = d)

	Residuals:
	     Min       1Q   Median       3Q      Max
	-0.34970 -0.07170  0.00490  0.07345  0.29287

	Coefficients: (5 not defined because of singularities)
		     Estimate Std. Error  t value Pr(>|t|)
	(Intercept) 0.0001376  0.0032283    0.043    0.966
	x1          3.0013728  0.0032904  912.164   <2e-16 ***
	x2          4.9966413  0.0031628 1579.798   <2e-16 ***
	x3          5.9984198  0.0032877 1824.500   <2e-16 ***
	x4          5.9986435  0.0032541 1843.388   <2e-16 ***
	x5          6.0001803  0.0032307 1857.217   <2e-16 ***
	x6                 NA         NA       NA       NA
	x7                 NA         NA       NA       NA
	x8                 NA         NA       NA       NA
	x9                 NA         NA       NA       NA
	x10                NA         NA       NA       NA
	---
	Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

	Residual standard error: 0.1021 on 994 degrees of freedom
	Multiple R-squared:  0.9999,    Adjusted R-squared:  0.9999
	F-statistic: 2.955e+06 on 5 and 994 DF,  p-value: < 2.2e-16


Describe what you find on this analysis and, explain if it is coherent with the
knowledge you have from the data.

The linear regresion finds linear relationships between the factors that produce 
the answer. It can be seen that only x1 to x5 seem to be significant. The 
variables x6 to x10 are not defined (probably because they are linearly 
dependent).

We can test for each x6 to x10.

	> summary(lm(formula = x6 ~ ., data = d))

	Call:
	lm(formula = x6 ~ ., data = d)

	Residuals:
	       Min         1Q     Median         3Q        Max
	-4.957e-14 -2.060e-16 -1.300e-17  1.610e-16  7.229e-14

	Coefficients: (4 not defined because of singularities)
		      Estimate Std. Error    t value Pr(>|t|)
	(Intercept)  6.451e-17  8.864e-17  7.280e-01    0.467
	x1           1.000e+00  2.615e-15  3.824e+14   <2e-16 ***
	x2           2.000e+00  4.352e-15  4.595e+14   <2e-16 ***
	x3           5.764e-15  5.225e-15  1.103e+00    0.270
	x4           5.760e-15  5.225e-15  1.102e+00    0.271
	x5           5.898e-15  5.226e-15  1.129e+00    0.259
	x7                  NA         NA         NA       NA
	x8                  NA         NA         NA       NA
	x9                  NA         NA         NA       NA
	x10                 NA         NA         NA       NA
	ans         -9.583e-16  8.709e-16 -1.100e+00    0.271
	---
	Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

	Residual standard error: 2.802e-15 on 993 degrees of freedom
	Multiple R-squared:      1,     Adjusted R-squared:      1
	F-statistic: 1.115e+32 on 6 and 993 DF,  p-value: < 2.2e-16


And see clearly how is the relation. In the case of x6:

	x6 = 1.0 * x1 + 2.0 * x2

An the same with x7, x8, x9 and x10.

Then, we can simplify the model to:

	> m = lm(formula = ans ~ x1+x2+x3+x4+x5, data = d)
	> summary(m)

	Call:
	lm(formula = ans ~ x1 + x2 + x3 + x4 + x5, data = d)

	Residuals:
	     Min       1Q   Median       3Q      Max
	-0.34970 -0.07170  0.00490  0.07345  0.29287

	Coefficients:
		     Estimate Std. Error  t value Pr(>|t|)
	(Intercept) 0.0001376  0.0032283    0.043    0.966
	x1          3.0013728  0.0032904  912.164   <2e-16 ***
	x2          4.9966413  0.0031628 1579.798   <2e-16 ***
	x3          5.9984198  0.0032877 1824.500   <2e-16 ***
	x4          5.9986435  0.0032541 1843.388   <2e-16 ***
	x5          6.0001803  0.0032307 1857.217   <2e-16 ***
	---
	Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

	Residual standard error: 0.1021 on 994 degrees of freedom
	Multiple R-squared:  0.9999,    Adjusted R-squared:  0.9999
	F-statistic: 2.955e+06 on 5 and 994 DF,  p-value: < 2.2e-16

Propose an expression (using a LRM) to generate new data. This is the
method that you are going to use to generate new values using a subset of
the factors, for a more complex dataset one can use other approaches like
Simulation.


	> m

	Call:
	lm(formula = ans ~ x1 + x2 + x3 + x4 + x5, data = d)

	Coefficients:
	(Intercept)           x1           x2           x3           x4           x5  
	  0.0001376    3.0013728    4.9966413    5.9984198    5.9986435    6.0001803  


The expression becomes:

	ans = 0.0001376 + 3.0013728*x1 + 4.9966413*x2 + 5.9984198*x3 +
		5.9986435*x4 + 6.0001803 * x5

## DOE

Now you have an expression to generate new data (a simple method to obtain new 
values depending on the factors, the model). This model can be used to generate 
data for the different scenarios that must be considered.

Define a DOE to explore with what parametrization of the 10 factors the 
answer obtains the best value (define what means best, i.e. maximize or 
minimize the value).

WIP

Detect and analyze the interactions.

WIP


