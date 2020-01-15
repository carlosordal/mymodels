%this Script takes a can log on blf format, dbcs files and convert the
%can log into struct with time tables for each signal.
%dbcs should be stored on a specific defined location.
%this setup only takes ccan and lyftctrl dbcs
%ouputs are being saved as .mat file in the same directory as the blf file.
%using a similar name than the log but without spaces
%this script takes all messages on a CAN log and calculates mean, median and
% standard deviation on a struct.
% ccanCh = Channel number for ccan on blf file
% lyftCh = Channel number for ccan on blf file
%Golden Unicorn CAN Channels:
% Ch1 : CAN L5 Power
% Ch2: CAN L5 Ctrl
% Ch3: CAN/Ethernet
% Ch4: CAN C
% Ch5: CAN ePT
% Ch6: CAN C - isolated
% Ch7: CAN ePT - isolated

clear;
%Inputs
%select blf file
disp('Select CanLog file with blf format')
[blfFile,blfPath] = uigetfile('*.blf','Select CanLog file with blf format');                 %Open file selection dialog box
if isequal(blfFile,0)
   disp('User selected Cancel')
   
else
   disp(['User selected ', fullfile(blfPath, blfFile)])
end
%blfFullFile = fullfile(blfPath, blfFile);

%blfCanLog = '02 1211 AEB 40kph 10_40.blf';

%Assign CAN Channels
prompt = ('What''s the CCAN Channel # on blf file? ');
ccanCh      = input(prompt);
prompt = ('What''s the LyftCtrl Channel # on blf file? ');
lyftCtrlCh  = input(prompt);



%Outputs
%ccanSigTable
%lyftctrlSigTable


%% Path definition
this_folder = fileparts(mfilename('fullpath'));                             
%addpath(genpath(fullfile(this_folder, 'canLogData')));                             

guDbcFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari\GUv0 DBCs');
eptDbcFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari');

addpath(guDbcFolder);
addpath(eptDbcFolder);
addpath(blfPath);
%create the time tables for each channel

%load ccan.dbc and convert canlog into struct with timetables
ccandb = canDatabase('ccan.dbc');
ccanMsgTable = blfread(blfFile,ccanCh,'DataBase',ccandb);
ccanSigTable = canSignalTimetable(ccanMsgTable);

%save ccan Sigal Table into a mat file
save(fullfile(blfPath, 'ccanSigTable.mat'));

% Rename Mat file similar to blf filename plus network and save it on blf
% folder
oldFilename = fullfile(blfPath, 'ccanSigTable.mat');
[folder, baseFileName, extension] = fileparts(fullfile(blfPath, blfFile));
noSpaceName =  regexprep(baseFileName, ' ', '_');
newFilename = strcat(noSpaceName,'_cCan.mat');
newFilename = fullfile(blfPath, newFilename);
movefile( oldFilename, newFilename );


%load lyftctrlcan.dbc and convert canlog into struct with timetables
lyftCtrlDb = canDatabase('lyftctrlcan.dbc');
lyftCtrlMsgTable = blfread(blfFile,lyftCtrlCh,'DataBase',lyftCtrlDb);
lyftCtrlSigTable = canSignalTimetable(lyftCtrlMsgTable);

%save ccan Sigal Table into a mat file
save(fullfile(blfPath, 'lyftCtrlSigTable.mat'));

% Rename Mat file similar to blf filename plus network and save it on blf
% folder
oldFilename = fullfile(blfPath, 'lyftCtrlSigTable.mat');
[folder, baseFileName, extension] = fileparts(fullfile(blfPath, blfFile));
noSpaceName =  regexprep(baseFileName, ' ', '_');
newFilename = strcat(noSpaceName,'_lyftCtrl.mat');
newFilename = fullfile(blfPath, newFilename);
movefile( oldFilename, newFilename );




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%LyftCtrlCAN statistics comparison
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
fNames = fieldnames(lyftCtrlSigTable);
lyftCanAnalysis = struct('message',fNames);     %create struct with messages on can log
for i = 1:numel(fieldnames(lyftCtrlSigTable))   %number of messages
        thisMsg = fNames{i};
        
%   read Cycle Time from database
        attInfo = attributeInfo(lyftCtrlDb,'Message','GenMsgCycleTime',thisMsg);
        lyftCanAnalysis(i).CycleTimeDef = (attInfo.Value);
        attInfo = attributeInfo(lyftCtrlDb,'Message','GenMsgSendType',thisMsg);
        lyftCanAnalysis(i).MsgSendTypeDef = (attInfo.Value);
 
 %read period times for each message
        dt = diff(lyftCtrlSigTable.(fNames{i}).Time); 
        %dt = unique(diff(lyftCtrlSigTable.(fNames{i}).Time)); 

        minValue = seconds(min(dt(dt>0)))*1000;
        lyftCanAnalysis(i).MinValue = minValue;
        %LyftCanAnalysis.(thisMsg)(2,2) = minValue; 
        
        maxValue = seconds(max(dt))*1000;
        lyftCanAnalysis(i).MaxValue = maxValue;
       
        meanValue = mean(dt);                                   %calculate mean
        lyftCanAnalysis(i).MeanValue = seconds(meanValue*1000);           %
        
        StdValue = std(dt);
        lyftCanAnalysis(i).StdValue = seconds(StdValue*1000);
        medianValue = median(dt);
        lyftCanAnalysis(i).MedianValue = seconds(medianValue*1000);
 
 %Compare Cycle time vs max and min. +-10 ms and place it on a field
        %msgCyclicX = attInfo.Value;
        %msgCyclicX = "cyclicX";
        if lyftCanAnalysis(i).MsgSendTypeDef == "cyclicX"
            
            cycleTmTol = 0.10;      %10% tolerance for calculus
            cycleTmMxTol=lyftCanAnalysis(i).CycleTimeDef+((lyftCanAnalysis(i).CycleTimeDef)*cycleTmTol);
            if maxValue > cycleTmMxTol
                lyftCanAnalysis(i).CycleTMxCmp = 'error';
            else
                lyftCanAnalysis(i).CycleTMxCmp = 'ok';
            end
        
            cycleTmMnTol=lyftCanAnalysis(i).CycleTimeDef-((lyftCanAnalysis(i).CycleTimeDef)*cycleTmTol);
            if minValue < cycleTmMnTol
                lyftCanAnalysis(i).CycleTMnCmp = 'error';
            else
                lyftCanAnalysis(i).CycleTMnCmp = 'ok';
            end            
            
        end

end




