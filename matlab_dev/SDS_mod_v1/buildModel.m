close all;
clc;
% Config
dSpace_mdl_name = 'SDS_mod_v1';
dSpace_board = 'rti1401';


% Sanity check
% try
%    eval(['init_' dSpace_mdl_name]);
%    r = sim(dSpace_mdl_name,0);
%catch lastErr
%    disp('********** Check that the model can init/run first! **************');
%    rethrow(lastErr);
%end

% Copy user MK file
custom_code_dir = fullfile(pwd,'code');
copyfile(fullfile(custom_code_dir,'usr.mk'),[dSpace_mdl_name '_usr.mk']);
copyfile(fullfile(custom_code_dir,'usr.c'),[dSpace_mdl_name '_usr.c']);


% Init & Build
rtwbuild(dSpace_mdl_name);



clean_up = false;
if clean_up
    
    % Copy artifacts
    artifacts_dir = fullfile('artifacts');
    auto_code_dir = fullfile(artifacts_dir, 'auto-generated-code');
    
    if exist(artifacts_dir,'dir')
        rmdir(artifacts_dir,'s');
    end
    if exist(auto_code_dir,'dir')
        rmdir(auto_code_dir,'s');
    end
    mkdir(artifacts_dir);
    mkdir(auto_code_dir);
    
    movefile('*.map', artifacts_dir);
    
    movefile('*.sdf', artifacts_dir);
    movefile('*.ppc', artifacts_dir);
    movefile('*.hex', artifacts_dir);
    movefile('*.trc', artifacts_dir);
    
    if ~isempty(dir('*.c')), movefile('*.c', auto_code_dir), end
    if ~isempty(dir('*.h')), movefile('*.h', auto_code_dir), end
    if ~isempty(dir('*.mk')), movefile('*.mk', auto_code_dir), end
    
    movefile([dSpace_mdl_name '_' dSpace_board], auto_code_dir);
    
    
    % Clean up
    rmdir('slprj','s');
    delete *.trz;
    delete *.srec;
    delete *.dsbuildinfo
    
end