% this scripts analyze a can log on timeTable format 
% Input: 
% *CANData.mat file that contains can database on mat format and a
% can log on a time table format

% Ouput:
%  1) Struct with time table data


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% CAN statistics comparison
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Selec .mat files with CAN database and Can log on time table format
% Which CAN channel will be analyzed
networkSel = questdlg('Which CAN network will be converted?', ...
        'Choose CAN Network', ...
        'cCAN', 'lyftCtrlCAN', 'ePtCAN', 'cCAN');

%% select .mat file
disp(['Select *.mat file for ',networkSel,' network that contains ccandb and can timetable'])
[matFile,matPath] = uigetfile('*.mat',['Select *.mat file for ',networkSel,' network that contains ccandb and can timetable']);                 %Open file selection dialog box
if isequal(matFile,0)
   disp('User selected Cancel')
   
else
   disp(['User selected ', fullfile(matPath, matFile)])
end

%Add Path
addpath(matPath);

%%
%load can database
[folder, baseFileName, extension] = fileparts(fullfile(matPath, matFile));
dataMat = load(dbFile);
dataMat = dataMat.(baseFileName);


%load Signal Time Tables
[folder, baseFileName, extension] = fileparts(fullfile(logPath, logFile));
signalTimeTable = load(logFile);
signalTimeTable = signalTimeTable.(baseFileName);

fNames = fieldnames(signalTimeTable);
canAnalysis = struct('message',fNames);     %create struct with messages on can log
for i = 1:numel(fieldnames(signalTimeTable))   %number of messages
        thisMsg = fNames{i};
        
%   read Cycle Time from database
        attInfo = attributeInfo(dataMat,'Message','GenMsgCycleTime',thisMsg);
        canAnalysis(i).CycleTimeDef = (attInfo.Value);
        attInfo = attributeInfo(dataMat,'Message','GenMsgSendType',thisMsg);
        canAnalysis(i).MsgSendTypeDef = (attInfo.Value);
 
 %read period times for each message
        dt = diff(signalTimeTable.(fNames{i}).Time); 
        %dt = unique(diff(lyftCtrlSigTable.(fNames{i}).Time)); 

        minValue = seconds(min(dt(dt>0)))*1000;
        canAnalysis(i).MinValue = minValue;
        %LyftCanAnalysis.(thisMsg)(2,2) = minValue; 
        
        maxValue = seconds(max(dt))*1000;
        canAnalysis(i).MaxValue = maxValue;
       
        meanValue = mean(dt);                                   %calculate mean
        canAnalysis(i).MeanValue = seconds(meanValue*1000);           %
        
        StdValue = std(dt);
        canAnalysis(i).StdValue = seconds(StdValue*1000);
        medianValue = median(dt);
        canAnalysis(i).MedianValue = seconds(medianValue*1000);
 
 %Compare Cycle time vs max and min. +-10 ms and place it on a field
        %msgCyclicX = attInfo.Value;
        %msgCyclicX = "cyclicX";
        if canAnalysis(i).MsgSendTypeDef == "cyclicX"
            
            cycleTmTol = 0.10;      %10% tolerance for calculus
            cycleTmMxTol=canAnalysis(i).CycleTimeDef+((canAnalysis(i).CycleTimeDef)*cycleTmTol);
            if maxValue > cycleTmMxTol
                canAnalysis(i).CycleTMxCmp = 'error';
            else
                canAnalysis(i).CycleTMxCmp = 'ok';
            end
        
            cycleTmMnTol=canAnalysis(i).CycleTimeDef-((canAnalysis(i).CycleTimeDef)*cycleTmTol);
            if minValue < cycleTmMnTol
                canAnalysis(i).CycleTMnCmp = 'error';
            else
                canAnalysis(i).CycleTMnCmp = 'ok';
            end            
            
        end

end