%IT REQUIRES MATLAB 2019b and Vehicle Network Toolbox
%This function takes a blf file and create matfiles channel by channel.
% it needs user input to select the dbcs and file channels.

% Next steps: save all blfs in one folder and convert all the blfs files on
% that folder for the same can channel.
% fix the candb file that is empty.
% make the function more flexible,
% how many channels?
% select DBC per channel.


% NOTE: it needs Vehicle Network Toolbox and Matlab 2019b or newer
%this Script ONLY takes a can log on blf format, dbcs files and convert the
%can log into struct with time tables for each signal and can databases
% **** dbcs should be stored on a specific defined location.

%Inputs
% CAN DBCS should be stored with the same names as avcampari and defined
% location.
% blf CAN log file, channels need to be identified
% enter channel # for ccan and lyftctrl
% Can Data base file onn .dbc format

%Outputs
% Time table saved as *.mat file on the same directory as the blf file 
%using the blf file name + CAN-Channel-selected

%Reference for BU CAN data logger:
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
        'ccan_rr', 'lyftctrlcan', 'eptcan', 'ccan_rr');
    

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
%guDbcPath = fullfile('C:\Users\cordunoalbarran\Documents\Repo\avcampari\GUv0 DBCs');
guDbcPath = fullfile('C:\Users\cordunoalbarran\Repo\avcampari\guv0_dbcs');
eptDbcPath = fullfile('C:\Users\cordunoalbarran\Repo\avcampari\guv0_dbcs');

addpath(guDbcPath);
addpath(eptDbcPath);
addpath(blfPath);
%% load dbcs and create time tables for logs
%load ccan.dbc and convert CCAN canlog into struct with timetables
candbSel = lower([networkSel,'.dbc']);

%save variables with proper network name and matfiles

switch networkSel
    case 'ccan_rr' 
        ccandb = canDatabase(candbSel);
        ccanMsgTable = blfread(blfFile,canCh,'DataBase',ccandb);        % convert blf to matlab data
        ccanLogSigTable = canSignalTimetable(ccanMsgTable);             %
        % save ccan Sigal Table into a mat file
        matFile = strcat(networkSel,'Data.mat');                        %create string net+Data
        save(fullfile(blfPath,matFile),'ccanLogSigTable');              %stores ccan signal time table 

    case 'lyftctrlcan'
        lyftcandb = canDatabase(candbSel);
        lyftcanMsgTable = blfread(blfFile,canCh,'DataBase',lyftcandb);
        lyftcanLogSigTable = canSignalTimetable(lyftcanMsgTable);
        % save ccan Sigal Table into a mat file
        matFile = strcat(networkSel,'Data.mat');
        %canSignTable = strcat(answer,'Data.mat');
        save(fullfile(blfPath,matFile),'lyftcanLogSigTable');           %stores ccan signal time table 
    case 'eptcan'
        eptcandb = canDatabase(candbSel);
        eptcanMsgTable = blfread(blfFile,canCh,'DataBase',eptcandb);
        eptcanLogSigTable = canSignalTimetable(eptcanMsgTable);
        % save ccan Sigal Table into a mat file
        matFile = strcat(networkSel,'Data.mat');
        %canSignTable = strcat(answer,'Data.mat');
        save(fullfile(blfPath,matFile),'eptcanLogSigTable');            %stores ccan signal time table  
        
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
disp(['COMPLETED!. *.mat files created and saved for channel: ', num2str(canCh),', using CAN dabase: ', networkSel]);
