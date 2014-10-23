
Initial Value Problem
======================

Initial value problem, 初始值问题是这样的：

.. math::
   \frac{\mathrm d y}{\mathrm d t} = f(t,y)


数学上，我们的处理是这样的：

.. math::
   \frac{\mathrm dy}{\mathrm dt} = \lim_{\Delta t\rightarrow 0} \frac{y(t + \Delta t) - y(t)}{\Delta t}


数值计算中，如果我们依然按照上面的数学的方法来处理，那么我们就要告诉计算机去做 0/0，这显然是不行的。

实际上，计算机是这么处理的。当 $\Delta t$ 很小的时候，

.. math::
   \frac{\mathrm dy}{\mathrm dt} \approx \frac{y(t + \Delta t) - y(t)}{\Delta t}


我们有好几种方法来数值的解决这类问题。


Euler, Runge-Kutta and Adams Methods
------------------------------------------------------------



Euler 方法
~~~~~~~~~~~~~

.. math::
   y_{n+1} = y_n + \Delta t f(t_n, y_n)

利用目前的 y 和斜率来预测下一步的 y。


推广
```````````


.. math::
   y(t+\Delta t) = y(t) + \Delta t [ A f(t,y(t)) + B f(t+P \Delta t, y + Q \Delta t f(t, y)) ]

即，我们可以对 Euler 方法进行高阶修正。为什么这么说？我们可以分别对上式的左边和右边进行 Taylor 展开，然后对照，发现 P,Q 与 $\Delta t$ 的高阶项的系数有关。
用同样的方法，可以得出 A, B, P, Q 之间的关系（当保留二阶无穷小的时候）。

.. math::
   A+B & =1 \\
   A P & =1/2 \\
   B Q & =1/2


推导过程中可以注意到，P，Q 只会影响到三阶无穷小。

而且如果我们在推导中，只保留更低阶的无穷小（一阶无穷小），就回到 Euler 方法了。



Heun's method
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`Heun's method <http://en.wikipedia.org/wiki/Heun's_method>`_

:math:`A=1/2` 时，对应的是 Heun’s method. 

.. figure:: http://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Heun%27s_Method_Diagram.jpg/800px-Heun%27s_Method_Diagram.jpg
   :align: center


这种方法正好是取了 :math:`y_n` 点的和 :math:`y_{n+1}` 两点的切线做了平均来预测下一步的函数值的。




二阶 Runge-Kutta 方法
~~~~~~~~~~~~~~~~~~~~~~~~

二阶的 `RK <http://en.wikipedia.org/wiki/List_of_Runge%E2%80%93Kutta_methods>`_ 方法，要求
A=0

这种方法是取了中点的。


四阶的  RK
~~~~~~~~~~~~~


.. math::
   y_{n+1} = y_n + \frac{\Delta t}{6} ( f_1 + 2f_2 + 2f_3 + f_4 ) + O(\Delta t^5)


太精确了。


Integral and Anam’s Mehtod
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

积分有没有用呢？

利用积分，将我们要解决的问题

.. math::
   \frac{\mathrm dy}{\mathrm dt} = f(t,y)

写成

.. math::
   y_{n+1} = y_n + \int_{t_n}^{t_{n+1}} f(t,y) \mathrm dt

但是，问题在于，我们并不知道右侧的那个积分是如何解的，因为只有我们知道了 y 的精确形式，才能解这个积分。

在计算中，我们的方法是

.. math::
   y_{n+1} \approx y_n + \int_{t_n}^{t_{n+1}} p(t,y)\mathrm dt 

:math:`p(t,y)` 是 :math:`f(t,y)` 的多项式的近似。

这是很合理的，因为 :math:`[t_n, t_{n+1}]` 是一段很小的间隔，所以 :math:`f(t,y)` 的变化不大，可以用多项式来近似。





Adams Time-Stepping Schemes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

从上一节，我们了解到 Adam's 方法实际上就是利用了积分，并且采用多项式来代替 y 的斜率。具体说来，Adam's 方法根据所使用的多项式是否包含过去、现在、未来的点，有以下几种。

Adams-Bashforth
````````````````````

最简单的可以用来对 f(t,y) 做近似的多项式是常数，所以我们来试试常数。

.. math::
   p_1(t,y)=\text{Constant} = f(t_n,y_n)

把这个形式代入

.. math::
   y_{n+1} = y_n + \int_{t_n}^{t_{n+1}} p_1(t,y)\mathrm dt 

中，

.. math::
   y_{n+1} \approx y_n + \Delta t f(t_n,y_n) 

这正好回到了 Euler 方法。


如果我们用 

.. math::
   p_2(t,y) = f_n + \frac{f_n - f_{n-1}}{2}(t-t_{n-1})


即考虑斜率的影响。

得到

.. math::
   y_{n+1} = y_n + \frac{\Delta t}{2} [ 3f(t_n, y_n) - f(t_{n-1},y_{n-1}) ]




Adams Moulton
`````````````````

可以用未来、现在、过去的点来计算未来的点。

.. math::
   p(t,y) = \text{Constant} = f(t_{n+1}, y_{n+1})

我们得到

.. math::
   y_{n+1} = y_n + \Delta f(t_{n+1}, y_{n+1})


可是 :math:`f(t_{n+1}, y_{n+1})` 是未知的，一种做法是用其它的方法先获得一个未来的点，例如用 Euler 法来算出一个未来的点，再把这个点代入到这种方法中。

为什么要多次一举呢？因为这种方法的稳定性很棒。



