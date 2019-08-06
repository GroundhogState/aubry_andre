function delta = rho_reduce(rho,dims,num_sys)
  % Accepts a many-body density matrix, a list of dimensions of its subsystems,
  % and the length L of the total initial system
  N = length(dims);
  delta = cell(N,N);  % Will eventually hold output.
  % Can also use zeros(L,L,d,d}but troublesome if d isn't homogeneous
  % Although latter might be better for the return part here...
  % Might be easier with python dicts
  if N == 2
    % Base case
    delta{N-1,N}= rho;
    delta{N-1,N-1}= TrX(rho,2,dims);
    delta{N,N}= TrX(rho,1,dims);
  elseif N > 2
    % Nondegenerate super-cases:
    % Obtain first pair and first single site
    delta{num_sys-N+1,num_sys-N+2}= TrX(rho, 3:N,dims);
    delta{num_sys-N+1,num_sys-N+1}= TrX(delta{num_sys-N+1,num_sys-N+2},2,dims(1:2));
    % Obtain all pairs involving the first system but not the second
    rho_temp = TrX(rho,2,dims);
%     delta{num_sys-N+1,num_sys-N+k+1}= TrX(rho_temp, k,dims)
    for k = 2:N-1
      delta{num_sys-N+1,num_sys-N+k+1} = TrX(rho_temp,[2:k-1,k+1:N-1],dims([1,3:end]));
    end
    % Can possibly get more speed here by tracing down further, but leave this to later
    % Call the next recursion and use it to fill out the Delta array
    delta(2:end,2:end) = rho_reduce(TrX(rho,1,dims),dims(2:end),N-1);
    % MATLABly:
    % delta{num_sys-L+1:end,num_sys-L+1:end,} ?= rho_reduce(TrX(rho,1),dims(2:end),L)
  end
end