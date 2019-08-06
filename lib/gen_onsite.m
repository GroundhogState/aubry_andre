function H = gen_onsite(L,h_list)
%% Creates a disordered on-site Hamiltonian for fixed spin systems. 
% Defaults to S_z but can set otherwise.

eye_list = cell(L,1);
for ii=1:L
    eye_list{ii} = (eye(2));
end
H = sparse(zeros(2^L));
for ii = 1:L 
   op_list = eye_list;
   op_list{ii} = (h_list(ii)*Pauli('Z',0));
   H = H + Tensor(op_list);
end


end %all