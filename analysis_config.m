function config = analysis_config(config)

    

    % % Weight distribution
    weight = config.viz;
    weight.scaling = true;
    weight.log_scaling = false;
    weight.num_bins = 120;
    weight.win = [0,2];
    weight.scale = 1;
    weight.log_win = [-1,14];
    weight.log_scale = 1;
    weight.fid=1;
    weight.fig_title = 'Weight_distribution';
    weight.plots = {'linXlogY','logXlinY','logXlogY','linEnt'};
    config.viz.weight = weight;

    % % Degree distribution
    degree = config.viz;
    degree.scaling = false;
    degree.log_scaling = false;
    degree.num_bins = 100;
    degree.win = [-0.2,3];
    degree.scale = 1;
    degree.log_win = [-log10(3),9];
    degree.log_scale = 1;
    degree.fid=2;
    degree.fig_title='Degree_distribution';
    degree.plots = {'linXlinY','linXlogY','logXlogY','linEnt'};
    config.viz.degree = degree;
    % Measures of connectedness

    % % Algebraic properties: A vs L

    % Spectrum
    A_spec = config.viz;
    A_spec.scaling = false;
    A_spec.log_scaling = false;
    A_spec.num_bins = 75;
    A_spec.win = [-0.2,5];
    A_spec.scale = 1;
    A_spec.log_win = [-2,9];
    A_spec.log_scale = 1;
    A_spec.fid=11;
    A_spec.fig_title='Aleph_spectral_distribution';
    A_spec.plots = {'linXlinY','linXlogY','logXlogY','linEnt','logEnt'};
    config.viz.A_spec = A_spec;


    L_spec = config.viz;
    L_spec.scaling = false;
    L_spec.log_scaling = false;
    L_spec.num_bins = 50;
    L_spec.win = [0,0.21];
    L_spec.scale = 1;
    L_spec.log_win = [-log10(3),9];
    L_spec.log_scale = 1;
    L_spec.fid=12;
    L_spec.fig_title='Laplacian_spectral_distribution';
    L_spec.plots = {'linXlinY','linXlogY','logXlogY','linEnt'};
    config.viz.L_spec = L_spec;
    % Single eigenvalues?

    % % Trace
    A_trace = config.viz;
    A_trace.scaling = false;
    A_trace.log_scaling = false;
    A_trace.num_bins = 50;
    A_trace.win = [-1,28];
    A_trace.scale = 1;
    A_trace.log_win = [-1.5,0.5];
    A_trace.log_scale = 1;
    A_trace.fid=21;
    A_trace.fig_title='Aleph_trace_distribution';
    A_trace.plots = {'linXlinY','logXlogY','linEnt','logEnt'};
    config.viz.A_trace = A_trace;

    L_trace = config.viz;
    L_trace.scaling = false;
    L_trace.log_scaling = false;
    L_trace.num_bins = 50;
    L_trace.win = [0,26];
    L_trace.scale = 1;
    L_trace.log_win = [-1.5,0];
    L_trace.log_scale = 1;
    L_trace.fid=22;
    L_trace.fig_title='Laplacian_trace_distribution';
    L_trace.plots = {'linXlinY','logXlogY','linEnt','logEnt'};
    config.viz.L_trace = L_trace;

    % What's in the eigenvectors?

    % % 'Physical' stuff

    % VN entropy distribution
    VN_ent = config.viz;
    VN_ent.scaling = false;
    VN_ent.log_scaling = false;
    VN_ent.num_bins = 100;
    VN_ent.win = [-0.1,1.1];
    VN_ent.scale = 2;
    VN_ent.log_win = [-1,10];
    VN_ent.log_scale = 1;
    VN_ent.fid=3;
    VN_ent.fig_title='Single-site_entropy';
    VN_ent.plots = {'linXlinY','linXlogY','logXlogY','linEnt'};
    config.viz.VN_ent = VN_ent;
    
    % TMI
    TMI = config.viz;
    TMI.scaling = false;
    TMI.log_scaling = false;
    TMI.num_bins = 50;
    TMI.win = [0,50];
    TMI.scale = 2;
    TMI.log_win = [-10,10];
    TMI.log_scale = 1;
    TMI.fid=31;
    TMI.fig_title='TMI';
    TMI.plots = {'linXlinY','linEnt'};
    config.viz.TMI = TMI;
    
    cent = config.viz;
    cent.scaling = false;
    cent.log_scaling = false;
    cent.num_bins = 100;
    cent.win = [0,30];
    cent.scale = 2;
    cent.log_win = [-2,2];
    cent.log_scale = 1;
    cent.fid=41;
    cent.fig_title='Centrality';
    cent.plots = {'linXlinY','linXlogY','logXlinY','logXlogY','linEnt'};
    config.viz.cent = cent;
end
