decathlon = read.csv('data/decathlon.csv', sep='\t')

# Use this line if you run this script in the src/ folder
#decathlon = read.csv('../data/decathlon.csv', sep='\t')

rm1 = lm(X1500m ~ ., data=decathlon)
print(summary(rm1))

# Coefficients:
#                       Estimate Std. Error t value Pr(>|t|)    
# (Intercept)          1.411e+03  2.281e+01  61.851   <2e-16 ***
# X100m               -3.711e+01  6.090e-01 -60.937   <2e-16 ***
# Long.jump            3.947e+01  6.635e-01  59.489   <2e-16 ***
# Shot.put             9.984e+00  2.172e-01  45.972   <2e-16 ***
# High.jump            1.470e+02  2.538e+00  57.931   <2e-16 ***
# X400m               -7.680e+00  2.351e-01 -32.670   <2e-16 ***
# X110m.hurdle        -1.951e+01  3.730e-01 -52.320   <2e-16 ***
# Discus               3.461e+00  5.077e-02  68.184   <2e-16 ***
# Pole.vault           4.855e+01  6.462e-01  75.127   <2e-16 ***
# Javeline             2.442e+00  4.648e-02  52.533   <2e-16 ***
# Rank                 3.099e-04  4.278e-02   0.007    0.994    
# Points              -1.632e-01  2.566e-03 -63.589   <2e-16 ***
# CompetitionOlympicG  1.387e-01  5.532e-01   0.251    0.804    
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5796 on 28 degrees of freedom
# Multiple R-squared:  0.9983,    Adjusted R-squared:  0.9975 
# F-statistic:  1350 on 12 and 28 DF,  p-value: < 2.2e-16

# Drop Rank and CompetitionOlympicG

rm2 = lm(X1500m ~ X100m + Long.jump + Shot.put + High.jump + X400m +
	X110m.hurdle + Discus + Pole.vault + Javeline + Points,
	data=decathlon)

print(summary(rm2))

#library("plyr")

# Automatic selection of factors
#srm1 = step(rm1)
