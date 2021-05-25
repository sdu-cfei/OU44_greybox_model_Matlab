# -*- coding: utf-8 -*-
"""
Created on Wed Nov  4 08:28:53 2020

@author: Konstantin Filonenko
"""
import matplotlib.pyplot as plt
import pandas as pd
import mplleaflet

df = pd.read_excel("reduceret.xlsx", skiprows=0, usecols="O, P")

df['zone'] = 32
df.to_csv("path.txt", header = False, sep = ",", index = False)
dg = pd.read_csv("path_modified.txt")
dh = pd.read_csv("T1.txt")
di = pd.read_csv("T2.txt")
dj = pd.read_csv("T3.txt")

longitude = dg[' longitude'].values.tolist()
latitude = dg[' latitude'].values.tolist()
longitude_T1a = dh[' longitude'].values[:3].tolist()
latitude_T1a = dh[' latitude'].values[:3].tolist()
longitude_T1b = dh[' longitude'].values[3:].tolist()
latitude_T1b = dh[' latitude'].values[3:].tolist()
longitude_T2 = di['longitude'].values[:-1].tolist()
latitude_T2 = di['latitude'].values[:-1].tolist()
long_T2=di['longitude'].values[-1]
lat_T2 = di['latitude'].values[-1]

longitude_T3 = dj['longitude'].values.tolist()
latitude_T3 = dj['latitude'].values.tolist()
fig, ax = plt.subplots()
ax.plot(longitude_T3, latitude_T3, 'k-') # Draw red squares

# blue branch
ax.plot(longitude_T1a, latitude_T1a, 'bs-') # Draw red squares
# red branch
ax.plot(longitude_T2, latitude_T2, 'rs-') # Draw red squares
# blue branch
ax.plot(longitude_T1b, latitude_T1b, 'bs-') # Draw red squares

ax.plot([longitude_T1a[-1],x1],[latitude_T1a[-1],y[0]], 'b-') # Draw red squares
ax.plot(x, y, 'b-') # Draw red squares
ax.plot([x[1], longitude_T1b[0]],[y[1],latitude_T1b[0]], 'b-') # Draw red squares

# red branch
ax.plot(longitude_T2, latitude_T2, 'rs-') # Draw red squares
ax.plot(long_T2, lat_T2, 'rs') 
ax.plot([longitude_T2[-1], x1[0]],[latitude_T2[-1],y1[0]], 'r-') # Draw red squares
ax.plot([x1[0], long_T2],[y1[0], lat_T2], 'r-') # Draw red squares
print(long_T2)

# green branch
ax.plot(x[0], y[0], 'ks') 
ax.legend(['Bat', 'Port', 'Dock'], loc='lower left')

title_font = {'fontname':'Arial', 'size':'16', 'weight':'normal',
              'verticalalignment':'bottom'} # Bottom vertical alignment for more space

ax.annotate(labels_T2[0],
            xy=(longitude_T2[0], latitude_T2[0]+0.0002),
                color = 'k',
                **title_font
                )


for i in range(1, len(labels_T1a)+len(labels_T1b), 1):
    if i<3:
        ax.annotate(labels_T1a[i],
                    xy=(longitude_T1a[i]+0.0004, latitude_T1a[i]-0.0005),
                    color = 'b',
                    **title_font
                    )
    elif i<4:
        ax.annotate(labels_T1b[i-3],
                    xy=(longitude_T1b[i-3]-0.0004, latitude_T1b[i-3]-0.001),
                    color = 'b',
                    **title_font
                    )        
    else:
        ax.annotate(labels_T1b[i-3],
                    xy=(longitude_T1b[i-3], latitude_T1b[i-3]),
                    color = 'b',
                    **title_font
                    )        
    if i<5:
        ax.annotate(labels_T2[i],
                    xy=(longitude_T2[i]+0.0005, latitude_T2[i]-0.00045),
                    color = 'r',
                    **title_font
                    )    

ax.annotate('T2',
            xy=(long_T2-0.001, lat_T2+0.0002),
                color = 'r',
                **title_font
                )

ax.annotate(labels_T3[-1],
            xy=(longitude_T3[-1]-0.0002, latitude_T3[-1]+0.0002),
                color = 'k',
                **title_font
                )

# upper left
long_min = min(longitude)
lat_max = max(latitude)

print(long_min, long_max, lat_min, lat_max)
mapImage = plt.imread('large.png')
ax.imshow(mapImage, zorder=0, extent = (long_min, long_max, lat_min, lat_max), aspect= 'equal')
plt.axis("off")
plt.tight_layout()
plt.savefig('network.png', dpi=400)
