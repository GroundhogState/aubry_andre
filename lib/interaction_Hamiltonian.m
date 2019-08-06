function H_int = inte_Ham(vecs)
    % Creates the diagonal part of the Hamiltonian in a fixed-N Fock space

    % Vectorized version - much quicker generally
    H_int = diag(diag(vecs*(vecs-1)))/2;

    % Non-vectorized for loop. A bit easier to read, but slower.
%     temp = zeros(length(vecs),1);
%     for i=1:length(temp)
%        temp(i) = vecs(i)*(vecs(i)-1)';
%     end
%     H_int = diag(temp)/2;
end