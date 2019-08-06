function H_kin = H_tunnelling(vecs)

% INPUTS: Fock basis vectors
% RETURNS: Sparse Hamiltonian for nearest-neighbour hopping

tags = tag(vecs);
% Sorting the tags means the search fn in the loop is faster by n/log(n)
% Which is MUCH faster for large systems 
[tag_sort,tag_idx] = sort(tags);
% Even with this, the search parts of this function take almost all of the
% time!

% For a minor overhead we re-compute L and N here, makes calls cleaner
L = size(vecs,2);
N = sum(vecs(1,:)); 
dim=factorial(N+L-1)/(factorial(N)*factorial(L-1));
% The Hamiltonian will be very sparse! So to save memory and operations,
% this function will generate a sparse matrix output. 
H_idx = zeros(2*dim*L,2);
H_val = zeros(2*dim*L,1);


% Below function basically does:
%   For each of the L sorted basis vectors, 
%       Tunnel a particle to the right
%       Find the tag index of the basis vector 
%       Set the entry of the sparse output Hamiltonian
%   Then, add the conjugate term
count =0 ;% Keeps track of number of bases found so far... 
for ii=1:dim %Loop over all basis vectors
%     vec = vecs(ii,:); %current working vector
    for jj=1:L
            if vecs(ii,jj) ~= 0 % Tunnelling operator needs a particle to annihilate!
                img = vecs(ii,:);      % A copy of the vector for local work
                count = count + 1;
                % Tunnel a particle from jj to jj+1 assuming PBC 
                kk = mod(jj,L) + 1;
                img(jj) = img(jj) - 1;
                img(kk) = img(kk) + 1;
                % Find the tag index of the output vector
                tag_out = tag(img); 
%                 idx_out = find(tag_sort==tag_out);

%                 [ii,jj]
                [~,idx_out] = closest_value(tag_sort,tag_out);
            % Now, the indexing here is tricky (and I got it wrong AGAIN)
            % If
                tag_out = tag_idx(idx_out);
                H_idx(count,:) = [ii,tag_out];
                H_val(count) = sqrt(vecs(ii,jj))*sqrt(vecs(ii,kk)+1);   
%                 H_sparse(ii,tag_idx(idx_out)) = sqrt(vecs(ii,jj))*sqrt(vecs(ii,kk)+1);                  
            end
    end
end
H_temp = sparse(H_idx(1:count,1),H_idx(1:count,2),H_val(1:count),dim,dim);
%And add the conjugate terms
H_kin = H_temp + H_temp';


