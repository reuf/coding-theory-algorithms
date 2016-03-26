# -*- coding: UTF-8 -*-

from BinarySymmetricChannel import BinarySymmetricChannel
from GaloisField import GaloisField
from LinearBlockCode import LinearBlockCode
from CyclicCode import CyclicCode
from BCHCode import BCHCode
import numpy as np

def ExercisesChapter2():
    '''
    Exercise 2.4
    Codewords = np.array([[0,0,0,0,0,0],  0
                         [0,1,1,1,0,0], 3
                         [1,0,1,0,1,0], 3
                         [1,1,0,1,1,0], 4
                         [1,1,0,0,0,1], 3
                         [1,0,1,1,0,1], 4
                         [0,1,1,0,1,1], 4
                         [0,0,0,1,1,1]]) 3

    (a) What is the rate of the code?
    (b) Write down the generator and parity check matrices of this code in systematic form.
    (c) What is the minimum Hamming distance of the code?
    (d) How many errors can it correct, and how many can it detect?
    (e) Compute the syndrome vector for the received vector r = (101011) and hence find the location of any error.


    n = 6 and k = 3 because 2^k = 8
    so we need to choose 3 vectors that form an identity matrix
    Generator thus becomes
    print("Exercise 2.4")
    Generator = np.array([[0,1,1,1,0,0],
                         [1,0,1,0,1,0],
                         [1,1,0,0,0,1]])

    lbc = LinearBlockCode()
    lbc.setG(Generator)
    lbc.printInfo()
    print("")
    r = np.array([1,0,1,0,1,1])
    lbc.verboseSyndromeDecode(r)

    '''
    print("Exercise 2.5")
    '''
    (a) Construct a linear block code Cb(5, 2), maximizing its minimum Hamming distance.
    (b) Determine the generator and parity check matrices of this code.
    '''
    # Create generator matrix (right submatrix has dist 2 and the lh submatrix can only have 1 variation due to I)
    # Dmin has to be at least k + 1 if we are maximizing it.
    Generator1 = np.array([[1,1,1,1,0],
                           [0,1,1,0,1]])
    lbc1 = LinearBlockCode()
    lbc1.setG(Generator1)
    lbc1.printInfo()

if __name__ == '__main__':
    ExercisesChapter2()
'''
    # LinearBlockCode example:
    G = np.array([[1,1,0,1,0,0,0],
                  [0,1,1,0,1,0,0],
                  [1,1,1,0,0,1,0],
                  [1,0,1,0,0,0,1]])

    lbc = LinearBlockCode()
    lbc.setG(G)
    lbc.printInfo()

    # CyclicCode example:
    G = np.array([[1,1,0,1,0,0,0],
                  [0,1,1,0,1,0,0],
                  [1,1,1,0,0,1,0],
                  [1,0,1,0,0,0,1]])
    g = np.array([1,1,0,1])     # 1 + X + X^3;
    cc = CyclicCode(g, 7)       # Ccyc(7,4)
    cc.printInfo()


    # GaloisFields example:
    ## GF(2^4) generated by pi(X) = 1 + X + X^4
    GF16 = GaloisField(np.array([1,1,0,0,1]))
    GF16.printInfo()

    ## find roots of p(X) = 1 + X^3 + X^4 in GF(2^4)
    p = np.array([1,0,0,1,1])
    print("roots of", GF16.polyToString(p), "in GF(2^4):")
    for root in GF16.roots(p):
        print(GF16.elementToString(root))

    # BCHCode example:
    pX = np.array([1,1,0,0,1]) #  1 + X + X^4
    GF24 = GaloisField(pX)
    t = 2
    C_BCH = BCHCode(GF24, t, True)
'''