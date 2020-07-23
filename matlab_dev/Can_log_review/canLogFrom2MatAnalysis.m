%this Script takes a Signal time table and a database file 
%in order to calculate some statistics of the CAN network 


clear;
%Inputs
%select can log file with Signal Timetable *.mat
disp('Select mat file with signal Table')
[logFile,logPath] = uigetfile('*.mat','Select CanLog file with .mat format');                 %Open file selection dialog box
if isequal(logFile,0)
   disp('User selected Cancel')
   
else
   disp(['User selected ', fullfile(logPath, logFile)])
end

%select can database file with Signal Timetable *.mat
disp('Select mat file with databse .mat format')
[dbFile,dbPath] = uigetfile('*.mat','Select databse file with .mat format');                 %Open file selection dialog box
if isequal(dbFile,0)
   disp('User selected Cancel')
   
else
   disp(['User selected ', fullfile(dbPath, dbFile)])
end

%Add Path
addpath(logPath);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%C CAN statistics comparison
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%load can database
[folder, baseFileName, extension] = fileparts(fullfile(dbPath, dbFile));
databaseMat = load(dbFile);
databaseMat = databaseMat.(baseFileName);


%load Signal Time Tables
[folder, baseFileName, extension] = fileparts(fullfile(logPath, logFile));
signalTimeTable = load(logFile);
signalTimeTable = signalTimeTable.(baseFileName);

fNames = fieldnames(signalTimeTable);
canAnalysis = struct('message',fNames);     %create struct with messages on can log
for i = 1:numel(fieldnames(signalTimeTable))   %number of messages
        thisMsg = fNames{i};
        
%   read Cycle Time from database
        attInfo = attributeInfo(databaseMat,'Message','GenMsgCycleTime',thisMsg);
        canAnalysis(i).CycleTimeDef = (attInfo.Value);
        attInfo = attributeInfo(databaseMat,'Message','GenMsgSendType',thisMsg);
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




