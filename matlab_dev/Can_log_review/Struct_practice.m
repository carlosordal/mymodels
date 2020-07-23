%create and play with struct


%% Path definition
this_folder = fileparts(mfilename('fullpath'));                             
addpath(genpath(fullfile(this_folder, 'canLogData')));      %blf file                          

%path for dbc files
GuDbcFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari\GUv0 DBCs');
eptDbcFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari');


addpath(GuDbcFolder);
addpath(eptDbcFolder);

%path for can log file. blf format
BlfCanLog = 'P003 AEB weeks 10 km_test.blf';

%create time tables for lyftctrlcan
lyftctrldb = canDatabase('lyftctrlcan.dbc');
lyftctrlMsgTable = blfread(BlfCanLog,2,'DataBase',lyftctrldb);
lyftctrlSigTable = canSignalTimetable(lyftctrlMsgTable);

%message list of message exisiting on the can log for lyftctrl
fNames = fieldnames(lyftctrlSigTable);

%create struct with messages on can logs
s = struct('message',fNames);
%creat new empty fields
% s(1).CycleTime = [];
% s(1).MinValue = [];
% s(1).MaxValue = [];
% s(1).MeanValue = [];
% s(1).StdValue = [];
% s(1).MedianValue = [];

s(1).CycleTime = 1;             %write on Cycletime row 1
s(2).MinValue = 2;              %write on MinValue row 2
s(3).MaxValue = 3;              %write on maxvalue row 3
s(4).MeanValue = 4;
s(5).StdValue = 5;
s(6).MedianValue = 6;
% field = {1;};
% message = {'Msg1'; 'Msg2'};
% s = struct('message',{'Msg1';'Msg2'},'valmin',{1.5; 2.5});  %message chr column valmin numeric column
% s(1).valmax = 5;        % add & write valmax column on row 1 of struct
% with title

% readstruct = s(1).valmax;                                   %read valmax row 1. msg1
% 
% fNames = fieldnames(lyftctrlSigTable);
% 
% 
% message = {'DAS_A3'; 'DAS_A4'; 'DAS_A5'};
% s = struct('message',message,'valmin',field);