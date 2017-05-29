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

*Define a DOE to explore with what parametrization of the 10 factors the answer 
obtains the best value (define what means best, i.e. maximize or minimize the 
value).*

*Detect and analyze the interactions.*

Let's imagine that our experiment is a chemical experiment. We have 10 compounds 
in different quantities (the factors) and a result variable (ans) which measures 
the quality of the final product. Let say we are building a phone screen, 
varying the amounts of the components, and the quality is measured as the 
resistance to impacts. The larger the answer variable the better, it means a 
more durable phone.

### Set the objectives.

Identify the main factors that determine the answer response.

### Select the process variables.

The quantity of the 10 compounds from x1 to x10.

### Define an experimental design.

A 2k experimental design as we have a simple model and we can generate the 
response virtually free.

### Execute the design.

Let be -1 and +1 the 2 extreme values for the factors, represented by - and +.

To generate the combinations we can use the package "dae" in R.

	> library('dae')
	> mp <- c("-", "+")
	> fnames <- list(x1=mp, x2=mp, x3=mp, x4=mp, x5=mp, x6=mp,
		x7=mp, x8=mp, x9=mp, x10=mp)
	> treats <- fac.gen(generate = fnames, order="yates")
	> head(treats)
	  x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
	1  -  -  -  -  -  -  -  -  -   -
	2  +  -  -  -  -  -  -  -  -   -
	3  -  +  -  -  -  -  -  -  -   -
	4  +  +  -  -  -  -  -  -  -   -
	5  -  -  +  -  -  -  -  -  -   -
	6  +  -  +  -  -  -  -  -  -   -
	> tail(treats)
	     x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
	1019  -  +  -  +  +  +  +  +  +   +
	1020  +  +  -  +  +  +  +  +  +   +
	1021  -  -  +  +  +  +  +  +  +   +
	1022  +  -  +  +  +  +  +  +  +   +
	1023  -  +  +  +  +  +  +  +  +   +
	1024  +  +  +  +  +  +  +  +  +   +

However, 5 of the 10 factors are dependent of the other half. If we only use 5 
factors:

	> ans = 3*mpone(treats$x1)+5*mpone(treats$x2)+6*mpone(treats$x3)+
		6*mpone(treats$x4)+6*mpone(treats$x5)+rnorm(32,	sd=0.1)
	> d=data.frame(treats, ans)
	> d
	   x1 x2 x3 x4 x5        ans
	1   -  -  -  -  - -26.019996
	2   +  -  -  -  - -19.989807
	3   -  +  -  -  - -15.959934
	4   +  +  -  -  - -10.152213
	5   -  -  +  -  - -13.980209
	6   +  -  +  -  -  -8.089921
	7   -  +  +  -  -  -3.954413
	8   +  +  +  -  -   2.017681
	9   -  -  -  +  - -13.905559
	10  +  -  -  +  -  -7.979903
	11  -  +  -  +  -  -4.104608
	12  +  +  -  +  -   1.894599
	13  -  -  +  +  -  -2.078160
	14  +  -  +  +  -   3.912661
	15  -  +  +  +  -   8.171897
	16  +  +  +  +  -  14.058726
	17  -  -  -  -  + -14.118927
	18  +  -  -  -  +  -7.947522
	19  -  +  -  -  +  -3.877817
	20  +  +  -  -  +   1.824779
	21  -  -  +  -  +  -2.253540
	22  +  -  +  -  +   3.993494
	23  -  +  +  -  +   7.990219
	24  +  +  +  -  +  13.898773
	25  -  -  -  +  +  -2.134875
	26  +  -  -  +  +   4.097964
	27  -  +  -  +  +   8.101143
	28  +  +  -  +  +  13.991700
	29  -  -  +  +  +   9.910960
	30  +  -  +  +  +  15.919928
	31  -  +  +  +  +  19.920425
	32  +  +  +  +  +  26.028645

Now we can use `yates.effects()` with `aov()` to compute the yates effects of 
the variables and their combination.

	> anova=aov(ans~x1*x2*x3*x4*x5, data=d)
	> anova
	Call:
	   aov(formula = ans ~ x1 * x2 * x3 * x4 * x5, data = d)

	Terms:
			       x1        x2        x3        x4        x5     x1:x2
	Sum of Squares   286.6395  805.1383 1148.9797 1157.1044 1146.0617    0.0466
	Deg. of Freedom         1         1         1         1         1         1
			    x1:x3     x2:x3     x1:x4     x2:x4     x3:x4     x1:x5
	Sum of Squares     0.0020    0.0365    0.0031    0.0005    0.0000    0.0184
	Deg. of Freedom         1         1         1         1         1         1
			    x2:x5     x3:x5     x4:x5  x1:x2:x3  x1:x2:x4  x1:x3:x4
	Sum of Squares     0.0030    0.0202    0.0016    0.0153    0.0142    0.0040
	Deg. of Freedom         1         1         1         1         1         1
			 x2:x3:x4  x1:x2:x5  x1:x3:x5  x2:x3:x5  x1:x4:x5  x2:x4:x5
	Sum of Squares     0.0036    0.0242    0.0028    0.0217    0.0004    0.0001
	Deg. of Freedom         1         1         1         1         1         1
			 x3:x4:x5 x1:x2:x3:x4 x1:x2:x3:x5 x1:x2:x4:x5 x1:x3:x4:x5
	Sum of Squares     0.0002      0.0009      0.0062      0.0064      0.0015
	Deg. of Freedom         1           1           1           1           1
			x2:x3:x4:x5 x1:x2:x3:x4:x5
	Sum of Squares       0.0125         0.0197
	Deg. of Freedom           1              1

	Estimated effects are balanced
	> yates.effects(anova, data=d)
		    x1             x2             x3             x4             x5 
	   5.985810979   10.032063236   11.984258828   12.026555840   11.969031537 
		 x1:x2          x1:x3          x2:x3          x1:x4          x2:x4 
	  -0.076338893    0.015789883    0.067529233    0.019576080    0.007875363 
		 x3:x4          x1:x5          x2:x5          x3:x5          x4:x5 
	   0.001318775    0.047960628    0.019234758   -0.050201417    0.014247871 
	      x1:x2:x3       x1:x2:x4       x1:x3:x4       x2:x3:x4       x1:x2:x5 
	   0.043662259    0.042155230   -0.022467426    0.021107941   -0.054951052 
	      x1:x3:x5       x2:x3:x5       x1:x4:x5       x2:x4:x5       x3:x4:x5 
	   0.018632596   -0.052022389    0.006798353    0.002810317   -0.004369662 
	   x1:x2:x3:x4    x1:x2:x3:x5    x1:x2:x4:x5    x1:x3:x4:x5    x2:x3:x4:x5 
	  -0.010663323    0.027820592    0.028377545   -0.013506928   -0.039507956 
	x1:x2:x3:x4:x5 
	   0.049563695

And see that all variables contribute directly to the result, but seems that 
they don't produce a combined effect.

### Check that the data are consistent with the experimental assumptions.

The results are expected, as the variables are indenpendent.

*Analyze  and  interpret  the  results,  detect  effects  of  main  factors  and
interactions.*

There is no interation between x1 to x5, but as we discovered previously, x6 to 
x10 are linear combinations of the other half.

