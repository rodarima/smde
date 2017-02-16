###########################################################
# Clear all environment variables
###########################################################
# Remove previous objects
# rm(list=ls(all=TRUE))
######################################
# Load libraries 
######################################
library(MASS)
library(lmtest)
library(nortest)
library(Rcmdr)
library(FactoMineR)
######################################
# Load wine module
######################################
data(wine)
######################################
# Wine summary
######################################
#summary(wine$Overall.quality)
#######################################
## Does Soil affects wine features?
#######################################
##-------------------------------------
## Generate initial Boxplot for Overall Quality
##-------------------------------------
#data(wine, package="FactoMineR")
with(wine, Hist(Overall.quality, groups=Soil, scale="frequency", 
	breaks="Sturges", col="darkgray"))
summary(wine)
with(wine, tapply(Overall.quality, list(Soil), mean, na.rm=TRUE))
#Boxplot(Overall.quality~Soil, data=wine, id.method="y")
#
##-------------------------------------
## One-way Anova 'Overall.quality'
##-------------------------------------
AnovaModel.1 <- aov(Overall.quality ~ Soil, data=wine)
summary(AnovaModel.1)
with(wine, numSummary(Overall.quality, groups=Soil, statistics=c("mean", "sd")))
##-------------------------------------
## Normality tests
##-------------------------------------
shapiro.test(residuals(AnovaModel.1))
##-------------------------------------
## Independency tests
##-------------------------------------
dwtest(AnovaModel.1)
##-------------------------------------
## Homogeneity of variance tests
##-------------------------------------
bptest(AnovaModel.1)
