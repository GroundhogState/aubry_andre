function ent_data = entropy_viz(in_net_data,config)

            
            Nmax = numel(in_net_data);
            W_list = config.viz.W_list;
            %% Sitewise Von Neumann Entropy
            sfigure(config.viz.fid);
            cm = colormap(plasma(Nmax));
            all_entropy = zeros(numel(in_net_data),config.viz.num_bins-1);
            for N=1:Nmax
                data = squeeze(in_net_data{N}.P.entropy_VN(:));
                ent_data.hist_win{N} = linspace(-0.10,1.1,config.viz.num_bins);
                ent_data.ent_counts{N} = histcounts((abs(data)),ent_data.hist_win{N},'Normalization','pdf');
                ent_data.P_zero{N} = sum(data<0.5)/sum(data>0);

                hist_win = ent_data.hist_win{N} ;
                H = ent_data.ent_counts{N};
                all_entropy(N,:) = H;
            
            
                subplot(2,3,1)
                plot(0.5*(hist_win(2:end)+hist_win(1:end-1)),H,'Color',cm(N,:))
                hold on
                xlabel('von Neumann entropy S')
                ylabel('P(S_i) = S')

    %             subplot(2,3,2)
    %             all_entropy = zeros(numel(in_net_data),length(hist_win)-1);
    %             for N = 1:numel(in_net_data)
    %                 data = squeeze(in_net_data{N}.P.entropy_VN(:));
    %                 all_entropy(N,:) = histcounts((abs(data)),hist_win,'Normalization','pdf');
    %             end
    %             imagesc(W_list,hist_win,log10(all_entropy+1)')
    %             title('Local entropy')            


                subplot(2,3,2)
                plot(0.5*(hist_win(2:end)+hist_win(1:end-1)),H,'Color',cm(N,:))
                hold on
                set(gca,'Yscale','log')
                xlabel('von Neumann entropy S')
                ylabel('P(S_i) = S')
                title('Local entropy') 


                subplot(2,3,3)
                S = hist_entropy(H,hist_win);
                plot(W_list(N),S,'kx')
                hold on

                xlabel('Disorder')
                ylabel('Entropy of VN distribution')
                
                subplot(2,3,4)
                plot(W_list(N), ent_data.P_zero{N},'bx')
                hold on
                plot(W_list(N), 1-ent_data.P_zero{N},'rx')
                legend('P(\epsilon)<0.5','P(\epsilon)>0.5')
                
                subplot(2,3,5)
                plot(W_list(N), ent_data.P_zero{N}./(1-ent_data.P_zero{N}),'bx')
                hold on
            end
            subplot(2,3,6)
            imagesc(W_list,hist_win,(all_entropy)')
            title('Local entropy') 
            
            suptitle('Single-site VN distribution')
    
end