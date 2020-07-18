%IT REQUIRES MATLAB 2019b or newer and Vehicle Network Toolbox
%% This function takes a folder with blfs files and create matfiles with signal tables
% Next steps: 
% convert more than 2 networks on a single mat file
% remove this_folder and crete the file directly on the blf files.
% add checks for network name and DBC file names match
% is it possible to create different channels from the same Msg Table? 
% add inputs check, for only known networks.
% fix the candb file that is empty.
% Inputs:   1) networksAndChannels  - x*2 cell including network name and channel numnber.
%                                       {<'network name'>,<channel Number>}
%                                       network Name should match networks
%                                       stored on dbcFolder
%           2) dbcDirectory         - Directory of the dbcs. DBC file names
%                                       should match network name on
%                                       networkAndChannels cell input.
%           3) blfDirectory         - Directory of blfs that will be converted   
%
% Outputs:  1) Matfiles stored on the blf folder.

% Example:
% networksAndChannels = {'ccan_rr',1;'lyftctrlcan',2};
% blfFolder = 'C:\Users\cordunoalbarran\Repo\mymodels\Matlab\CAN_blf_to_mat_converter\can_logs'
% dbcFolder = 'C:\Users\cordunoalbarran\Repo\avcampari\guv0_dbcs'
% can_blf_to_mat_converter(networksAndChannels, dbcFolder, blfFolder)
%
% Reference for BU CAN data logger:
% Golden Unicorn CAN Channels:
% Ch1 : CAN L5 Power
% Ch2: CAN L5 Ctrl
% Ch3: CAN/Ethernet
% Ch4: CAN C
% Ch5: CAN ePT
% Ch6: CAN C - isolated
% Ch7: CAN ePT - isolated


function can_blf_to_mat_converter(networksAndChannels, dbcDirectory, blfDirectory)
    
% check Matlab version is newer than 2019b (9.7)

    checkMatlabVerion('matlab','9.7');
    checkPlatform('win64')   
    
    networks = size(networksAndChannels);
    rows = networks(1);

    for i=1 : rows
        %disp([networksAndChannels{i,1},', ', num2str(networksAndChannels{i,2})]);
        networkSel = networksAndChannels{i,1};
        canCh = networksAndChannels{i,2};

        %% DBCs Path definition (avcampari dir)
        this_folder = fileparts(mfilename('fullpath'));   
        addpath(dbcDirectory);

        blfFolder = blfDirectory;
        files = dir(fullfile(blfFolder, '*.blf'));
        %load dbc
        candbSel = lower([networkSel,'.dbc']);

        if ~isempty(files)

            for j=1 : numel(files)   %file list
                thisFile = files(j);
                disp(['File conversion started: ', thisFile.name]);
                %disp(['File Name: ', thisFile.name]);
                % load dbcs and create time tables for logs


                %convert CAN canlog into struct with timetables and save
                %initial matfile
                matFile = createSignalTableMatFile(thisFile, candbSel, canCh, networkSel, this_folder);

                % Rename Mat file similar to blf filename plus network and save it on blf
                % folder

                oldFilename = fullfile(this_folder, matFile);
                [~, baseFileName, ~] = fileparts(fullfile(thisFile.folder, thisFile.name));
                noSpaceName =  regexprep(baseFileName, ' ', '_');
                newFilename = strcat(noSpaceName,'_',matFile);
                newFilename = fullfile(thisFile.folder,'\', newFilename);
                movefile( oldFilename, newFilename );

                %% Process Complete message:
                disp(['------File Converted, CAN database/network: ', networkSel, ', BLF Channel: ', num2str(canCh), ', Name: ', thisFile.name]);

            end           
        else
            disp(['****** No BLF files on selected folder, Please select a different folder']);
        end        
    end
    disp(['COMPLETED. Total BLF files converted: ',num2str(i)]);


    function matFile = createSignalTableMatFile(thisFile, candbSel, canCh, networkSel, blfPath)
            db = canDatabase(candbSel);
            blfFile = fullfile(thisFile.folder,'\', thisFile.name);
            MsgTable = blfread(blfFile,canCh,'DataBase',db);        % convert blf to matlab data
            SignalTable = canSignalTimetable(MsgTable);             % Create CAN signal timetable from CAN message timetable
            % save Sigal Table into a mat file
            matFile = strcat(networkSel,'_DATA.mat');                        %create string net+Data
           % structName = strcat(networkSel,'LogSigTable');
            save(fullfile(blfPath,matFile),'SignalTable');              %stores ccan signal time table 
    end
    function checkMatlabVerion(tool, version)
        if verLessThan(tool,version)    
            matlabVer = ver;
            table = struct2table(matlabVer);
            rows = height(table);
            for i = 1: rows
                thisApp = char(table{i,1});
                if isequal(thisApp, 'MATLAB')
                    matlabVersion = char(table{i,2});
                    matlabRelease = char(table{i,3});
                    %disp(['matlab Version: ', matlabVersion, ', Release:', matlabRelease])
                end
            end
            error(['Matlab 9.7 (release: 2019b) or higher is required. Your Matlab version is: ', matlabVersion, ', Release: ' , matlabRelease])
        end
    end
    function checkPlatform(platformExpected)
%       Inputs: PlatformExpected
%           'win64' - 64-bit Windows platform
%           'glnxa64' - 64-bit Linux platform
%           'maci64' - 64-bit macOS platform
        if (computer('arch') ~= platformExpected)
            error('This functions only runs on Windows')
        end
    end
end
