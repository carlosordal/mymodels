%this script takes all messages on a CAN log and calculates mean, median and
% standard deviation on a struct.
% ccanCh = Channel number for ccan on blf file
% lyftCh = Channel number for ccan on blf file

clear;
%Inputs
ccanCh      = 4;
lyftctrlCh  = 2;
BlfCanLog = '02 1211 AEB 40kph 10_40.blf';

%Outputs
%ccanSigTable
%lyftctrlSigTable


%% Path definition
this_folder = fileparts(mfilename('fullpath'));                             
addpath(genpath(fullfile(this_folder, 'canLogData')));                             
%addpath(genpath(fullfile(this_folder, '..', '..', 'common')));

GuDbcFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari\GUv0 DBCs');
eptDbcFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari');

addpath(GuDbcFolder);
addpath(eptDbcFolder);

%create the time tables for each channel

%lyftcanfile = importdata('lyftctrlcan.dbc');%needed if we are reading from candbc directly.

ccandb = canDatabase('ccan.dbc');
ccanMsgTable = blfread(BlfCanLog,ccanCh,'DataBase',ccandb);
ccanSigTable = canSignalTimetable(ccanMsgTable);

lyftctrldb = canDatabase('lyftctrlcan.dbc');
lyftctrlMsgTable = blfread(BlfCanLog,lyftctrlCh,'DataBase',lyftctrldb);
lyftctrlSigTable = canSignalTimetable(lyftctrlMsgTable);

%[ccanSigTable, lyftctrlSigTable, eptSigTable] = fcn_CanLogImport(1,'ccan.dbc',2,'lyftctrlcan.dbc',3,'E4A_R4_CCAN3_CR11690_Mod.dbc','P003 AEB weeks 10 km_test.blf');

%LyftCtrlCAN statistics

fNames = fieldnames(lyftctrlSigTable);
LyftCanAnalysis = struct('message',fNames);     %create struct with messages on can log
for i = 1:numel(fieldnames(lyftctrlSigTable))   %Read Msg Names
        thisMsg = fNames{i};
        
%   read Cycle Time from database
        attinfo = attributeInfo(lyftctrldb,'Message','GenMsgCycleTime',thisMsg);
        LyftCanAnalysis(i).CycleTimeDef = (attinfo.Value);
        attinfo = attributeInfo(lyftctrldb,'Message','GenMsgSendType',thisMsg);
        LyftCanAnalysis(i).MsgSendTypeDef = (attinfo.Value);
 
 %read period times for each message
        dt = unique(diff(lyftctrlSigTable.(fNames{i}).Time)); 

        minValue = seconds(min(dt))*1000;
        LyftCanAnalysis(i).MinValue = minValue;
        %LyftCanAnalysis.(thisMsg)(2,2) = minValue; 
        
        maxValue = seconds(max(dt))*1000;
        LyftCanAnalysis(i).MaxValue = maxValue;
       
        meanValue = mean(dt);                                   %calculate mean
        LyftCanAnalysis(i).MeanValue = seconds(meanValue*1000);           %
        
        StdValue = std(dt);
        LyftCanAnalysis(i).StdValue = seconds(StdValue*1000);
        medianValue = median(dt);
        LyftCanAnalysis(i).MedianValue = seconds(medianValue*1000);
        
        

end

 %info = attributeInfo(lyftcandb,'Message','GenMsgCycleTime','DAS_A4')

% for i = 1:numel(fieldnames(lyftctrlSigTable))   %Read Msg Names
%         field = fNames{i};
%         
%         dt = unique(diff(lyftctrlSigTable.(fNames{i}).Time));
%         meanValue = mean(dt);
%         lyftCanAnalysis.(fNames{i}).Mean = meanValue;
%         StdValue = std(dt);
%         lyftCanAnalysis.(fNames{i}).Std_dev = StdValue;
%         medianValue = median(dt);
%         lyftCanAnalysis.(fNames{i}).median = median(dt);
% 
% end

%struct examples

% field = {1; 2; 3;};
% message = {'DAS_A3'; 'DAS_A4'; 'DAS_A5'};
% s = struct('message',message,'valmin',field);


