function diagnosticRequest = createDiagnosticVectors(timeStamp)
% CREATEDIAGNOSTICVECTORS
%This function generate vectors for diagnostics request

diagnostics = [ uint8([3 34 241 140 0   0 0 0]); ...   %serialNumber    =   03 22 F1 8C    
                uint8([3 25 02  13  0   0 0 0]); ...   %readDtc         =   03 19 02 0D
                uint8([4 14 255 255 255 0 0 0]); ...    %clearDtc        =   04 14 FF FF FF
                uint8([2 34 241 136 0   0 0 0]); ...    %readSW          =   %03 22 F1 88
                uint8([2 17 1   0   0   0 0 0])];   %ecuReset        =   02 11 01];        

% %% Which CAN channel will be converted
% diagnosticSelection = questdlg('Which Diag request?', ...
%         'Choose Diagnostic Request', ...
%         'tester_present', 'ecu Reset', 'tester_present');
persistent vectors_counter;
persistent previous_time_stamp;

% Initialization
%if timeStamp == 0
%if isempty(previous_time_stamp)
%if isempty(vectors_counter)
    vectors_counter = 1;
    previous_time_stamp = 0;
    diagnosticRequest = uint8([2 62 0 0 0 0 0 0]);  %tester present 02 3E 0
%end



%set_param(bdroot, 'SimulationCommand', 'stop');


% for i=1 : size(diagnostics,1)
if timeStamp > previous_time_stamp
    vectors_counter = vectors_counter + 1;
    previous_time_stamp = timeStamp;
    diagnosticRequest = diagnostics(vectors_counter,:);
    mcecu_uds_on_fusion.displayCanMsgOnConsole(diagnosticRequest, uint32(1959), timeStamp);
elseif timeStamp == previous_time_stamp   
    diagnosticRequest = diagnostics(vectors_counter,:);
    mcecu_uds_on_fusion.displayCanMsgOnConsole(diagnosticRequest, uint32(1959), timeStamp);
end
% 
%     
% end
end