from sage.crypto.sbox import SBox
from sage.crypto.boolean_function import BooleanFunction
import itertools
import random

n = 0
c_values = range(2, 2^(n-1))
gf = GF(2^(n-1))

binaryToInt = lambda binaryVector: int("".join(str(x) for x in binaryVector), 2)
getBin = lambda x, n: list(map(lambda x: int(x), list(format(x, 'b').zfill(n))))

def T(x1, x2, c, n):
	gf_x1 = gf.fetch_int(binaryToInt(x1))
	if gf_x1 == 0:
		return gf_x1
	reverse_x1 = gf_x1^(-1)
	return reverse_x1 * gf.fetch_int(c)^x2


def F(x):
	x1 = x[:-1]
	x2 = x[-1]
	# return T_res
	return getBin(T(x1, x2, c, n).integer_representation(), n-1)

combinations = [list(i) for i in itertools.product([0, 1], repeat=n)]


