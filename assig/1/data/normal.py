import numpy as np
import sys

if len(sys.argv) != 4:
	print("Generate a normal random sample")
	print("Usage: {} m s N".format(sys.argv[0]))
	print("")
	print("Normal with mean m and std s")
	print("N is the number of elements in the sample.")
	exit(1)

m = float(sys.argv[1])
s = float(sys.argv[2])
N = int(sys.argv[3])

# Generate N uniform random numbers
uni = np.random.normal(m, s, size=N)
np.savetxt(sys.stdout.buffer, uni)
