function viz_data = distribution_viz(input,config_viz)
    
% Inputs: The entire set of values for a certain parameter (edge weights,
% eigenvalues, VN entropies, etc) indexed by disorder strength, scaled
% energy density, and disorder sample. 
% Outputs: viz_data, a cell array with histogram bin centres & populations for linear and log data for each disorder 

% User config
%   Scale - the maximum scale for the inputs, used to create hist bins
%   Cutoff - the minimum value to consider for data. Good for avoiding
%       numerical errors but also set a natural scale
%   Scaling - If enabled, data is rescaled to the unit interval 
%   log_scaling - similar

% SCALING
%   MI has a natural scale; it's bounded above (in spin chain) by 2.
%       In general, a scale parameter should be passed as input.    All data rescaled by this value so max(data) = 1   
%       Also input a cutoff scale. All data below this scale will be
%          truncated, and then the remaining data rescaled to live on the
%          unit interval.
%       
        Nmax = numel(input);
        viz_data.dat = cell(Nmax,1);     
        viz_data.entropy=zeros(Nmax,1);
        viz_data.log_entropy=zeros(Nmax,1);
        for N = 1:Nmax
            % Compile the data into a single list
            dat_temp = squeeze(input{N}(:));
            % Remove anything too close to limit of machine precision
            dat_temp = dat_temp(dat_temp>config_viz.cutoff); 
            viz_data.dat{N} = dat_temp;
            if config_viz.scaling
                viz_data.dat{N}=viz_data.dat{N}/config_viz.scale;
            end
            viz_data.hist_win{N} = linspace(min(config_viz.win),max(config_viz.win),config_viz.num_bins);
            viz_data.hist_bins{N} =0.5*(viz_data.hist_win{N}(2:end)+viz_data.hist_win{N}(1:end-1));           
            viz_data.hist_counts{N} = histcounts(viz_data.dat{N},viz_data.hist_win{N},'Normalization','pdf');

            viz_data.log_dat{N} =-log10(dat_temp);
            if config_viz.log_scaling
                viz_data.log_dat{N} = -viz_data.log_dat{N/config_viz.log_scale};
            end
            viz_data.log_hist_win{N} = linspace(min(config_viz.log_win),max(config_viz.log_win),config_viz.num_bins);
            viz_data.log_hist_bins{N} =0.5*(viz_data.log_hist_win{N}(2:end)+viz_data.log_hist_win{N}(1:end-1));
            viz_data.log_hist_counts{N} = histcounts(viz_data.log_dat{N},viz_data.log_hist_win{N},'Normalization','pdf');

            nz_counts = viz_data.hist_counts{N}(viz_data.hist_counts{N}>0);
            viz_data.entropy(N) = hist_entropy(nz_counts,viz_data.hist_win{N});

            log_nz_counts = viz_data.log_hist_counts{N}(viz_data.log_hist_counts{N}>0);
            viz_data.log_entropy(N) = hist_entropy(log_nz_counts,viz_data.log_hist_win{N});
        end
        


end
