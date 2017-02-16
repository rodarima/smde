import numpy as np
import sys

if len(sys.argv) != 3:
	print("Generate an exponential random sample")
	print("Usage: {} lambda N".format(sys.argv[0]))
	print("")
	print("lambda is the inverse scale parameter.")
	print("N is the number of elements in the sample.")
	exit(1)

la = float(sys.argv[1])
N = int(sys.argv[2])

# Generate N uniform random numbers
uni = np.random.exponential(la, size=N)
np.savetxt(sys.stdout.buffer, uni)
