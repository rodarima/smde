N = 1000
SDERR = 0.1

set.seed(7)

# Five standard normal distributions x1, x2, ... , x5
x1 = rnorm(N)
x2 = rnorm(N)
x3 = rnorm(N)
x4 = rnorm(N)
x5 = rnorm(N)

x6 = x1 + 2*x2
x7 = x2 + 3*x3
x8 = x3 + 4*x4
x9 = x4 + 5*x5
x10 = x1 + x2 + x3

err = rnorm(N, sd=SDERR)

ans = x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+err

d = data.frame(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,ans)

print(summary(lm(ans~., data=d)))
