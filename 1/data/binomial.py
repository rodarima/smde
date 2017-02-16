import numpy as np
import sys

if len(sys.argv) != 4:
	print("Generate a binomial random sample")
	print("Usage: {} n p N".format(sys.argv[0]))
	print("")
	print("Binomial with parameters n and p.")
	print("N is the number of elements in the sample.")
	exit(1)

n = int(sys.argv[1])
p = float(sys.argv[2])
N = int(sys.argv[3])

# Generate N uniform random numbers
uni = np.random.binomial(n, p, size=N)
np.savetxt(sys.stdout.buffer, uni)
