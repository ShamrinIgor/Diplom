

# This file was *autogenerated* from the file cringe2.sage
from sage.all_cmdline import *   # import sage library

_sage_const_0 = Integer(0); _sage_const_8 = Integer(8); _sage_const_4 = Integer(4); _sage_const_6 = Integer(6); _sage_const_1 = Integer(1)
from sage.crypto.sbox import SBox
from itertools import permutations

i = _sage_const_0 
n = _sage_const_8 
combinations = list(permutations(list(range(_sage_const_0 , n))))
N = len(combinations)

def alg1(N, i, combinations):
    if i == N:
        return false
    S = SBox(combinations[i])
    print("SBox: ", S, "sigma: ", S.differential_uniformity())
    if S.differential_uniformity() == _sage_const_4  or S.differential_uniformity() == _sage_const_6 :
        return S
    else:
        return alg1(N, i+_sage_const_1 , combinations)

print("N: ", N)
S = alg1(N, _sage_const_0 , combinations)
print("SBox: ", S)
print("Fixed points: ", S.fixed_points())
print("Min degree: ", S.min_degree())
print("Polynomials: ", S.polynomials())

