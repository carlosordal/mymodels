% Plots for Steering Damping test

figure
hold on % allow all vectors to be plotted in same
rowsOnPlot = 1;
columnsOnPlot = 2;


proppulsionEcuMotorTorque = SignalTable.RHSC_SDS_SteerControl.RHSC_MotorTorqueCommand;
propulsionEcuTime = SignalTable.RHSC_SDS_SteerControl.Time;
propulsionEcuDamping = SignalTable.RHSC_SDS_SteerControl.RHSC_DampingScalarReq;

subplot(rowsOnPlot,columnsOnPlot,1); 
plot(propulsionEcuTime, propulsionEcuDamping)

title('Motor Torque Command') % title
ylabel('Damping') % label for y axis
xlabel('Time (s)') % label for x axis
legend('Damping')

 % figure
epsaMotorTorque = SignalTable.EPS_1.EPSMotorTorque;
epsaTime = SignalTable.EPS_1.Time;


subplot(rowsOnPlot,columnsOnPlot,2); 
plot(epsaTime, epsaMotorTorque,...
    propulsionEcuTime, proppulsionEcuMotorTorque)

title('EPS A output') % title
ylabel('Torque/Angle') % label for y axis
xlabel('Time (s)') % label for x axis
legend('Torque', 'McEcu Torque Req')