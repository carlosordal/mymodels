%IT REQUIRES MATLAB 2019b or newer and Vehicle Network Toolbox
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
% networksAndChannels = {'ccan_rr.dbc',1;'lyftctrlcan.dbc',2};
% blfFolder = 'C:\Users\cordunoalbarran\Repo\mymodels\Matlab\CAN_blf_to_mat_converter\can_logs';
% dbcFolder = 'C:\Users\cordunoalbarran\Repo\avcampari\guv0_dbcs';
% can_blf_folder_to_mat_converter(networksAndChannels, dbcFolder, blfFolder)
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


function can_blf_folder_to_mat_converter(networksAndChannels, dbcDirectory, blfDirectory)
    
% check Matlab version is newer than 2019b (9.7)

    checkMatlabVerion('matlab','9.7');
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
    
    
    %% new loops for BLF Files and x networks
    for nBlfFiles=1 : numel(blfFilesList)   % blf loops
        thisFile = blfFilesList(nBlfFiles);
        disp(['* File conversion started: ', thisFile.name]);
        %initial matfile
        createSignalTableMatFile(thisFile, networksAndChannels);     
    end
    disp(['*** COMPLETED. Total BLF files converted: ',num2str(nBlfFiles)]);


    function createSignalTableMatFile(thisBlfFile, networksAndChannels)
        networks = size(networksAndChannels);
        rows = networks(1);
        networksNamesStr = '';
        canChannelsStr = '';
        for nNetworks=1 : rows % networks loop
            dbcFileName = networksAndChannels{nNetworks,1};
            networkName = dbcFileName(1:end-4);
            logName = strcat(networkName, '_can_log');
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
