clear
%% Path definition
this_folder = fileparts(mfilename('fullpath'));                             
addpath(genpath(fullfile(this_folder, 'canLogData')));                             
%addpath(genpath(fullfile(this_folder, '..', '..', 'common')));

GuDbFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari\GUv0 DBCs');
eptDbFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari');


addpath(GuDbFolder);
addpath(eptDbFolder);

%import dbc file into cell
lyftcanfile = importdata('lyftctrlcan.dbc');


%create cell array with message list
k = 1;
messagelist (1,1:7) = {'msg def','id dec','frame Name', 'length', 'source', 'id hex', 'cycle time'};
for j = 1:length(lyftcanfile)
    thiscellcontent = lyftcanfile(j,1);
    if startsWith(thiscellcontent,'BO_')
        k = k + 1;
        messagelist(k,1) = thiscellcontent;
        messagelist (k,1:5) = transpose(split(messagelist(k,1)));
        messagelist (k,6) = num2cell(dec2hex(str2double(messagelist(k,2))),[1 2]);
        
    end
end

%add cycle time to messagelist
for m = 1:length(lyftcanfile)
    thiscellcontent = lyftcanfile(m,1);
    if startsWith(thiscellcontent,'BA_ "GenMsgCycleTime" BO_ ')
        CycleTimeInfo = split(thiscellcontent);
        CycleTimeID = CycleTimeInfo(4,1);
        CycleTimeMs = CycleTimeInfo(5,1);      
        
        IDmessage = messagelist(2,2);

        for n = 1:length(messagelist)
            if isequal(messagelist(n,2),CycleTimeID)
                messagelist(n,7) = CycleTimeMs;
            end
        end
    
    end   
    
end

%split message list information
% for i=2:length(messagelist)
%     messagelist (i,1:5) = transpose(split(messagelist(i,1)));
% 
% end

%message definition
%BO_ 1758 APPL_ECU_OCM: 8 DIAGNOST
%cycle time definition
%BA_ "GenMsgCycleTime" BO_ 1758 0;
% BA_ "GenMsgCycleTime" BO_ 838 1000;
% BA_ "GenMsgCycleTime" BO_ 168 10;

%[ccanSigTable, lyftctrlSigTable, eptSigTable] = fcn_CanLogImport(1,'ccan.dbc',2,'lyftctrlcan.dbc',3,'E4A_R4_CCAN3_CR11690_Mod.dbc','P003 AEB weeks 10 km_test.blf');

%LyftCtrlCAN statistics

% fNames = fieldnames(lyftctrlSigTable);
% for i = 1:numel(fieldnames(lyftctrlSigTable)) 
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






