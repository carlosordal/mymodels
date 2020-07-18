%IT REQUIRES MATLAB 2019b or newer and Vehicle Network Toolbox
%% This function takes a folder with blfs files and create matfiles with signal tables
% Next steps: 
% correct matfile needs to be saved
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
% networksAndChannels = {'ccan_rr.dbc',1;'lyftctrlcan.dbc',2};
% blfFolder =
% 'C:\Users\cordunoalbarran\Repo\mymodels\Matlab\CAN_blf_to_mat_converter\can_logs';
% dbcFolder = 'C:\Users\cordunoalbarran\Repo\avcampari\guv0_dbcs';
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


function can_blf_folder_to_mat_converter(networksAndChannels, dbcDirectory, blfDirectory)
    
% check Matlab version is newer than 2019b (9.7)

    checkMatlabVerion('matlab','9.7');
    checkPlatform('win64');   
    blfFolder = blfDirectory;
    addpath(dbcDirectory); 
    blfFilesList = dir(fullfile(blfFolder, '*.blf'));    
    % check if BLF files on the selected folder
    if isempty(blfFilesList)
        error('****** No BLF files found on selected folder, Please select a different folder');
    end    


    
    %% new loops for BLF Files and x networks
    for nBlfFiles=1 : numel(blfFilesList)   % blf loops
        thisFile = blfFilesList(nBlfFiles);
        disp(['- File conversion started: ', thisFile.name]);
        %initial matfile
        createSignalTableMatFile(thisFile, networksAndChannels);     
    end
    disp(['COMPLETED. Total BLF files converted: ',num2str(nBlfFiles)]);


    function createSignalTableMatFile(thisBlfFile, networksAndChannels)
        networks = size(networksAndChannels);
        rows = networks(1);
        networksNamesStr = '';
        canChannelsStr = '';
        for nNetworks=1 : rows % networks loop
            dbcFileName = networksAndChannels{nNetworks,1};
            networkName = dbcFileName(1:end-4);
            canCh = networksAndChannels{nNetworks,2};
            %load dbc as mat file
            canDb = canDatabase(dbcFileName);
            blfFile = fullfile(thisBlfFile.folder,'\', thisBlfFile.name);
            MsgTable = blfread(blfFile,canCh,'DataBase',canDb);        % convert blf to matlab data
            canLogSignalsTable.(networkName) = canSignalTimetable(MsgTable);   % Create struct that contains CAN signal timetable from CAN message timetable    
            networksNamesStr = strcat(networksNamesStr, '; ', num2str(dbcFileName));

            canChannelsStr = strcat(canChannelsStr, '; ', num2str(canCh));

        end
        networksNamesStr = networksNamesStr(2:end);
        canChannelsStr = canChannelsStr(2:end);
        %disp([networksNamesStr, ', ',canChannelsStr]);
        matFileName = thisBlfFile.name (1:end-4);
        save(fullfile(thisBlfFile.folder, matFileName),'canLogSignalsTable');              %stores ccan signal time table 
        % file conversion Completed message:
        disp(['-- File conversion completed: CAN database/networks: [', networksNamesStr, '], Channels Numbers: [', canChannelsStr,']']);

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
