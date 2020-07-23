function diagnosticRequest = generateDiagnosticRequest()
%GENERATEDIAGNOSTICREQUEST
%This function generate vectors for diagnostics request


D_RQ_CC = canMessage(hex2dec('7A7'), false, 8);
%D_RS_CC = canMessage(hex2dec('7AF'), false, 8);

%     % Create a CAN channel on which to transmit.
%     txCh = canChannel('MathWorks', 'Virtual 1', 1);
%     % Register each message on the channel at a specified periodic rate.
%     transmitPeriodic(txCh, msgTx100, 'On', 0.500);
    for ii = 1:1000
        % Increment the message data bytes.
        D_RQ_CC.Data = D_RQ_CC.Data + 1;
%         msgTx200.Data = msgTx200.Data + 1;
%         msgTx400.Data = msgTx400.Data + 1;
%         msgTx600.Data = msgTx600.Data + 1;
%         msgTx800.Data = msgTx800.Data + 1;
        diagnosticRequest = D_RQ_CC;
        % Wait for a time period.
        pause(0.5);
    end


