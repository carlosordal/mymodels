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

 %select .mat file
disp(['Select *.mat file for ',networkSel,' network that contains ccandb and can timetable'])
[matFile,matPath] = uigetfile('*.mat',['Select *.mat file for ',networkSel,' network that contains ccandb and can timetable']);                 %Open file selection dialog box
if isequal(matFile,0)
   disp('User selected Cancel')
   
else
   disp(['User selected ', fullfile(matPath, matFile)])
end

%Add Path
addpath(matPath);

    
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