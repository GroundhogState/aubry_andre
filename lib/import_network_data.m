function net_data = import_network_data(config)
% A wrapper for get_network_data
%   TODO: Safety checks

datapath = config.gen.savepath;
files = dir(fullfile(datapath,'*.mat'));
num_files = size(files,1);

net_data = cell(numel(config.gen.Ws,1));
for N=1:num_files
    fprintf('Importing file %.f/%.f\n',N,num_files)
    fname = files(N).name;
    fname = fullfile(datapath,fname);
    data = load(fname);
    net_data{N} = get_network_data(data);
end

end