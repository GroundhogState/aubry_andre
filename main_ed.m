% This program generates a homogenous Bose-Hubbard hamiltionian with 
%periodic boundary conditions in the occupation number basis, when given
%L and N, the number of sites and number of particles, respectively. 

% DEPENDENCIES
%   closest_value       A fast, binary search algorithm.


% On my PC, I can create N=L=10 in about five seconds with the code below.
% An N=L=11 case takes about 30 seconds.
% Most of the time goes into:
    % Searching the hash table (I've already found a faster solution here,
    % so this is always going to suck)
    % All the inner products in H_onsite. I tried vectorizing it, but then
    % I ran out of RAM!
% Note this is in the POSITION occupation basis. 
% One day I'd like to write this again for the momentum basis. Zhang's
% tutorial mentions it. But there's always more to do in life...




%% User Inputs:
N = 11; %Number of bosons.
L = 11; %Size of lattice.

%% Generate Hamiltonian
profile on

close all;
disp('=====================Commencing run=====================')
tic;
dim = factorial(N+L-1)/(factorial(N)*factorial(L-1));
% Generate the Fock basis
vecs = basis_gen(N,L);

% Generate the diagonal part of H
H_int = H_onsite(vecs);

% Kinetic part assuming periodic boundary conditions
H_kin = H_tunnelling(vecs);

% Inspect results
spy(H_int + H_kin)

% Evaluate performance
toc
fprintf('done')
profile off
profile viewer

%% Do some physics!



