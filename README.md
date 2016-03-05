# TI-INCO
Collection of NumPy scripts for Aarhus University's TI-INCO course.

## BinarySymmetricChannel.py
Based on the the Binary Symmetric Channel lectures.

## GaloisFields.py
Based on the the Galois Field lecture (2016-18-02).

## LinearBlockCodes.py
Based on the the Linear Block Codes lecture (2016-11-02) slides 30-76.

## CyclicCodes.py
Based on the the Cyclic Codes lecture (2016-18-02).

## BCHCode.py
Based on the the BCH Codes lecture (2016-25-02).

## Usage
### playground.py
Implement your test code in main method of ``playground.py``, e.g.
```python
if __name__ == '__main__':
  G = array([[1,1,0,1,0,0,0],
             [0,1,1,0,1,0,0],
             [1,1,1,0,0,1,0],
             [1,0,1,0,0,0,1]])
  code = LinearBlockCode()
  code.setG(G)
  code.printInfo()
```
and run in console
```bash
python3 playground.py
```
### Python shell
```bash
cs@cs:~/dev/python/inco$ python3
Python 3.4.3+ (default, Oct 14 2015, 16:03:50)
[GCC 5.2.1 20151010] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from LinearBlockCodes import LinearBlockCode
>>> import numpy as np
>>> G = np.array([[1,1,0,1,0,0,0],[0,1,1,0,1,0,0],[1,1,1,0,0,1,0],[1,0,1,0,0,0,1]])
>>> code = LinearBlockCode()
>>> code.setG(G)
>>> code.printInfo()
```
