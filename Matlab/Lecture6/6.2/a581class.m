clear all;close all;clc;

init=bvpinit(linspace(1,3,10),[0 0])

sol = bvp4c(@rhs_bvp, @bc_bvp,init);
x=linspace(1,3,100);
BS = deval(sol,x);
plot(x,BS(1,:))
