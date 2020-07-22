%Requirements:
% - Vehicle Network Toolbox Version 4.3 or higher
% - Matlab 2019b Version 9.7 or higher
% - Windows Platform.
%% This function takes a folder with blfs files and create matfiles with signal tables
%
% Inputs:   1) networksAndChannels  - x*2 cell including network name and channel numnber.
%                                       {<'dbc & network name A'>,<channel number A>;
%                                       {<'dbc & network name B'>,<channel number B>;}
%                                       network Name should match dbc files
%                                       stored on dbcDirectory
%           2) dbcDirectory         - Directory of the dbcs. DBC file names
%                                       should match network name on
%                                       networkAndChannels cell input.
%           3) blfDirectory         - Directory of blfs that will be converted   
%
% Outputs:  1) Matfiles stored on the blf folder.

% Example:
% networksAndChannels = {'ccan_rr.dbc',4;'lyftctrlcan.dbc',2};
% blfFolder = 'G:\Shared drives\Vehicle Controls\[05] - Vehicle Platforms\Chrysler Pacifica\GUv0 AEB Testing-docs\1211 AEB weeks testing';
% dbcFolder = 'C:\Users\cordunoalbarran\Repo\avcampari\guv0_dbcs';
% can_blf_folder_to_mat_converter(networksAndChannels, dbcFolder, blfFolder)
%
% Reference for GU CAN data logger BLF channels:
% Golden Unicorn CAN Channels:
% Ch1: CAN L5 Power
% Ch2: lyftctrlcan.dbc
% Ch3: CAN/Ethernet
% Ch4: ccan_rr.dbc
% Ch5: eptcan.dbc
% Ch6: ccan_rr.dbc - isolated
% Ch7: eptcan.dbc - isolated


function can_blf_folder_to_mat_converter(networksAndChannels, dbcDirectory, blfDirectory)
    
    % check Vehicle Network Toolbox is equal or higher than 4.3
    isToolVersionLessThan('vnt', '4.3', 'Vehicle Network Toolbox 4.3 or higher is required');
    % check Matlab version is equal or higher than 2019b (9.7)
    isToolVersionLessThan('matlab', '9.7', 'Matlab 2019b 9.7 or higher is required');
    checkPlatform('win64');   
    blfFolder = blfDirectory;
    addpath(dbcDirectory);
    % check if folder contains blf and create a list
    fileExtension = '*.blf';
    blfFilesList = createFileList(blfFolder, fileExtension);
    
    % check if folder contains blf and create a list
    fileExtension = '*.dbc';
    dbcFilesList = createFileList(dbcDirectory, fileExtension);
    compareDbcRequestedToFilesOnFolder(networksAndChannels, dbcFilesList)
    
    
    %% loop for BLF Files and x networks
    for nBlfFiles=1 : numel(blfFilesList)   % blf loops
        thisFile = blfFilesList(nBlfFiles);
        disp(['* File conversion started: ', thisFile.name]);
        %initial matfile
        createSignalTableMatFile(thisFile, networksAndChannels);     
    end
    disp(['*** COMPLETED. Total BLF files converted: ',num2str(nBlfFiles)]);

%% Functions
    function createSignalTableMatFile(thisBlfFile, networksAndChannels)
        networks = size(networksAndChannels);
        rows = networks(1);
        networksNamesStr = '';
        canChannelsStr = '';
        for nNetworks=1 : rows % networks loop
            dbcFileName = networksAndChannels{nNetworks,1};
            networkName = dbcFileName(1:end-4);
            logName = strcat(networkName, '_log');
            canCh = networksAndChannels{nNetworks,2};
            %load dbc as mat file
            canDb = canDatabase(dbcFileName);
            blfFile = fullfile(thisBlfFile.folder,'\', thisBlfFile.name);
            MsgTable = blfread(blfFile,canCh,'DataBase',canDb);        % convert blf to matlab data
            canLogSignalsTable.(logName) = canSignalTimetable(MsgTable);   % Create struct that contains CAN signal timetable from CAN message timetable    
            disp(['-- Mat file created for network: [', num2str(dbcFileName), '], Channel Number: [', num2str(canCh),']']);
            networksNamesStr = strcat(networksNamesStr, '; ', num2str(dbcFileName));
            canChannelsStr = strcat(canChannelsStr, '; ', num2str(canCh));
            
        end
        networksNamesStr = networksNamesStr(2:end);
        canChannelsStr = canChannelsStr(2:end);
        %disp([networksNamesStr, ', ',canChannelsStr]);
        matFileName = thisBlfFile.name (1:end-4);
        save(fullfile(thisBlfFile.folder, matFileName),'canLogSignalsTable');              %stores ccan signal time table 
        % file conversion Completed message:
        disp(['--- File conversion completed: CAN database/networks: [', networksNamesStr, '], Channels Numbers: [', canChannelsStr,']']);

    end


    function isToolVersionLessThan(toolExpected, versionExpected, errorMessage)
        if verLessThan(toolExpected, versionExpected)    
            error(errorMessage)
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

    function filesList = createFileList(Folder, fileExtension)
        % creates file list and trigger an error if files are not found
        filesList = dir(fullfile(Folder, fileExtension));
        % check if *.fileExtension files on the selected folder
        if isempty(filesList)
            error([fileExtension, ' files NOT found on selected folder, Please select a different folder']);
        end
    end

    function compareDbcRequestedToFilesOnFolder(networksAndChannels, dbcFilesList)
        networksInputs = size(networksAndChannels);
        rows = networksInputs(1);
        for nNetworksInputs=1 : rows % networks loop
            dbcFileInput = convertCharsToStrings(networksAndChannels{nNetworksInputs,1});
            for nDbcFiles=1:  numel(dbcFilesList)   % dbcs on Folder Loop
                dbcFileOnFolder = convertCharsToStrings(dbcFilesList(nDbcFiles).name);
                if dbcFileInput == dbcFileOnFolder
                    isFileFound = true;
                    break
                else
                    isFileFound = false;
                end            
            end
            if ~isFileFound
                error(['Network/dbc input ', char(dbcFileInput), ', not found on dbc folder. Update dbc file name input or select a different folder']);          
            end
        end
    end

end
