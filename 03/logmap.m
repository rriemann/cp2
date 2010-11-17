% file logmap.m
% logistische Abbildung;
% vektorisiert ueber mehrfache r-Werte
function [m] = logmap(x)
global r
m=r.*x.*(1.0-x); 
