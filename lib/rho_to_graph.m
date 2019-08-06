function A = rho_to_graph(rho)
% INPUT: One density matrix. 
%OUTPUT: One Aleph. Diagonal is 2x VN entropy, off-diag is MI.
% SUPERSEDES vec_to_graph
        rho = rho/trace(rho);
        L = log2(length(rho));
        ent_list = zeros(L,1);
        dims = 2*ones(1,L);
        A = zeros(L);
        A_temp = zeros(L);
        systems = 1:L;

        for ii=1:L 
            for jj = ii+1:L
               trace_pair = systems;
               trace_pair(ii) =[];
               trace_pair(jj-1) = [];
               rho_red = TrX(rho,trace_pair,dims);
               A_temp(ii,jj) =  Entropy(rho_red);
            end
            if ii==L
                ent_list(ii) = Entropy(TrX(rho_red,1,[2,2]));
            else
                ent_list(ii) = Entropy(TrX(rho_red,2,[2,2]));
            end
        end

        A_temp = abs(A_temp + A_temp');
        for ii=1:L
            for jj=1:L
            A(ii,jj) = abs(ent_list(ii)) + abs(ent_list(jj)) - A_temp(ii,jj);  
            end
        end

end