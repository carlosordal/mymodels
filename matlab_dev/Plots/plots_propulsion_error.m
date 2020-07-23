% Plots for Modules disengagement error
epsaEngagedState_ccan = SignalTable.EPS_SDS_Resp.EPS_SDSTorqueOverlayIntActivated;
epsaTime = SignalTable.EPS_SDS_Resp.Time;
cbcEngagedState_ccan = SignalTable.SDS_CBC_STAT.CBC_OVERLAY_MODE;
cbcTime = SignalTable.SDS_CBC_STAT.Time;
figure
hold on % allow all vectors to be plotted in same
 % figure
rowsOnPlot = 4;
ebcmEngagedState_ccan = SignalTable.EBCM_C1.SDS_Engaged_State_EBCM;
ebcmTime = SignalTable.EBCM_C1.Time;
ebcmEngageRequest_ccan = SignalTable.DAS_A3_A.SDS_Engaged_State;
dasA3ATime = SignalTable.DAS_A3_A.Time;
plot(ebcmTime, ebcmEngagedState_ccan, ...
 dasA3ATime, ebcmEngageRequest_ccan)
title('EBCM Engaged Request/State') % title
ylabel('State') % label for y axis
xlabel('Time (s)') % label for x axis
legend('State', 'Request')
subplot(rowsOnPlot,2,2); 
plot(escTime, escEngagedState_ccan)
title('ESC Engaged State') % title
ylabel('State') % label for y axis
xlabel('Time (s)') % label for x axis
legend('State', 'Request')
subplot(rowsOnPlot,2,3) 
plot(epsaTime, epsaEngagedState_ccan)
title('EPSA Engaged State') % title
ylabel('State') % label for y axis
xlabel('Time (s)') % label for x axis
subplot(rowsOnPlot,2,4); 
plot(cbcTime, cbcEngagedState_ccan)
title('CBC Engaged State') % title
ylabel('State') % label for y axis
xlabel('Time (s)') % label for x axis
epsErrStat_ccan = SignalTable.EPS_A1.EPS_ErrStat;
epsA1Time = SignalTable.EPS_A1.Time;
subplot(rowsOnPlot,2,5); 
plot(epsA1Time, epsErrStat_ccan)
title('EPS Error Stat') % title
ylabel('State') % label for y axis
xlabel('Time (s)') % label for x axis
subplot(rowsOnPlot,2,6);
plot(time,vehicle_speed)
title('Vehicle Speed') % title
ylabel('Speed (kph)') % label for y axis
xlabel('Time (s)') % label for x axis
accelPdlPosnSens_Flt = SignalTable.ECM_A2.AccelPdlPosnSens_Flt;
ecmA2Time = SignalTable.ECM_A2.Time;
accelPdlPosn = SignalTable.ECM_A2.AccelPdlPosn;
subplot(rowsOnPlot,2,7);
plot(ecmA2Time,accelPdlPosn)
title('Accelerator Pedal Position') % title
ylabel('Position') % label for y axis
xlabel('Time (s)') % label for x axis
subplot(rowsOnPlot,2,8);
plot(ecmA2Time,accelPdlPosnSens_Flt)
title('Accelerator Pedal Fault') % title
ylabel('Status') % label for y axis
xlabel('Time (s)') % label for x axis