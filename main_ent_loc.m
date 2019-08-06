close all




%% Generating data
config.gen.N = 6;               % Number of bosons
config.gen.L = 6;              % System size
config.gen.bc = 'periodic';     % 'periodic' or 'open'
config.gen.Ws = 1;  %Disorder strengths
config.gen.num_samples = 1;     % # of disorder realizations
config.gen.sel = 1;
config.gen.save = false;
config.gen.savepath = '/home/jacob/Projects/ent_loc/dat/L13_dat/';

% Sample from the middle of the spectrum

%% CAREFUL, this can take a long time to execute.
% Generate eigenstate data
% % gen_data(config);

%% Import
% % Visualize & analyze results

config.gen.savepath = 'C:\Users\jaker\Documents\Projects\ent_loc\dat\ent_data\L13_dat';
[~,foldername,~] = fileparts(config.gen.savepath(1:end-1));
fwtext({'Starting graph import & process from %s',foldername})
net_data = import_network_data(config);


%% Process
fwtext('Processing imported data')
config.viz = [];
config.viz.Nmax = numel(net_data);
config.viz.outpath = fullfile([config.gen.savepath,'out/']);
config.viz.W_list = cellfun(@(x) x.prm.W, net_data);
config.viz.Nmax = numel(net_data);
config.viz.cutoff = 1e-15;
config.viz.save = false;
config = analysis_config(config);
system_proc(net_data,config);

fwtext('Main complete');
