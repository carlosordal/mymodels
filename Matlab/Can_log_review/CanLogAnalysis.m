clear
%% Path definition
this_folder = fileparts(mfilename('fullpath'));                             
addpath(genpath(fullfile(this_folder, 'canLogData')));                             
%addpath(genpath(fullfile(this_folder, '..', '..', 'common')));

GuDbFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari\GUv0 DBCs');
eptDbFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari');


addpath(GuDbFolder);
addpath(eptDbFolder);

%create the time tables for each channel
BlfCanLog = 'P003 AEB weeks 10 km_test.blf';
lyftcanfile = importdata('lyftctrlcan.dbc');

ccandb = canDatabase('ccan.dbc');
ccanMsgTable = blfread(BlfCanLog,1,'DataBase',ccandb);
ccanSigTable = canSignalTimetable(ccanMsgTable);

lyftctrldb = canDatabase('lyftctrlcan.dbc');
lyftctrlMsgTable = blfread(BlfCanLog,2,'DataBase',lyftctrldb);
lyftctrlSigTable = canSignalTimetable(lyftctrlMsgTable);

%[ccanSigTable, lyftctrlSigTable, eptSigTable] = fcn_CanLogImport(1,'ccan.dbc',2,'lyftctrlcan.dbc',3,'E4A_R4_CCAN3_CR11690_Mod.dbc','P003 AEB weeks 10 km_test.blf');

%LyftCtrlCAN statistics

fNames = fieldnames(lyftctrlSigTable);
for i = 1:numel(fieldnames(lyftctrlSigTable)) 
        field = fNames{i};
        
        dt = unique(diff(lyftctrlSigTable.(fNames{i}).Time));
        meanValue = mean(dt);
        lyftCanAnalysis.(fNames{i}).Mean = meanValue;
        StdValue = std(dt);
        lyftCanAnalysis.(fNames{i}).Std_dev = StdValue;
        medianValue = median(dt);
        lyftCanAnalysis.(fNames{i}).median = median(dt);

end






