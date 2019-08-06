function data=gen_data(config)

% TODO: Modify generation so each graph is saved?
%   goal: Make the code 'run' like an experiment so I can leave it idling 

% Returns
%   Struct with single field, samp, which is a cell array of structs with
%   fields:
%       L               Spin chain length
%       W               Disorder bandwidth
%       num_eigs        Number of selected eigenvalues
%       sel             Indices of selected eigen*
%       num_samples     Number of disorder realizations
%       nrg             List of selected RESCALED eigenvalues corresponding to
%       v_sel           List of selected eigenvalues which are turned into
%       A_list          State graph objects generated by vec_to_graph
%
fwtext('')
fwtext('GENERATING DATA')
for i=1:numel(config.gen.Ws)
    
    if config.gen.Ws(i) == 0
        n_samp = 1;
    else
        n_samp = config.gen.num_samples;
    end
    if config.gen.verbose
      fprintf('\n=Disorder strength %.1f  \n',config.gen.Ws(i))
    end
    
        data.samp= cell(n_samp,1);
        data.L = config.gen.L;
        data.W = config.gen.Ws(i);
        data.num_eigs = config.gen.num_vecs;
        data.num_samples = config.gen.num_samples;
        data.sel = config.gen.sel;
        for k=1:n_samp
            if config.gen.verbose>1
                fprintf('--Sample %u/%u\n',k,n_samp)
            end
        %% Build H
            config.gen.W = config.gen.Ws(i);
            if config.gen.verbose>2
                fprintf('-- Generating H... ')
            end
            [data.H, data_temp.h_list] = H_AubreyAndre(config); 
%             if config.gen.verbose>2
%                 fprintf(' Diagonalizing... ')
%             end
%             [vecs, nrg] = eigs(full(H),max(config.gen.sel));
%             if config.gen.verbose>2
%                 fprintf(' Done\n')
%             end
%             data_temp.nrg = rescale(diag(nrg));
%             data_temp.nrg = data_temp.nrg(config.gen.sel);
%             data_temp.sel = config.gen.sel;
%             data_temp.v_sel = vecs(:,config.gen.sel);
%             data_temp.A_list = v2g_rec(data_temp.v_sel,config);
%             data.samp{k} = data_temp;
        end
%         if config.gen.save
%             fprintf(' - Saving output')
%             fname=[config.gen.savepath,'L-',num2str(data.L),...
%                 '-W',num2str(data.W),'-PBC.mat'];
%             save(fname,'-struct','data','-v7.3');
%         end
        fprintf('\n')

end
    

end