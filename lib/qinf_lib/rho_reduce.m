function delta = rho_reduce(rho,dims,num_sys)
% In this version: Try to optimize second stage (loop over subsystems)
  % Accepts a many-body density matrix, a list of dimensions of its subsystems,
  % and the length L of the total initial system
  N = length(dims);
  delta = cell(N,N);  % Will eventually hold output.
  if N == 2
    % Base case
    delta{N-1,N}= rho;
    delta{N-1,N-1}= TrX(rho,2,dims);
    delta{N,N}= TrX(rho,1,dims);
  elseif N > 2
    % Super-cases:
    % Obtain first pair and first single site
    delta{num_sys-N+1,num_sys-N+2}= TrX(rho, 3:N,dims);
    delta{num_sys-N+1,num_sys-N+1}= TrX(delta{num_sys-N+1,num_sys-N+2},2,dims(1:2));
    % Obtain all pairs involving the first system but not the second
    delta(num_sys-N+1,num_sys-N+3:end) = cleave_trace(TrX(rho,2,dims),dims([1,3:end]));
    % Call the next recursion and use it to fill out the Delta array
    delta(2:end,2:end) = rho_reduce(TrX(rho,1,dims),dims(2:end),N-1);
  end
end

function delta_row = cleave_trace(rho,dims)
    % A tailored function which computes all the 2-body density matrices of
    % a many-body state, constrained such that each 2BDM includes the first
    % site.
    N = length(dims);
    % Returns a cell array of all 2BDMs involving the first system
    % of which there are N-1
    delta_row = cell(1,N-1);
    if N == 2
        % base case
        delta_row{1} = rho;
    elseif N>2
        % Superior case
        n1 = ceil(N/2);
        % obtain RDM1 by tracing out the right half, = [s1,s2,...,sn1]
        delta_row(1:n1-1) = cleave_trace(TrX(rho, n1+1:N,dims),dims(1:n1));
        % Obtain RDM2 by tracing out the left half except S1, = [s1,s(n1+1),...,sN]
        delta_row(n1:end) = cleave_trace(TrX(rho, 2:n1,dims),dims([1,n1+1:N]));
    else 
        error('Wrong system size')
    end

end