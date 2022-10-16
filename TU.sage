from sage.crypto.sbox import SBox
from sage.crypto.boolean_function import BooleanFunction
import itertools
import random

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

n = 8
c = 65
gf = GF(2^(n-1))

binaryToInt = lambda binaryVector: int("".join(str(x) for x in binaryVector), 2)
getBin = lambda x, n: list(map(lambda x: int(x), list(format(x, 'b').zfill(n))))

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
	T_res = getBin(T(x1, x2, c, n).integer_representation(), n-1)
	U_res = [U(randBoolFunc, x2, T_res)]
	return T_res + U_res

randBoolFunc = BooleanFunction(list(map(lambda x: random.randint(0, 1), range(0,2^(n-1)))))

combinations = [list(i) for i in itertools.product([0, 1], repeat=n)]

print(bcolors.OKGREEN + "f degree: {}".format(randBoolFunc.algebraic_degree()) + bcolors.ENDC)

def createSBoxes():
	for i in range(2,100):
		print(bcolors.HEADER + "\nIteration: {}".format(i) + bcolors.ENDC)
		c = i
		F_results = list(map(lambda x: F(x), combinations))
		s = map(lambda x: binaryToInt(x), F_results)
		sbox = SBox(s)
		я тоprint("Fixed points: ", sbox.fixed_points())
		print(bcolors.OKBLUE + "Min degree: " + bcolors.ENDC, sbox.min_degree())
		print("Polynimials lenght: ", len(sbox.polynomials()))
		print("sigma: ", sbox.differential_uniformity())
		print("c = ", c)
		print("tr(c): ", gf.fetch_int(c).trace())
		print("tr(c^-1): ", (gf.fetch_int(c)^(-1)).trace())

def checkC():
	for i in range(2,2^n - 1):
		T_results = list(map(lambda x: getBin(T(x[:-1], x[-1], c, n).integer_representation(), n-1), combinations))
		#print(T_results)
		print("\n\n")
		print("T_res len = ")
		print(len(list(set(tuple(i) for i in T_results))))

checkC()
