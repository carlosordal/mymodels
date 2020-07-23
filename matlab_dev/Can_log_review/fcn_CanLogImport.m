function [ccanSigTable, lyftctrlSigTable, eptSigTable] = fcn_CanLogImport(ccanCh, ccanDbc, lyftctrlCh, lyftctrlDbc, eptCh, eptDbc, BlfCanLog)
% CANLOGIMPORT - This Function import a 3 Channel CAN Log with BLF format 
%into matlab workspace. It creates a time table for each CAN channel/signal.
%
% Inputs:
% (1) ccanCh        - C-CAN Channel on BLF file.
% (2) ccanDbc       - C-CAN DBC file name.
% (3) lyftctrlCh    - Lyft Control CAN Channel on BLF file.
% (4) lyftctrlDbc   - Lyft Control CAN DBC file name
% (5) eptCh         - ePT Channel on BLF file
% (6) eptDbc        - ePT DBC file name
% (7) BlfCanLog     - Can log file name on BLF format
%
% Outputs: 
% (1) ccanSigTable              - Signal table output
% (2) lyftctrlSigTable          - Signal table output
% (3) eptSigTable               - Signal table output






ccandb = canDatabase(ccanDbc);
ccanMsgTable = blfread(BlfCanLog,ccanCh,'DataBase',ccandb);
ccanSigTable = canSignalTimetable(ccanMsgTable);

lyftctrldb = canDatabase(lyftctrlDbc);
lyftctrlMsgTable = blfread(BlfCanLog,lyftctrlCh,'DataBase',lyftctrldb);
lyftctrlSigTable = canSignalTimetable(lyftctrlMsgTable);

eptdb = canDatabase(eptDbc);
eptMsgTable = blfread(BlfCanLog,eptCh,'DataBase',eptdb);
eptSigTable = canSignalTimetable(eptMsgTable);

end
