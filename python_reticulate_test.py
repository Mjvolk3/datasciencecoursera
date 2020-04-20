import numpy as np
import pandas as pd
from numpy import linalg as la

a = np.array([[3,2], [1,2]])
b = np.array([9,8])
x = la.solve(a,b)
print(x)

