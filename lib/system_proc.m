function proc_data = system_proc(net_data,config)

if ~exist(fullfile([config.gen.savepath,'out/']),'dir')
    mkdir(fullfile([config.gen.savepath,'out/']))
end

weight_dist = cellfun(@(x) x.G.weight_list, net_data,'UniformOutput',false);
proc_data.weights = distribution_viz(weight_dist,config.viz.weight);
plot_hists(proc_data.weights,config.viz.weight)
if config.viz.save
    saveas(gcf,fullfile([config.viz.outpath,config.viz.weight.fig_title,'.png']))
end

% % Degree distribution
degree_dist = cellfun(@(x) x.G.degree_list, net_data,'UniformOutput',false);
proc_data.degree =distribution_viz(degree_dist,config.viz.degree);
plot_hists(proc_data.degree,config.viz.degree)
if config.viz.save
    saveas(gcf,fullfile([config.viz.outpath,config.viz.degree.fig_title,'.png']))
end

% Measures of connectedness

% % Algebraic properties: A vs L

% Spectrum
aleph_spec_dist = cellfun(@(x) x.A.evals, net_data,'UniformOutput',false);
proc_data.A_spec=distribution_viz(aleph_spec_dist,config.viz.A_spec);
plot_hists(proc_data.A_spec,config.viz.A_spec)
if config.viz.save
        saveas(gcf,fullfile([config.viz.outpath,config.viz.A_spec.fig_title,'.png']))
end

lap_spec_dist = cellfun(@(x) x.L.evals, net_data,'UniformOutput',false);
proc_data.L_spec=distribution_viz(lap_spec_dist,config.viz.L_spec);
plot_hists(proc_data.L_spec,config.viz.L_spec)
if config.viz.save
    saveas(gcf,fullfile([config.viz.outpath,config.viz.L_spec.fig_title,'.png']))
end

    % Single eigenvalues?

% % Trace
aleph_trace_dist = cellfun(@(x) x.A.trace, net_data,'UniformOutput',false);
proc_data.A_trace=distribution_viz(aleph_trace_dist,config.viz.A_trace);
plot_hists(proc_data.A_trace,config.viz.A_trace)
if config.viz.save
    saveas(gcf,fullfile([config.viz.outpath,config.viz.A_trace.fig_title,'.png']))
end

lap_trace_dist = cellfun(@(x) x.L.trace, net_data,'UniformOutput',false);
proc_data.L_trace=distribution_viz(lap_trace_dist,config.viz.L_trace);
plot_hists(proc_data.L_trace,config.viz.L_trace)
if config.viz.save
    saveas(gcf,fullfile([config.viz.outpath,config.viz.L_trace.fig_title,'.png']))
end

% % 'Physical' stuff
% VN entropy distribution
ent_dist = cellfun(@(x) x.P.entropy_VN, net_data,'UniformOutput',false);
proc_data.VN_entropy = distribution_viz(ent_dist,config.viz.VN_ent);
plot_hists(proc_data.VN_entropy,config.viz.VN_ent)
if config.viz.save
    saveas(gcf,fullfile([config.viz.outpath,config.viz.VN_ent.fig_title,'.png']))
end

TMI_dist = cellfun(@(x) x.P.TMI, net_data,'UniformOutput',false);
proc_data.TMI = distribution_viz(TMI_dist,config.viz.TMI);
plot_hists(proc_data.TMI,config.viz.TMI)
if config.viz.save
    saveas(gcf,fullfile([config.viz.outpath,config.viz.TMI.fig_title,'.png']))
end

% Centrality
cent_dist = cellfun(@(x) x.G.node_centrality, net_data,'UniformOutput',false);
proc_data.cent = distribution_viz(cent_dist,config.viz.cent);
plot_hists(proc_data.cent,config.viz.cent)
if config.viz.save
    saveas(gcf,fullfile([config.viz.outpath,config.viz.cent.fig_title,'.png']))
end

fwtext('Done!')

end
