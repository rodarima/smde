library(lmtest)

set.seed(1);

N = 1000
sample1 = rnorm(N, mean=10)
sample2 = rnorm(N, mean=20)
sample3 = rnorm(N, mean=30)

k = c(rep(10,N), rep(20,N), rep(30,N))
v = c(sample1, sample2, sample3)

table = data.frame(x=v, k=k)
anova = aov(x~k, data=table)

alpha = 0.05

#-------------------------------------
# Normality tests
#-------------------------------------
sh = shapiro.test(residuals(anova))
sh
if(sh$p.value < alpha) {
	print("Data seems not normal. Cannot apply anova.")
	print(sh)
	stop()
} else {
	print("Shapiro-Wilk normality test passed.")
}
#-------------------------------------
# Independency tests
#-------------------------------------
dw = dwtest(anova, alternative = "two.sided")
dw
if(dw$p.value < alpha) {
	print("Data seems dependent. Cannot apply anova.")
	print(dw)
	stop()
} else {
	print("Durbin-Watson test passed.")
}
#-------------------------------------
# Homogeneity of variance tests
#-------------------------------------
bp = bptest(anova)
bp
if(bp$p.value < alpha) {
	print("Data seems to have different variance between samples. Cannot apply anova.")
	print(bp)
	stop()
} else {
	print("Studentized Breusch-Pagan test passed.")
}

anova.pvalue = summary(anova)[[1]][["Pr(>F)"]][1]
if(anova.pvalue < alpha) {
	print("The ANOVA test indicates that the data has different mean.")
} else {
	print("The ANOVA cannot confirm that the data has different mean.")
}

summary(anova)
