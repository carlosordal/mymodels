%this Script ONLY takes a can log on blf format, dbcs files and convert the
%can log into struct with time tables for each signal and can databases
%dbcs should be stored on a specific defined location.

%Inputs
% blf CAN log file, channels need to be identified
% enter channel # for ccan and lyftctrl
% Can Data base file onn .dbc format


%Golden Unicorn CAN Channels:
% Ch1 : CAN L5 Power
% Ch2: CAN L5 Ctrl
% Ch3: CAN/Ethernet
% Ch4: CAN C
% Ch5: CAN ePT
% Ch6: CAN C - isolated
% Ch7: CAN ePT - isolated

clear;

%% Which CAN channel will be converted
networkSel = questdlg('Which CAN network will be converted?', ...
        'Choose CAN Network', ...
        'cCAN', 'lyftCtrlCAN', 'ePtCAN', 'cCAN');
    

%% Define script inputs

%select blf file
disp('Select CanLog file with blf format')
[blfFile,blfPath] = uigetfile('*.blf','Select CanLog file with blf format');                 %Open file selection dialog box
if isequal(blfFile,0)
   disp('User selected Cancel')
   
else
   disp(['User selected ', fullfile(blfPath, blfFile)])
end

%Assign CAN Channels
prompt = (['What''s the ' networkSel ' Channel # on blf file? ']);
canCh      = input(prompt);                                     %can channel to be used

%% Path definition
this_folder = fileparts(mfilename('fullpath'));   
guDbcFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari\GUv0 DBCs');
eptDbcFolder = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari');

addpath(guDbcFolder);
addpath(eptDbcFolder);
addpath(blfPath);
%% load dbcs and create time tables for logs
%load ccan.dbc and convert CCAN canlog into struct with timetables
candbSel = lower([networkSel,'.dbc']);

%save variables with proper network name and matfiles

switch networkSel
    case 'cCAN' 
        ccandb = canDatabase(candbSel);
        ccanMsgTable = blfread(blfFile,canCh,'DataBase',ccandb);
        ccanSigTable = canSignalTimetable(ccanMsgTable);
        % save ccan Sigal Table into a mat file
        matFile = strcat(networkSel,'Data.mat');
        %canSignTable = strcat(answer,'Data.mat');
        save(fullfile(blfPath,matFile),'ccanSigTable','ccandb');     %stores ccan signal table and ccan database 

    case 'lyftCtrlCAN'
        lyftcandb = canDatabase(candbSel);
        lyftcanMsgTable = blfread(blfFile,canCh,'DataBase',lyftcandb);
        lyftcanSigTable = canSignalTimetable(lyftcanMsgTable);
        % save ccan Sigal Table into a mat file
        matFile = strcat(networkSel,'Data.mat');
        %canSignTable = strcat(answer,'Data.mat');
        save(fullfile(blfPath,matFile),'lyftcanSigTable','lyftcandb');     %stores ccan signal table and ccan database 
    case 'ePtCAN'
        eptcandb = canDatabase('E4A_R4_CCAN3_CR11690_Mod.dbc');
        eptcanMsgTable = blfread(blfFile,canCh,'DataBase',eptcandb);
        eptcanSigTable = canSignalTimetable(eptcanMsgTable);
        % save ccan Sigal Table into a mat file
        matFile = strcat(networkSel,'Data.mat');
        %canSignTable = strcat(answer,'Data.mat');
        save(fullfile(blfPath,matFile),'eptcanSigTable','eptcandb');     %stores ccan signal table and ccan database 
        
    otherwise
        warning('Unexpected Network name.')
end



%% Rename Mat file similar to blf filename plus network and save it on blf
% folder

oldFilename = fullfile(blfPath, matFile);
[folder, baseFileName, extension] = fileparts(fullfile(blfPath, blfFile));
noSpaceName =  regexprep(baseFileName, ' ', '_');
newFilename = strcat(noSpaceName,'_',matFile);
newFilename = fullfile(blfPath, newFilename);
movefile( oldFilename, newFilename );

%% Process Complete message:
disp(['.mat files created and saved for channel: ', num2str(canCh),', using CAN dabase: ', networkSel]);
