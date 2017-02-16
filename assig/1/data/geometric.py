import numpy as np
import sys

if len(sys.argv) != 3:
	print("Generate a geometric random sample")
	print("Usage: {} p N".format(sys.argv[0]))
	print("")
	print("p is the probability of suceess.")
	print("N is the number of elements in the sample.")
	exit(1)

p = float(sys.argv[1])
N = int(sys.argv[2])

# Generate N uniform random numbers
uni = np.random.geometric(p, size=N)
np.savetxt(sys.stdout.buffer, uni)
