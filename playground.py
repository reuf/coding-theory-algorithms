from BinarySymmetricChannel import BinarySymmetricChannel
from LinearBlockCode import LinearBlockCode
from CyclicCode import CyclicCode
from GaloisField import GaloisField
import numpy as np

if __name__ == '__main__':
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
