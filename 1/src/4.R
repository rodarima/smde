library("FactoMineR")
library("plyr")

data(decathlon, package="FactoMineR")

d = rename(decathlon, c("100m"="X100m", "400m"="X400m",
	"110m.hurdle"="X110m.hurdle", "1500m"="X1500m"))


rm1 = lm(X1500m ~ ., data=d)
srm1 = step(rm1)



new <- data.frame(X400m=48)
