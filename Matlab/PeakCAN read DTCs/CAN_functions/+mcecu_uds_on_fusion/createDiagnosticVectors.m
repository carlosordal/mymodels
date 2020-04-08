function diagnosticRequest = createDiagnosticVectors()
% CREATEDIAGNOSTICVECTORS
%This function generate vectors for diagnostics request

diagnostics = [ uint8([2 62 0   0   0   0 0 0]); ...    %testerPresent   =   02 3E 00
                uint8([3 34 241 140 0   0 0 0]); ...   %serialNumber    =   03 22 F1 8C    
                uint8([3 25 02  13  0   0 0 0]); ...   %readDtc         =   03 19 02 0D
                uint8([4 14 255 255 255 0 0 0]); ...    %clearDtc        =   04 14 FF FF FF
                uint8([2 34 241 136 0   0 0 0]); ...    %readSW          =   %03 22 F1 88
                uint8([2 17 1   0   0   0 0 0])];   %ecuReset        =   02 11 01];        

% %% Which CAN channel will be converted
% diagnosticSelection = questdlg('Which Diag request?', ...
%         'Choose Diagnostic Request', ...
%         'tester_present', 'ecu Reset', 'tester_present');

for i=1 : size(diagnostics,1)
    diagnosticRequest = diagnostics(i,:);
    mcecu_uds_on_fusion.displayCanMsgOnConsole(diagnosticRequest, uint32(1959), i);
    pause(0.400);
    
end
end