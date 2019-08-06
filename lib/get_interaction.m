function H_int = get_interaction(L, bc)
%% Creates NN interactions between X, Y, and Z components
    if isempty(bc)
        bc = 'open';
    end
    int_components = ['X', 'Y', 'Z'];
    eye_list = cell(L,1);
    for ii=1:L
        eye_list{ii} = sparse(eye(2));
    end

    H_int = sparse(zeros(2^L));

    if strcmp(bc,'open')
        for ii=L-1
            for jj = 1:size(int_components,2)
                op_list = eye_list;
                op_list{ii} = Pauli(int_components(jj));
                op_list{ii+1} = Pauli(int_components(jj));
                H_int = H_int + Tensor(op_list);
            end %loop over Paulis
        end %loop over sites
    elseif strcmp(bc ,'periodic')
        for ii=1:L
            for jj = 1:size(int_components,2)
                op_list = eye_list;
                op_list{ii} = Pauli(int_components(jj));
                op_list{mod(ii,L)+1} = Pauli(int_components(jj));
                H_loc = Tensor(op_list);
                H_int = H_int + H_loc;
            end %loop over Paulis
        end %loop over sites
    end %bc case

end