from sage.crypto.sbox import SBox
import itertools
n = 8
c = 65
gf = GF(2^(n-1))

binaryToInt = lambda binaryVector: int("".join(str(x) for x in binaryVector), 2)
get_bin = lambda x, n: list(map(lambda x: int(x), list(format(x, 'b').zfill(n))))

def T(x1, x2, c, n):
	gf_x1 = gf.fetch_int(binaryToInt(x1))
	if gf_x1 == 0:
		return gf_x1
	reverse_x1 = gf_x1^(-1)
	return reverse_x1 * gf.fetch_int(c)^x2

def U(f, x2, x1):
	return (f(x1) + x2) % 2

def F(x):
	x1 = x[:-1]
	x2 = x[-1]
	T_res = get_bin(T(x1, x2, c, n).integer_representation(), n)
	U_res = [U(lambda x: sum(x)%2, x2, T_res)]
	return T_res + U_res

combinations = [list(i) for i in itertools.product([0, 1], repeat=n)]

for i in range(2,100):
	c = i
	F_results = list(map(lambda x: F(x), combinations))
	s = map(lambda x: binaryToInt(x), F_results)
	sbox = SBox(s)
	print("Fixed points: ", sbox.fixed_points())
	print("Min degree: ", sbox.min_degree())
	print("Polynimials lenght: ", len(sbox.polynomials()))
	print("sigma: ", sbox.differential_uniformity())
	print("c = ", c)
	print("tr(c): ", gf.fetch_int(c).trace())
	print("tr(c^-1): ", (gf.fetch_int(c)^(-1)).trace())
