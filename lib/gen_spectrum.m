%%
% For playing with spin chains. Uses QETLab for now, at least for the
% partial trace and Pauli functions. 
function [eig, nrg] = gen_spectrum(L,W)
close all

L = 10;
W = 18;

H = disorder_H(L,W);
[eig, nrg] = eigs(full(H),2^L);

end