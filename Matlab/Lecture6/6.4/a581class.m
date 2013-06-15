% clear all; close all; clc; 用来清除先前的变量，关闭先前的窗口，清屏。所以这事第一步要做的事情，以免因为之前的变量等造成错误。

clear all;close all;clc;

% 【重要】要解出方程，需要用到 bvp4c，用法如下：
%sol = bvp4c(odefun,bcfun,solinit)
%sol = bvp4c(odefun,bcfun,solinit,options)
%solinit = bvpinit(x, yinit,params)
% 我们先写出初始 init：

% 初始条件应该什么格式呢？solinit应该包含我们对初始的猜测。solinit 应该包括：
% 1. 初始的网格。因为我们要给出边界条件的话，需要在一个离散化的网格上来给定。
% 2. 对解的猜测。shooting method 需要像 Terminator 那样来做返回到开始来修正。
% 3. 对于问题中的未知参数的初始猜测。例如这个问题中的 beta。
% 我们先完成主程序，solinit 等下写一个函数来产生，这里就只写 bvpinit(.....)

% 给 beta 赋值。我们不知道该赋什么值。所以就从根据之前的线性的问题里面的猜个差不多的初始。
beta=99;

% 【重要】给出初始的状态等。bvpinit()是一个另外定义的函数。@ 是
% function_handle，一般是在做为一个函数参数的时候出现，matlab 会收集所有的必要的关于这个函数的信息。例如这里面
% @bc_init 就是把所有必要的bc_init的信息传给 bvpinit() .
init=bvpinit(linspace(-1,1,50),@bc_init,beta)

% 【重要】使用 bvp4c(常微分方程,边界条件,初始条件)。@ 是 function handle，上面说过了。
sol = bvp4c(@rhs_bvp, @bc_bvp,init);

x=linspace(-1,1,100);

% deval(bvp4c给出的解的结构体,要计算的那些散点)
BS = deval(sol,x);

% 绘制出图像。
% colon (:) 是用来获取矢量的某些项：
%    A(:,j)is the jth column of A.
%    A(i,:)is the ith row of A.
%    A(:,:)is the equivalent two-dimensional array. For matrices this is the same as A.
%    A(j:k)is A(j), A(j+1),...,A(k).
plot(x,BS(1,:))
