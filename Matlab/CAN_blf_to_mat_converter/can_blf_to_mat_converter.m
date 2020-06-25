%IT REQUIRES MATLAB 2019b or newer and Vehicle Network Toolbox
%% This function takes a folder with blfs files and create matfiles with 
% signal tables for 1 network/channel at a time
% *** dbcs uses avcampari names and the location is part of the function.

% Next steps: 
% fix the candb file that is empty.
% make the function more flexible, convert 2 or more channels at the same
% time
% select DBC per channel.

%Inputs:    1) network_a    - Network Name (ccan_rr, ccan_nrr, lyftctrlcan, eptcan)
%           2) channel_a    - Channel number on the blf file
%           3) dbcDirectory - Directory of the dbcs. Same names as avcampari. ('C:\Users\cordunoalbarran\Repo\avcampari\guv0_dbcs')    
%Outputs:    1) Matfiles stored on the blf folder.


%Reference for BU CAN data logger:
%Golden Unicorn CAN Channels:
% Ch1 : CAN L5 Power
% Ch2: CAN L5 Ctrl
% Ch3: CAN/Ethernet
% Ch4: CAN C
% Ch5: CAN ePT
% Ch6: CAN C - isolated
% Ch7: CAN ePT - isolated


function can_blf_to_mat_converter(network_a, channel_a, dbcDirectory)
    networkSel = network_a;
    canCh = channel_a;
    %% DBCs Path definition (avcampari dir)
    this_folder = fileparts(mfilename('fullpath'));   
    addpath(dbcDirectory);

    
    % Script to select folder and print blf files
    this_folder = fileparts(mfilename('fullpath')); 
    directory = uigetdir(this_folder, 'Select Folder with BLF files');
    files = dir(fullfile(directory, '*.blf'));
    %load dbc
    candbSel = lower([networkSel,'.dbc']);

    if ~isempty(files)
        for i=1 : numel(files)   %file list
            thisFile = files(i);
            %disp(['File Name: ', thisFile.name]);
            % load dbcs and create time tables for logs


            %convert CAN canlog into struct with timetables and save
            %initial matfile
            matFile = createSignalTableMatFile(thisFile.name, candbSel, canCh, networkSel, this_folder);

            % Rename Mat file similar to blf filename plus network and save it on blf
            % folder

            oldFilename = fullfile(this_folder, matFile);
            [~, baseFileName, ~] = fileparts(fullfile(thisFile.folder, thisFile.name));
            noSpaceName =  regexprep(baseFileName, ' ', '_');
            newFilename = strcat(noSpaceName,'_',matFile);
            newFilename = fullfile(thisFile.folder,'\', newFilename);
            movefile( oldFilename, newFilename );

            %% Process Complete message:
            disp(['File Converted, CAN database/network: ', networkSel, ', BLF Channel: ', num2str(canCh), ', Name: ', thisFile.name]);

        end
        disp(['COMPLETED. Total BLF files converted: ',num2str(i)]);
    else
        disp(['****** No BLF files on selected folder, Please select a different folder']);
    end



    function matFile = createSignalTableMatFile(blfFile, candbSel, canCh, networkSel, blfPath)
            db = canDatabase(candbSel);
            MsgTable = blfread(blfFile,canCh,'DataBase',db);        % convert blf to matlab data
            SignalTable = canSignalTimetable(MsgTable);             %
            % save Sigal Table into a mat file
            matFile = strcat(networkSel,'_DATA.mat');                        %create string net+Data
           % structName = strcat(networkSel,'LogSigTable');
            save(fullfile(blfPath,matFile),'SignalTable');              %stores ccan signal time table 
    end
end
