function init_mcecu_uds_on_fusion
%% Init file for body controller code gen model for MCECU
app_name = extractAfter(mfilename,'init_');
app_folder = fileparts(which(mfilename));

%% Path definition
this_folder = fileparts(mfilename('fullpath')); 
%fullpath = fullfile(this_folder, '\+fusion_cc_17_with_functions');
%fcnPath = genpath(fullfile(this_folder, '+mcecu_uds_on_fusion'));
addpath(genpath(fullfile(this_folder, '\+mcecu_uds_on_fusion')));

