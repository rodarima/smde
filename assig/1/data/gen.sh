#!/bin/bash

N=500

echo Generate $N samples of uniform data
python uniform.py $N > uniform.csv

echo Generate $N samples of exponential data with lambda=1
python exponential.py 1 $N > exponential.csv

echo Generate $N samples of binomial data with n=10 p=0.5
python binomial.py 10 0.5 $N > binomial.csv

echo Generate $N samples of normal data with mean=0 std=1
python normal.py 0 1 $N > normal.csv

echo Generate $N samples of geometric data with p=0.5
python geometric.py 0.5 $N > geometric.csv
