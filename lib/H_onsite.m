function H_int = H_onsite(vecs,config) 
% To do: Add a disordered on-site chemical potential
    % Creates the diagonal part of the Hamiltonian in a fixed-N Fock space

    dim=factorial(config.gen.N+config.gen.L-1)/(factorial(config.gen.N)*factorial(config.gen.L-1));
    disorder = config.gen.W*randn(config.gen.L,1);
    % Allocates space for a dim*dim sparse diagonal matrix
    H_int = spalloc(dim,dim,dim); 
    % Vectorized version - much quicker generally - runs out of memory!?
%     H_int = diag(diag(vecs*(vecs-1)'))/2;

    % Non-vectorized for loop. A bit easier to read, but slower.
    for i=1:dim
       H_int(i,i) = 0.5*vecs(i)*(vecs(i)-1)' + vecs(i)*disorder;
    end
end