function displayCanMsgOnConsole(canData, canId, timeStamp)
%DISPLAYMSGONCONSOLE
%This function take a CAN Message with 8 byte data lengh output and displays it on the diagnostic
%console

fprintf('%.5f', timeStamp);         % show timeStamp on diagnostic console
fprintf(' %X', canId);              % show canId on diagnostic console
for i = 1 : numel(canData)
    strData = canData(i);
    if i == numel(canData)
        fprintf(' %X\n', strData);  % show Byte on diagnostic console
    else
        fprintf(' %X', strData);    % show Byte on diagnostic console
    end
end   