function H = H_AubreyAndre(config)

% This program generates a homogenous Bose-Hubbard hamiltionian with 
%periodic boundary conditions in the occupation number basis, when given
%L and N, the number of sites and number of particles, respectively. 

% DEPENDENCIES
%   closest_value       A fast, binary search algorithm.




%% User Inputs:
% config.gen.N = 11; %Number of bosons.
% config.gen.L = 11; %Size of lattice.

%% Generate Hamiltonian

disp('=====================Commencing run=====================')
tic;
% Generate the Fock basis
vecs = basis_gen(config.gen.N,config.gen.L);
% TODO: Momentum space, open boundary conditions

% Generate the diagonal part of H
H_int = H_onsite(vecs,config);

% Kinetic part assuming periodic boundary conditions
H_kin = H_tunnelling(vecs);

% Inspect results
H = H_int + H_kin;

%% Do some physics!



end