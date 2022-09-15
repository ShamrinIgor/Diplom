from sage.crypto.sbox import SBox
import itertools
n = 8

binaryToInt = lambda binaryVector: int("".join(str(x) for x in binaryVector), 2)
get_bin = lambda x, n: list(map(lambda x: int(x), list(format(x, 'b').zfill(n))))

def T(x1, x2, c, n):
	gf = GF(2^(n-1))
	gf_x1 = gf.fetch_int(binaryToInt(x1))
	if gf_x1 == 0:
		return gf_x1
	reverse_x1 = gf_x1^(-1)
	return reverse_x1 * gf.fetch_int(c)^x2

def U(f, x2, x1):
	return (f(x1) + x2) % 2

x1 = [1,1,0,0,1,1,0]
x1_int = binaryToInt(x1)
x2 = [1]

T_res = get_bin(T(x1, x2[0], 10, n).integer_representation(), n)
U_res = [U(lambda x: sum(x)%2, x2[0], T_res)]

F_res = T_res + U_res

def F(x):
	x1 = x[:-1]
	x2 = x[-1]
	T_res = get_bin(T(x1, x2, 65, n).integer_representation(), n)
	U_res = [U(lambda x: sum(x)%2, x2, T_res)]
	return T_res + U_res

print(F([1,1,0,0,1,1,0,1]))

combinations = [list(i) for i in itertools.product([0, 1], repeat=n)]
F_results = list(map(lambda x: F(x), combinations))
s = map(lambda x: binaryToInt(x), F_results)
sbox = SBox(s)
print("sigma: ", sbox.differential_uniformity())
