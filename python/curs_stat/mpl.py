#!/usr/bin/python

import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(111)

# the histogram of the data
x=[4.5156,4.5220,4.5219,4.5310,4.5388,4.5379,4.5376,4.5349,4.5342,4.5339,4.5314,4.5360,4.5313,4.5089,4.5118,4.5059,4.5191,4.5316,4.5454,4.5394,4.5349]

#n, bins, patches = ax.hist(x, 50, normed=1, facecolor='green', alpha=0.75)
n, bins, patches = ax.hist(x)

# hist uses np.histogram under the hood to create 'n' and 'bins'.
# np.histogram returns the bin edges, so there will be 50 probability
# density values in n, 51 bin edges in bins and 50 patches.  To get
# everything lined up, we'll compute the bin centers
bincenters = 0.5*(bins[1:]+bins[:-1])
# add a 'best fit' line for the normal PDF

ax.set_xlabel('Smarts')
ax.set_ylabel('Probability')
#ax.set_title(r'$\mathrm{Histogram\ of\ IQ:}\ \mu=100,\ \sigma=15$')
ax.set_xlim(0, 25)
ax.set_ylim(0, 5)
ax.grid(True)

plt.show()
