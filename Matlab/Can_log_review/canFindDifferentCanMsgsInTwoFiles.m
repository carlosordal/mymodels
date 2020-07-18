%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Create a list of messages present on a CAN log file on matfile format.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Next step select 2 files for comparisons or inputs two different files.


% matPath = 'C:\Users\cordunoalbarran\Repo\mymodels\Matlab\Can_log_review\EPS_ErrStat\';
% matFileA ='0626_P007_14-32_Messages_File_lyftctrlcan_DATA.mat';
% matFileB = 'P008_steering_error_ccan_lyft_lyftctrlcan_DATA.mat';

%% select a) .mat file
%disp(['Select *.mat file that contains candb and can timetable']);
[matFileA,matPath] = uigetfile('*.mat',['Select *.mat file that contains candb and can timetable']);                 %Open file selection dialog box
if isequal(matFileA,0)
   disp('User selected Cancel')
   
else
   disp(['User selected ', fullfile(matPath, matFileA)])
end

%disp(['Select b) *.mat file that contains candb and can timetable']);
[matFileB,matPath] = uigetfile('*.mat',['Select *.mat file that contains candb and can timetable']);                 %Open file selection dialog box
if isequal(matFileB,0)
   disp('User selected Cancel')
   
else
   disp(['User selected ', fullfile(matPath, matFileB)])
end



disp(['File A:',matFileA])
disp(['File B:',matFileB])

%Add Path
addpath(matPath);


%%
%load *.mat file with CAN database and time table log
%[folder, baseFileName, extension] = fileparts(fullfile(matPath, matFile));

dataMatA = load(matFileA);
logSignalTimeTableA = dataMatA.SignalTable;
fieldNamesA = fieldnames(logSignalTimeTableA);
canAnalysisA = struct('message',fieldNamesA);     %create struct with messages on can log

dataMatB = load(matFileB);
logSignalTimeTableB = dataMatB.SignalTable;
fieldNamesB = fieldnames(logSignalTimeTableB);
canAnalysisB = struct('message',fieldNamesB);     %create struct with messages on can log

msgs = "";
z = 0;
% identify if messages on file A are on file B
for i = 1:numel(fieldNamesA)   %number of messages
    thisMsgA = fieldNamesA{i};
    for k = 1:numel(fieldNamesB)   %number of messages
        thisMsgB = fieldNamesB{k};
        if isequal(thisMsgA, thisMsgB)
            fieldNamesA{i,2}="Found on B";
            %msgFound = boolean(1);
            break
        end
        if k == numel(fieldNamesB)
            z = z + 1;
            msgsFromANotOnB{z,1} = thisMsgA;
            
        end
    end
end    

disp(['Number of messages on A file that are not on B file:',num2str(numel(msgsFromANotOnB))])

% identify if messages on file B are on file A
z = 0;
for i = 1:numel(fieldNamesB)   %number of messages
    thisMsgB = fieldNamesB{i};
    for k = 1:numel(fieldNamesA)   %number of messages
        thisMsgA = fieldNamesA{k};
        if isequal(thisMsgA, thisMsgB)
            fieldNamesB{i,2}="Found on A";
            break
        end
        if k == numel(fieldNamesB)
            z = z + 1;
            msgsFromBNotOnA{z,1} = thisMsgB;
            
        end
    end
end 
disp(['Number of messages on B file that are not on A file:',num2str(numel(msgsFromBNotOnA))])