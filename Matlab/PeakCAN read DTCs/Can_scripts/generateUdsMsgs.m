function generateUdsMsgs()
% generateMsgs Creates and transmits CAN messages for demo purposes.
%
%   generateMsgs periodically transmits multiple CAN messages at various
%   periodic rates with changing message data.
%

% Copyright 2008-2016 The MathWorks, Inc.

    % Create the messages to send using the canMessage function. The 
    % identifier, an indication of standard or extended type, and the data
    % length is given for each message.
    ccDiagnosticRequest = canMessage(hex2dec('7A7'), false, 8);
    pcmDiagnositcRequest = canMessage(hex2dec('7E0'), false, 8);

    % Create a CAN channel on which to transmit.
% %% Which CAN channel will be converted
% diagnosticSel = questdlg('Select CAN HW', ...
%         'Select CAN HW', ...
%         'virtual', 'PCAN','virtual');
% 
%  switch diagnosticSel
%     case 'virtual' 
         txCh = canChannel('MathWorks', 'Virtual 1', 1);
%     case 'PCAN' 
%         txCh = canChannel('PEAK-System', 'PCAN_USBBUS1');
%         configBusSpeed(txCh, 500000);
%         %get(r\txCh)
%     otherwise
%         warning('Unexpected error')
    
%     % Register each message on the channel at a specified periodic rate.
%     transmitPeriodic(txCh, msgTx100, 'On', 0.500);
%     transmitPeriodic(txCh, msgTx200, 'On', 0.250);
%     transmitPeriodic(txCh, msgTx400, 'On', 0.125);
%     transmitPeriodic(txCh, msgTx600, 'On', 0.050);
%     transmitPeriodic(txCh, msgTx800, 'On', 0.025);
 
%   Example:
    %       msg = canMessage(500, false, 8)
    %       msg.Data = [45 213 53 1 3 213 123 43]
    %       ch = canChannel('Vector', 'CANCaseXL 1', 1)
    %       start(ch)
    %       transmit(ch, msg)    

    % Start the CAN channel.
    start(txCh);
    
    % Run for several seconds incrementing the message data regularly.
    for ii = 1:50
        % Increment the message data bytes.
        ccDiagnosticRequest.Data = ccDiagnosticRequest.Data + 1;
        transmit(txCh, ccDiagnosticRequest); 
        filterAllowOnly(txCh, 1959, 'Standard');
        % Wait for a time period.
        pause(0.200);
    end

    % Stop the CAN channel.
    stop(txCh);
%     rxMsg = receive(txCh, Inf, 'OutputFormat', 'timetable');
% rxMsg(1:25, :)
end