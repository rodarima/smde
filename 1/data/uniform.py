import numpy as np
import sys

if len(sys.argv) != 2:
	print("Generate a uniform random sample")
	print("Usage: {} N".format(sys.argv[0]))
	print("")
	print("N is the number of elements in the sample.")
	exit(1)

N = int(sys.argv[1])

# Generate N uniform random numbers
uni = np.random.uniform(size=N)
np.savetxt(sys.stdout.buffer, uni)
