# TI-INCO
Collection of NumPy scripts for Aarhus University's TI-INCO course.

## LinearBlockCodes.py 
Based on the the Linear Block Codes lecture (2016-11-02) slides 30-76.

Either implement main method
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
python3 LinearBlockCodes.py
```
OR import in python shell
```bash
cs@cs:~/dev/python/inco$ python3
Python 3.4.3+ (default, Oct 14 2015, 16:03:50) 
[GCC 5.2.1 20151010] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from LinearBlockCodes import *
>>> from numpy import *
>>> G = array([[1,1,0,1,0,0,0],[0,1,1,0,1,0,0],[1,1,1,0,0,1,0],[1,0,1,0,0,0,1]])
>>> code = LinearBlockCode()
>>> code.setG(G)
>>> code.printInfo()
```
