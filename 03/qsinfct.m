function [m] = qsinfct(x,with_uncert)
global q
randnrs = with_uncert*1e-5*randn(1,100);
m=q.*sin(pi*x) + randnrs; 
