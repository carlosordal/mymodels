% AEB test procotol: https://docs.google.com/document/d/1pz1lNJWJckO5f-3dfKTAUUEOIpNzPw4-Id30lYpt1wo/edit#
% Next steps:
% Fix legend on Vehicle acceleration plot
% Fix AEB start detection.
% convert it into function
% define a way to point to the signal Time table withing the struct. That
% works with different strcut content. old and new 1 or more signal table
% 
% 

fileName = '5-7 P010-Drv not brk bef FCW-40 kph trial 01.mat';
%fileName = '5-7_P010-Drv_not_brk_bef_FCW-40_kph_trial_01_ccan_rr_DATA.mat';
%windows:
%filePath = 'C:\Users\cordunoalbarran\Repo\av-control-design\dspace\lib\AEB_matlab_analysis\';
%mac:
%filePath = '/Users/cordunoalbarran/Documents/Repo/av-control-design/dspace/lib/AEB_matlab_analysis/';
filePath = '/Users/cordunoalbarran/Documents/Repo/mymodels/Matlab/aeb_analysis/can_logs';
%fullfullfile(matPath, matFileA)
%fullName = 'C:\Users\cordunoalbarran\Repo\mymodels\Matlab\Can_log_review\canLogData\02_1211_AEB_40kph_10_40_cCANData.mat';

 
% addpath(filePath);
% aebMatData = load(fileName);            % it contains the canLogSignalsTable
% fieldNames = fieldnames(aebMatData);    % canLogs 
% ccanTableData = aebMatData.(fieldNames{1});

addpath(filePath);
aebMatFile = load(fileName);            % it contains the canLogSignalsTable
matTopTitleList = fieldnames(aebMatFile);    % canLogs 
ccanTableDatasData = aebMatFile.(matTopTitleList{1});
dataLogsList = fieldnames(ccanTableDatasData);
ccanTableData = ccanTableDatasData.(dataLogsList{1});


%% All data ploted 
rowsOnPlot = 6;
columnsOnPlot = 1;
figure('NumberTitle', 'off', 'Name', ['All Data Plotted: ',fileName]);
%hold on % allow all vectors to be plotted in same
set(gcf, 'Position', get(0, 'Screensize'));     %figure on full screen

%fcw Display
fcwDisplay = ccanTableData.DAS_A3.As_DispRq;
das_a3_Time = ccanTableData.DAS_A3.Time;
plotFcwDisplay = createPlot(rowsOnPlot, columnsOnPlot, 1, ...
  das_a3_Time, fcwDisplay, ...
  'FCW State', 'DAS A3.As DispRq', ...
  'Time (s)', 'FCW State');


% AEB request ID DAS_A3.DAS_Rq_ID and AEB activated  ESP_A2.DAS_RqActv
aebRequestId = ccanTableData.DAS_A3.DAS_Rq_ID;


% AEB Activated ESP_A2.DAS_RqActv
aebActuatorStatus = ccanTableData.ESP_A2.DAS_RqActv;
esp_a2_Time = ccanTableData.ESP_A2.Time;
plotAebRequestStatus = createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  das_a3_Time, aebRequestId, ...
  'AEB request ID', 'DAS A3.DAS Rq ID', ...
  'Time (s)', 'AEB request ID');
hold on;
plotAebActuatorStatus = createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  esp_a2_Time, aebActuatorStatus, ...
  'AEB request ID', 'ESP A2.DAS RqActv', ...
  'Time (s)', 'AEB request ID');
hold off;
% Vehicle Speed ESP_A8.VEH_SPEED
vehicleSpeed = ccanTableData.ESP_A8.VEH_SPEED;
esp_a8_Time = ccanTableData.ESP_A8.Time;

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 3, ...
  esp_a8_Time, vehicleSpeed, ...
  'Vehicle Speed', 'ESP A8.VEH SPEED', ...
  'Time (s)', 'Speed (km/h)');
  
% Distance to Object DAS_A4.ObjIntrstDist
distanceToObject = ccanTableData.DAS_A4.ObjIntrstDist;
das_a4_Time = ccanTableData.DAS_A4.Time;

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 4, ...
  das_a4_Time, distanceToObject, ...
  'Distance to Object', 'DAS A4.ObjIntrstDist', ...
  'Time (s)', 'Distance (m)');

% Vehicle Acceleration ESP_A4.VehAccel_X
vehicleAcceleration = ccanTableData.ESP_A4.VehAccel_X;
esp_a4_Time = ccanTableData.ESP_A4.Time;

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 5, ...
  esp_a4_Time, vehicleAcceleration, ...
  'Vehicle Acceleration', 'ESP A4.VehAccel X', ...
  'Time (s)', 'Acceleration m/s^2');

% Accelerator Pedal Postion %ECM_SKIM_OBD.AccelPdlPosn_OBD
acceleratorPedalPosition = ccanTableData.ECM_SKIM_OBD.AccelPdlPosn_OBD;
ecmSkimObdTime = ccanTableData.ECM_SKIM_OBD.Time;
accelPedalPlot = createPlot(rowsOnPlot, columnsOnPlot, 6, ...
  ecmSkimObdTime, acceleratorPedalPosition, ...
  'Accelerator Pedal', 'ECM SKIM OBD.AccelPdlPosn OBD', ...
  'Time (s)', 'Pedal Pos %');


%% Focus Aread plotted
deltaTimePlot = duration('0:0:00.5');
extendPlotTime = duration('0:0:1');
rowsOnPlot = 5;
columnsOnPlot = 1;
figure('NumberTitle', 'off', 'Name', ['Focus Area Plotted: ',fileName]);
hold on % allow all vectors to be plotted in same
set(gcf, 'Position', get(0, 'Screensize'));

% extract time of interest - FCW Warning Activation and AEB Request Stopped
% % [startPlotAtTime, stopPlotAtTime, fcwTriggerTime, aebDeacticationTime] = ...
% %   extractStartAndStopTime(fcwDisplay, aebRequestId, das_a3_Time, deltaTimePlot);

% extract time of interest - AEB request Start and AEB Request Stopped -DAS_A3.DAS_Rq_ID
% this is used to determine area of interest
[aebRequestStartTime, aebRequestStopTime] = ...
  aebExtractStartAndStopTime(aebRequestId, das_a3_Time);

% detect Distance to Object Stop being published
% distanceToObject = ccanTableData.DAS_A4.ObjIntrstDist;
% das_a4_Time = ccanTableData.DAS_A4.Time;
distanceToObjectPublished = false;
distanceDefaultValue = 254;
for i=1 : numel(distanceToObject)
  if (distanceToObject(i) ~= distanceDefaultValue) && ~distanceToObjectPublished
    distanceToObjectPublished = true;
    initialDistanceToObjectIndex = i;
  end
  if distanceToObjectPublished && (distanceToObject(i) == distanceDefaultValue)
    distanceToObjectNotPublishedTime = das_a4_Time(i);
    distanceToObjectNotPublishedLine = xline(distanceToObjectNotPublishedTime);
    distanceToObjectNotPublishedLine.DisplayName = 'Dist to Obj Stopped';
    distanceToObjectNotPublishedLine.Color = [1,0,1]	; %pink
    distanceToObjectNotPublishedLine.LineWidth = 2;
    distanceToObjectNotPublishedLine.LineStyle = '--';
    finalDistanceToObjectIndex = i-1;
    break
  end

end
distancePublished = distanceToObject(initialDistanceToObjectIndex : finalDistanceToObjectIndex);
maxDistancePublished = max(distancePublished);
minDistancePublished = min(distancePublished);

%fine Time when the minimum distance was reported.
approachLength = duration('0:0:05.4');
for i=1 : numel(distanceToObject)
  if distanceToObject(i) == 2
    minDistanceIndex = i;
    minDistanceTime = das_a4_Time(i);
    approachStartTime = minDistanceTime - approachLength;


    break
  end
end

startPlotAtTime = approachStartTime;
stopPlotAtTime = aebRequestStopTime + extendPlotTime;

% Plot FCW Display Index das_a3
[startPlotAtIndex, stopPlotAtIndex] = extractStartStopIndex(das_a3_Time, startPlotAtTime, stopPlotAtTime);

das_a3_Time_short = das_a3_Time(startPlotAtIndex : stopPlotAtIndex);
fcwDisplay_short = fcwDisplay(startPlotAtIndex : stopPlotAtIndex);

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 1, ...
  das_a3_Time_short, fcwDisplay_short, ...
  'FCW State', 'FCW Warning Status', ...
  'Time (s)', 'FCW State');
% fcwTriggerLine = xline(fcwTriggerTime);
% fcwTriggerLine.DisplayName = 'FCW Trigger Time';
% fcwTriggerLine.Color = 'r';
% fcwTriggerLine.LineWidth = 2;
% fcwTriggerLine.LineStyle = '--';



% AEB Activation. Plot DAS_A3.DAS_Rq_ID and ESP_A2.DAS_Rq_Act

[espA2StartIndex, espA2StopIndex] = extractStartStopIndex(esp_a2_Time, startPlotAtTime, stopPlotAtTime);
aebRequestId_short = aebRequestId(startPlotAtIndex : stopPlotAtIndex);

esp_a2_Time_short = esp_a2_Time(espA2StartIndex : espA2StopIndex);
aebActuatorStatusShort = aebActuatorStatus(espA2StartIndex : espA2StopIndex);

plotAebRequest = createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  das_a3_Time_short, aebRequestId_short, ...
  'AEB Req/Act Status', 'AEB Request Status', ...
  'Time (s)', 'AEB Status');
aebDeactivationRequestLine = xline(aebRequestStopTime);
aebDeactivationRequestLine.DisplayName = 'AEB Deactivation Request Time';
aebDeactivationRequestLine.Color = 	[1.00,0.00,1.00]	; %pink
aebDeactivationRequestLine.LineWidth = 2;
aebDeactivationRequestLine.LineStyle = '--';
hold on;
plotAebActuator = createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  esp_a2_Time_short, aebActuatorStatusShort, ...
  'AEB Req/Act Status', 'AEB Actuator Status', ...
  'Time (s)', 'AEB Status');

% Plot Vehicle Speed from ESP_A8.VEH_SPEED
[startPlotAtIndex, stopPlotAtIndex] = extractStartStopIndex(das_a3_Time, startPlotAtTime, stopPlotAtTime);
esp_a8_Time_short = esp_a8_Time(startPlotAtIndex : stopPlotAtIndex);
vehicleSpeedShort = vehicleSpeed(startPlotAtIndex : stopPlotAtIndex);
hold off;


plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 3, ...
  esp_a8_Time_short, vehicleSpeedShort, ...
  'Vehicle Speed', 'Vehicle Speed', ...
  'Time (s)', 'Speed (km/h)');

hold on;
yyaxis right;

% Vehicle acceleration data & plot
[espA4StartIndex, espA4StopIndex] = extractStartStopIndex(esp_a4_Time, startPlotAtTime, stopPlotAtTime);
esp_a4_Time_short = esp_a4_Time(espA4StartIndex : espA4StopIndex);
vehicleAccelerationShort = vehicleAcceleration(espA4StartIndex : espA4StopIndex);
plotAccelPedal = createPlot(rowsOnPlot, columnsOnPlot, 3, ...
  esp_a4_Time_short, vehicleAccelerationShort, ...
  'Vehicle Acceleration', 'Vehicle Acceleration', ...
  'Time (s)', 'Acceleration (m/s^2)');

% Vehicle acceleration during AEB request 

% detect AEB start -0.5 m/s^2 after AEB was requested
% ESP_A4.VehAccel_X
% ESP_A2.DAS_Rq_Act
aebDecelerationStart = -0.5;  
[vehAccelOnAebStartIndex, vehAccelOnAebStopIndex] = extractStartStopIndex(esp_a4_Time_short, aebRequestStartTime, aebRequestStopTime);
vehAccelOnAebVector = vehicleAccelerationShort(vehAccelOnAebStartIndex : vehAccelOnAebStopIndex);
espA4TimeOnAebVector = esp_a4_Time_short(vehAccelOnAebStartIndex : vehAccelOnAebStopIndex);
%aebRequestStartTime
for j=1 : numel(vehAccelOnAebVector)
  if vehAccelOnAebVector(j) <= aebDecelerationStart
    aebStartIndex = j;
    aebStartTime = espA4TimeOnAebVector(j);
    %set(plotAttribute, 'Color', 'r');
    verticalLine = xline(aebStartTime);
    legend('ESP A4.VehAccel X','AEB start -0.5m/s^2');
    verticalLine.Color = [1,0,1]	; %pink
    verticalLine.LineWidth = 2;
    verticalLine.LineStyle = '--';
%     verticalLine.Label = 'AEB start -0.5m/s^2';
%     verticalLine.LabelVerticalAlignment = 'bottom';
%     verticalLine.LabelHorizontalAlignment = 'left';
    break
  end
end

hold off;
% Plot Distance to Object from DAS_A4
[dasA4StartIndex, dasA4StopIndex] = extractStartStopIndex(das_a4_Time, startPlotAtTime, stopPlotAtTime);
das_a4_Time_short = das_a4_Time(dasA4StartIndex : dasA4StopIndex);
distanceToObjectShort = distanceToObject(dasA4StartIndex : dasA4StopIndex);
plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 4, ...
  das_a4_Time_short, distanceToObjectShort, ...
  'Distance to Object', 'Distance to Object', ...
  'Time (s)', 'Distance (m)');
minDistancePublishedLine = xline(minDistanceTime);
minDistancePublishedLine.DisplayName = 'min Distance Published';
minDistancePublishedLine.Color = [1,0,1]	; %pink
minDistancePublishedLine.LineWidth = 2;
minDistancePublishedLine.LineStyle = '--';
approachStartLine = xline(approachStartTime);
approachStartLine.DisplayName = 'approach Start';
approachStartLine.Color = [1,0,1]	; %pink
approachStartLine.LineWidth = 2;
approachStartLine.LineStyle = ':';






%% Vehicle Speed Max and Min before AEB activation ESP_A8.VEH_SPEED
deltaTimeChecks = duration('0:0:03');
vehicleSpeedTolerance = 1; %+- 1 km/h
checkStopTime = aebStartTime;
checkStartTime = checkStopTime - deltaTimeChecks;
[checkStartIndex, checkStopIndex] = extractStartStopIndex(esp_a8_Time, checkStartTime, checkStopTime);

vehicleSpeedCheck = vehicleSpeed(checkStartIndex:checkStopIndex);
vehicleSpeedMin = min(vehicleSpeedCheck);
vehicleSpeedMax = max(vehicleSpeedCheck);
vehicleSpeedMean = mean(vehicleSpeedCheck);

if (35 < vehicleSpeedMean) && (vehicleSpeedMean < 45)
  vehicleSpeedTest = 40;
  checkVehicleSpeed(vehicleSpeedTest,vehicleSpeedTolerance, ...
    vehicleSpeedMax, vehicleSpeedMin);

elseif (15 < vehicleSpeedMean) && (vehicleSpeedMean < 25)
  vehicleSpeedTest = 20;
  checkVehicleSpeed(vehicleSpeedTest,vehicleSpeedTolerance, ...
    vehicleSpeedMax, vehicleSpeedMin);
  %disp('20 km/h test')
else 
  error('Average Vehicle Speed out of range')

end

%% Accelerator Pedal check
% Accelerator pedal position must not fluctuate more than +-5% of the full travel from the original pedal position.
% Accel check, should be done vs Distance Object - 5.4 senconds.
%ECM_SKIM_OBD	AccelPdlPosn_OBD	Pedal value for OBD (ISO 15031-5.4 PID 49)
approachPhaseDeltaTime = duration('0:0:5.4');


[ecmSkimObdStartIndex, ecmSkimObdStopIndex] = extractStartStopIndex(ecmSkimObdTime, startPlotAtTime, stopPlotAtTime);
ecmSkimObdTimeShort = ecmSkimObdTime(ecmSkimObdStartIndex : ecmSkimObdStopIndex);
acceleratorPedalPositionShort = acceleratorPedalPosition(ecmSkimObdStartIndex : ecmSkimObdStopIndex);

accelPedalPlot = createPlot(rowsOnPlot, columnsOnPlot, 5, ...
  ecmSkimObdTimeShort, acceleratorPedalPositionShort, ...
  'Accelerator Pedal Position', 'Accel Pedal Position', ...
  'Time (s)', 'Pedal Pos %');
% accel = plot(ecmSkimObdTime,acceleratorPedalPosition);
% speed = plot(esp_a8_Time,vehicleSpeed);
% accel.DisplayName = 'Pedal';
% accel.DisplayName = 'Speed';

acceleratorPedalTolerance = 5; %+- 5% 
[checkStartIndex, checkStopIndex] = extractStartStopIndex(ecmSkimObdTime, checkStartTime, checkStopTime);

acceleratorPedalCheck = acceleratorPedalPosition(checkStartIndex:checkStopIndex);
acceleratorPedalMin = min(acceleratorPedalCheck);
acceleratorPedalMax  = max(acceleratorPedalCheck);
acceleratorPedalMean = mean(acceleratorPedalCheck);
checkVehicleAcceleratorPedal(acceleratorPedalMean,acceleratorPedalTolerance, ...
    acceleratorPedalMax, acceleratorPedalMin);

%% Functions
function checkVehicleAcceleratorPedal(acceleratorPedalMean, acceleratorPedalTolerance, ...
  acceleratorPedalMax, acceleratorPedalMin)
  maxPedalAccepted = acceleratorPedalMean + acceleratorPedalTolerance;
  minPedalAccepted = acceleratorPedalMean - acceleratorPedalTolerance;
  if acceleratorPedalMax < maxPedalAccepted
    maxPedalCheck = true;
  else 
    maxPedalCheck = false;
  end
  if acceleratorPedalMin > minPedalAccepted
    minPedalCheck = true;
  else 
    minPedalCheck = false;
  end
  
  %disp([num2str(vehicleSpeedTest), 'km/h test:'])
  disp(['Vehicle Max Accel Pedal: ', num2str(acceleratorPedalMax), ', Result: ', num2str(maxPedalCheck)])
  disp(['Vehicle Min Accel Pedal: ', num2str(acceleratorPedalMin), ', Result: ', num2str(minPedalCheck)])
end


function checkVehicleSpeed(vehicleSpeedTest, vehicleSpeedTolerance, ...
  vehicleSpeedMax, vehicleSpeedMin)
  maxSpeedAccepted = vehicleSpeedTest + vehicleSpeedTolerance;
  minSpeedAccepted = vehicleSpeedTest - vehicleSpeedTolerance;
  if vehicleSpeedMax < maxSpeedAccepted
    maxSpeedCheck = true;
  else 
    maxSpeedCheck = false;
  end
  if vehicleSpeedMin > minSpeedAccepted
    minSpeedCheck = true;
  else 
    minSpeedCheck = false;
  end
  
  disp([num2str(vehicleSpeedTest), 'km/h test:'])
  disp(['Vehicle Max Speed: ', num2str(vehicleSpeedMax), ', Result: ', num2str(maxSpeedCheck)])
  disp(['Vehicle Min Speed: ', num2str(vehicleSpeedMin), ', Result: ', num2str(minSpeedCheck)])
  
end

function [startPlotAtIndex, stopPlotAtIndex] = extractStartStopIndex( ...
  signalTimeData, startPlotAtTime, stopPlotAtTime)
%extract Time index for stop plotting for this Signal 
  for i=1 : numel(signalTimeData)
    if signalTimeData(i) >= startPlotAtTime
      startPlotAtIndex = i;
      %disp(['FCW start plot at index: ', num2str(startPlotAtIndex)])
      break
    end
  end
%extract Time index for stop plotting for this Signal
  for i= 1 : numel(signalTimeData)
      if signalTimeData(i) >= stopPlotAtTime
        stopPlotAtIndex = i;
        break
      end
  end

end

function [startPlotAtTime, stopPlotAtTime, fcwTriggerTime, aebDeacticationTime] = extractStartAndStopTime( ...
  fcwDisplayData, aebRequestIdData, ...
  das_a3_TimeData, deltaTimePlot)
% detect time index to start and stop ploting area of interest
% start plot from FCW Display status - deltaTimePlot
  for i=1 : numel(fcwDisplayData)
    if fcwDisplayData(i)  ~= 0
      %timeIndexFcwActivation = i;
      %disp(['FCW status changed on ', num2str(timeIndex)])
      fcwTriggerTime = das_a3_TimeData(i);
      %disp(['FCW was activated at ', char(fcwTimeActivation)]) 
      startPlotAtTime = fcwTriggerTime - deltaTimePlot;
%       startPlotAtTime = round(seconds(startPlotAtTime));
%       startPlotAtTime = duration(['0:0:',num2str(startPlotAtTime)]);
      %disp(['Start plotting at ', char(startPlotAt)]) 
      break
    end
  end
 

  % detect time index to stop ploting area of interest
  % distant to AEB request ID transition from requested to not requested
  % it doesn't work if only FCW has been triggered.

  aebRequestedStatus = false;
  for i=1 : numel(aebRequestIdData)
    if aebRequestIdData(i) ~= 0
      aebRequestedStatus = true;
    end
    if aebRequestedStatus && (aebRequestIdData(i) == 0)
      aebDeacticationTime = das_a3_TimeData(i);
      stopPlotAtTime = aebDeacticationTime + deltaTimePlot;
      break
    end

  end
end

function [StartTime, StopTime] = ...
  aebExtractStartAndStopTime( ...
  statusData, ...
  TimeData)
% detect time/index for AEB start/stop request DAS_A3.DAS_Rq_ID
  aebRequestActive = false;
  aebRequestDefault = 0;
  for i=1 : numel(statusData)
    if (statusData(i) ~= aebRequestDefault) && ~aebRequestActive
      aebRequestActive = true;
      aebRequestStartIndex = i;
      StartTime = TimeData(aebRequestStartIndex);

    end
    if aebRequestActive && (statusData(i) == aebRequestDefault)
      aebRequestStopIndex = i-1;
      StopTime = TimeData(aebRequestStopIndex);
      break
    end
  end
end

function plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, position,...
  xValues, yValues,...
  plotTitle, plotLengend, ...
  xPlotLabel, yPlotLabel)
    subplot(rowsOnPlot, columnsOnPlot, position)
    legend('-DynamicLegend');

    plotAttribute = plot(xValues, yValues, 'DisplayName',plotLengend);
    legend show;

    %plotAttribute.DisplayName = plotLengend;
    %legend('ESP A4.VehAccel X','AEB start -0.5m/s^2');
    %verticalLine.Color = 'r';
    plotAttribute.LineWidth = 1.5 ;
    %verticalLine.LineStyle = '--';
    
    title(plotTitle) % title
    %legend([plotAttribute],{plotLengend})
    xlabel(xPlotLabel) % label for x axis
    ylabel(yPlotLabel) % label for y axis



end
