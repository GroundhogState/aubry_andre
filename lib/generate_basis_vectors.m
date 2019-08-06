function vectors = basis_gen(N,L)
% We can define a total ordering on the set of basis vector spanning an
% N-particle Fock space (see the tutorial by Zhang & Dong).
% This function recursively computes the spanning set of basis vectors when
% given 
%   INPUTS:     N           number of bosons
%               L           Number of lattice sites
%   OUTPUTS:    vectors     Array of size [DxL] of Fock vectors       
    
   
    
    
    % Initialize the first vector, [N,0,0,...,0]
    v0 = zeros(1,L);
    v0(1) = N;
    
    % This is the core of the function: A recursive method to
    % systematically compute all the basis vectors in F^N. See Zhang & Dong
    % for information on terminology.
    % Initialize the output for more efficient memory use
    dim = factorial(N+L-1)/(factorial(N)*factorial(L-1)); 
    vectors = zeros(dim, L);
    vectors(1,:) = v0; % The principal vector is the first element of output
    for ii = 1:dim-1
       c_vector = vectors(ii,:); % Select the most recent basis vector and
       c_vector = next_vector(c_vector); % then computes the next inferior vector
       vectors(ii+1,:) = c_vector; % then appends it to the output
    end

end

function next_vec = next_vector(v)
    % Zhang & Dong's paper explains the reasoning behind this subroutine.
    % There is a total ordering induced on the Fock basis by the number in
    % successive sites. This function accepts
    %   INPUT       Fock vector (of arbitrary length & particle number)
    %   OUTPUT      The next vector according to the total ordering
    N = sum(v);
    L = size(v,1);
    v_temp = v;
    if v(end) == N
            return
    else
        if v(end) ~=0
            secondlast_nonzero = max(find(v(1:end-1)>0));
            v_temp(secondlast_nonzero) = v_temp(secondlast_nonzero)-1;
            k_temp = sum(v_temp(secondlast_nonzero+1:end));
            v_temp(secondlast_nonzero+1:end) = 0;
            v_temp(secondlast_nonzero + 1) = v_temp(secondlast_nonzero+1)+k_temp+1;
            next_vec = v_temp;
        else
            last_nonzero_idx = max(find(v>0));
            v_temp(last_nonzero_idx) = v_temp(last_nonzero_idx)-1;
            v_temp(last_nonzero_idx+1) = v_temp(last_nonzero_idx+1)+1;
            next_vec = v_temp;
        end
    end
    
end