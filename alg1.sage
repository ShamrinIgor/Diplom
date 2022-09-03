from sage.crypto.sbox import SBox
from itertools import permutations

i = 0
n = 8
combinations = list(permutations(list(range(0, n))))
N = len(combinations)

def alg1(N, i, combinations):
    if i == N:
        return false
    S = SBox(combinations[i])
    print("SBox: ", S, "sigma: ", S.differential_uniformity())
    if S.differential_uniformity() == 4 or S.differential_uniformity() == 6:
        return S
    else:
        return alg1(N, i+1, combinations)

print("N: ", N)
S = alg1(N, 0, combinations)
print("SBox: ", S)
print("Fixed points: ", S.fixed_points())
print("Min degree: ", S.min_degree())
print("Polynomials: ", S.polynomials())
