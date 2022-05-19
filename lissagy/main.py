#!/usr/bin/env python
import random
from collections import deque
import numpy as np
import matplotlib.pyplot as plt  # $ pip install matplotlib
import matplotlib.animation as animation

a1 = 2
a2 = 1
w1 = 3
w2 = 5
fi1 = 0
fi2 = 0


def x_gen(t):
    return a1 * np.cos(w1 * t + fi1)


def y_gen(t):
    return a2 * np.sin(w2 * t + fi2)


npoints = 3000
x = deque([x_gen(0)], maxlen=npoints)
y = deque([y_gen(0)], maxlen=npoints)

fig = plt.figure()
ax = plt.axes(xlim=(-2, 2), ylim=(-1, 1))
line, = ax.plot([], [], lw=2)
ax.grid(True)


def init():
    line.set_data([x_gen(0)], [y_gen(0)])
    return line


def update(t):
    x.append(x_gen(t))  # update data
    y.append(y_gen(t))

    line.set_xdata(x)  # update plot data
    line.set_ydata(y)

    return line,


def data_gen():
    t = 0
    while True:
        yield t
        t += 0.01


ani = animation.FuncAnimation(fig, update, data_gen, init_func=init, interval=0.001)
plt.show()
