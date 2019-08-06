function graph_data = v2g_rec(vs,config)

    graph_data = cell(size(vs,2),1);
    kmax = size(vs,2);
    if config.gen.verbose > 2
        fprintf(' - Producing graph for vector 000/%3.f', kmax)
    end
    for k=1:kmax
        if config.gen.verbose > 2
            fprintf('\b\b\b\b\b\b\b\b %3.f/%3.f',k,kmax)
        end
        
        v = vs(:,k)/norm(vs(:,k)); %just in case
        L = log2(numel(v));
        rho = v.*v';
        ent_list = zeros(L,1);
        dims = 2*ones(1,L);
        A = zeros(L);
        A_temp = zeros(L);
        
        rho_1 = TrX(rho,1,dims);
        dim_red = dims(2:end);
        for ii=1:L-1 
            for jj = ii+1:L-1
               trace_pair = 1:L-1;
               trace_pair(ii) =[];
               trace_pair(jj-1) = [];
               rho_red = TrX(rho_1,trace_pair,dim_red);
               A_temp(ii+1,jj+1) =  Entropy(rho_red);
            end
            if ii==L-1
                ent_list(L) = Entropy(TrX(rho_red,1,[2,2]));
            else
                ent_list(ii+1) = Entropy(TrX(rho_red,2,[2,2]));
            end
        end
        rho_2 = TrX(rho,2,dims);
        for ll = 2:L-1
           dim_red2 = dims([1:ll,ll+2:L]);
           rho_red = TrX(rho_2, [2:ll-1,ll+1:L-1],dim_red2);
           A_temp(1,ll+1) = Entropy(rho_red);

        end
        rho_12 = TrX(rho,[3:L],dims);
        rho_01 = TrX(rho_12,2, [2,2]);
        rho_02 = TrX(rho_12,1, [2,2]);
        A_temp(1,2) = Entropy(rho_12);
        ent_list(1) = Entropy(rho_01);
        ent_list(2) = Entropy(rho_02);
        
        A_temp = abs(A_temp + A_temp');
        for ii=1:L
            for jj=1:L
            A(ii,jj) = abs(ent_list(ii)) + abs(ent_list(jj)) - A_temp(ii,jj);  
            end
        end

        graph_data{k} = A; %Aleph - has 2*on-site entropy on diagonal. Can recover G (zero diag) & L easy
    end
    fprintf('\n')

end