rxCh = canChannel('MathWorks', 'Virtual 1', 1);
get(rxCh);
start(rxCh);
generateMsgs();
rxMsg = receive(rxCh, Inf, 'OutputFormat', 'timetable');

rxMsg(1:100, :)