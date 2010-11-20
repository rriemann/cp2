function [m] = qsinabl(x)
global q
m=log(abs(pi*q.*cos(x)));