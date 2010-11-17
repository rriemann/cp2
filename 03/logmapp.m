% file logmapp.m
% log der Ableitung der logistischen Abbildung;
% vektorisiert ueber mehrfache r-Werte
function [m] = logmapp(x)
global r
m=log(abs(r.*(1.0-(x+x))));