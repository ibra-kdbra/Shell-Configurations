# script to generate domaon.geojson

import numpy as np
import math

x0 = 0
y0 = 0
R = 0.125

def coord(t):
    st = math.sin(t)
    ct = math.cos(t)
    x = x0 - R * st
    y = y0 - R * ct
    return (x, y)

print('{')
print('  "type": "Polygon",')
print('  "coordinates": [')
print('    [')
print('      [-0.3, -0.3],')
print('      [0.7, -0.3],')
print('      [0.7, 0.3],')
print('      [-0.3, 0.3],')
print('      [-0.3, -0.3]')
print('    ],')
print('    [')

for t in np.linspace(0, math.pi, 64):
    x, y = coord(t)
    print('      [%e, %e],' % (x, y))

x, y = coord(0)
print('      [%e, %e]' % (x, y))

print('    ]')
print('  ]')
print('}')
