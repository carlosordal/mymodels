fileName = '5-7_P010-Drv_not_brk_bef_FCW-40_kph_trial_01_ccan_rr_DATA.mat';
%windows:
%filePath = 'C:\Users\cordunoalbarran\Repo\av-control-design\dspace\lib\AEB_matlab_analysis\';
%mac:
filePath = '/Users/cordunoalbarran/Documents/Repo/av-control-design/dspace/lib/AEB_matlab_analysis/';
%fullfullfile(matPath, matFileA)
%fullName = 'C:\Users\cordunoalbarran\Repo\mymodels\Matlab\Can_log_review\canLogData\02_1211_AEB_40kph_10_40_cCANData.mat';

 
%addpath(filePath);
aebMatData = load(fileName);
fieldNames = fieldnames(aebMatData);
signalTable = aebMatData.(fieldNames{1});


%% All data ploted 
rowsOnPlot = 5;
columnsOnPlot = 1;
figure('NumberTitle', 'off', 'Name', ['All Data Plotted: ',fileName]);
hold on % allow all vectors to be plotted in same
set(gcf, 'Position', get(0, 'Screensize'));

%fcw Display
fcwDisplay = signalTable.DAS_A3.As_DispRq;
das_a3_Time = signalTable.DAS_A3.Time;
plotFcwDisplay = createPlot(rowsOnPlot, columnsOnPlot, 1, ...
  das_a3_Time, fcwDisplay, ...
  'FCW State', 'DAS A3.As DispRq', ...
  'Time (s)', 'FCW State');


% AEB request ID and AEB activated
aebRequestId = signalTable.DAS_A3.DAS_Rq_ID;


% AEB Activated ESP_A2.DAS_RqActv
aebActivated = signalTable.ESP_A2.DAS_RqActv;
esp_a2_Time = signalTable.ESP_A2.Time;
plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  [das_a3_Time, esp_a2_Time], [aebRequestId, aebActivated], ...
  'AEB request ID', ['DAS A3.DAS Rq ID '; 'ESP A2.DAS RqActv'], ...
  'Time (s)', 'AEB request ID');

% Vehicle Speed ESP_A8.VEH_SPEED
vehicleSpeed = signalTable.ESP_A8.VEH_SPEED;
esp_a8_Time = signalTable.ESP_A8.Time;

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 3, ...
  esp_a8_Time, vehicleSpeed, ...
  'Vehicle Speed', 'ESP A8.VEH SPEED', ...
  'Time (s)', 'Speed (km/h)');
  
% Distance to Object DAS_A4.ObjIntrstDist
distanceToObject = signalTable.DAS_A4.ObjIntrstDist;
das_a4_Time = signalTable.DAS_A4.Time;

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 4, ...
  das_a4_Time, distanceToObject, ...
  'Distance to Object', 'DAS A4.ObjIntrstDist', ...
  'Time (s)', 'Distance (m)');

% Vehicle Acceleration ESP_A4.VehAccel_X
vehicleAcceleration = signalTable.ESP_A4.VehAccel_X;
esp_a4_Time = signalTable.ESP_A4.Time;

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 5, ...
  esp_a4_Time, vehicleAcceleration, ...
  'Vehicle Acceleration', 'ESP A4.VehAccel X', ...
  'Time (s)', 'Acceleration m/s^2');


%% Focus Aread plotted
deltaTimePlot = duration('0:0:00.5');
rowsOnPlot = 5;
columnsOnPlot = 1;
figure('NumberTitle', 'off', 'Name', ['Focus Area Plotted: ',fileName]);
hold on % allow all vectors to be plotted in same
set(gcf, 'Position', get(0, 'Screensize'));

% extract time of interest - FCW Warning Activation and AEB Request Stopped
% % [startPlotAtTime, stopPlotAtTime, fcwTriggerTime, aebDeacticationTime] = ...
% %   extractStartAndStopTime(fcwDisplay, aebRequestId, das_a3_Time, deltaTimePlot);

% extract time of interest - AEB request Start and AEB Request Stopped -DAS_A3.DAS_Rq_ID
[aebRequestStartTime, aebRequestStopTime] = ...
  aebExtractStartAndStopTime(aebRequestId, das_a3_Time);

% detect Distance to Object Stop being published
% distanceToObject = signalTable.DAS_A4.ObjIntrstDist;
% das_a4_Time = signalTable.DAS_A4.Time;
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
    distanceToObjectNotPublishedLine.Color = 'r';
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

% Plot FCW Display Index das_a3
[startPlotAtIndex, stopPlotAtIndex] = extractStartStopIndex(das_a3_Time, startPlotAtTime, stopPlotAtTime);

das_a3_Time_short = das_a3_Time(startPlotAtIndex : stopPlotAtIndex);
fcwDisplay_short = fcwDisplay(startPlotAtIndex : stopPlotAtIndex);

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 1, ...
  das_a3_Time_short, fcwDisplay_short, ...
  'FCW State', 'DAS A3.As DispRq', ...
  'Time (s)', 'FCW State');
fcwTriggerLine = xline(fcwTriggerTime);
fcwTriggerLine.DisplayName = 'FCW Trigger Time';
fcwTriggerLine.Color = 'r';
fcwTriggerLine.LineWidth = 2;
fcwTriggerLine.LineStyle = '--';



% Plot DAS_A3.DAS_Rq_ID and ESP_A2.DAS_Rq_Act

[espA2StartIndex, espA2StopIndex] = extractStartStopIndex(esp_a2_Time, startPlotAtTime, stopPlotAtTime);

aebRequestId_short = aebRequestId(startPlotAtIndex : stopPlotAtIndex);

esp_a2_Time_short = esp_a2_Time(espA2StartIndex : espA2StopIndex);
aebActivatedShort = aebActivated(espA2StartIndex : espA2StopIndex);

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  das_a3_Time_short, aebRequestId_short, ...
  'AEB request ID', 'DAS A3.DAS Rq ID', ...
  'Time (s)', 'AEB ID');
aebDeactivationRequestLine = xline(aebDeacticationTime);
aebDeactivationRequestLine.DisplayName = 'AEB Deactivation Request Time';
aebDeactivationRequestLine.Color = 'r';
aebDeactivationRequestLine.LineWidth = 2;
aebDeactivationRequestLine.LineStyle = '--';


% Plot Vehicle Speed from ESP_A8.VEH_SPEED
[startPlotAtIndex, stopPlotAtIndex] = extractStartStopIndex(das_a3_Time, startPlotAtTime, stopPlotAtTime);
esp_a8_Time_short = esp_a8_Time(startPlotAtIndex : stopPlotAtIndex);
vehicleSpeedShort = vehicleSpeed(startPlotAtIndex : stopPlotAtIndex);

plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 3, ...
  esp_a8_Time_short, vehicleSpeedShort, ...
  'Vehicle Speed', 'ESP A8.VEH SPEED', ...
  'Time (s)', 'Speed (km/h)');

% Plot Distance to Object from DAS_A4
[dasA4StartIndex, dasA4StopIndex] = extractStartStopIndex(das_a4_Time, startPlotAtTime, stopPlotAtTime);
das_a4_Time_short = das_a4_Time(dasA4StartIndex : dasA4StopIndex);
distanceToObjectShort = distanceToObject(dasA4StartIndex : dasA4StopIndex);
plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 4, ...
  das_a4_Time_short, distanceToObjectShort, ...
  'Distance to Object', 'DAS A4.ObjIntrstDist', ...
  'Time (s)', 'Distance (m)');
minDistancePublishedLine = xline(minDistanceTime);
minDistancePublishedLine.DisplayName = 'min Distance Published';
minDistancePublishedLine.Color = [0.49,0.18,0.56]; %purple
minDistancePublishedLine.LineWidth = 2;
minDistancePublishedLine.LineStyle = '--';
approachStartLine = xline(approachStartTime);
approachStartLine.DisplayName = 'approach Start';
approachStartLine.Color = [0.49,0.18,0.56]; %purple
approachStartLine.LineWidth = 2;
approachStartLine.LineStyle = ':';




% Plot Vehicle Acceleration from ESP_A4
[espA4StartIndex, espA4StopIndex] = extractStartStopIndex(esp_a4_Time, startPlotAtTime, stopPlotAtTime);
esp_a4_Time_short = esp_a4_Time(espA4StartIndex : espA4StopIndex);
vehicleAccelerationShort = vehicleAcceleration(espA4StartIndex : espA4StopIndex);
plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, 5, ...
  esp_a4_Time_short, vehicleAccelerationShort, ...
  'Vehicle Acceleration', 'ESP A4.VehAccel X', ...
  'Time (s)', 'Speed (m/s^2)');


% detect AEB start -0.5 m/s^2 after AEB was requested
% ESP_A4.VehAccel_X
aebDecelerationStart = -0.5;  
for j=1 : numel(vehicleAccelerationShort)
  if vehicleAccelerationShort(j) <= aebDecelerationStart
    aebStartIndex = j;
    aebStartTime = esp_a4_Time_short(j);
    %set(plotAttribute, 'Color', 'r');
    verticalLine = xline(aebStartTime);
    legend('ESP A4.VehAccel X','AEB start -0.5m/s^2');
    verticalLine.Color = 'r';
    verticalLine.LineWidth = 2;
    verticalLine.LineStyle = '--';
%     verticalLine.Label = 'AEB start -0.5m/s^2';
%     verticalLine.LabelVerticalAlignment = 'bottom';
%     verticalLine.LabelHorizontalAlignment = 'left';
    break
  end
end

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
acceleratorPedalPosition = signalTable.ECM_SKIM_OBD.AccelPdlPosn_OBD;
ecmSkimObdTime = signalTable.ECM_SKIM_OBD.Time;
figure();
hold on % allow all vectors to be plotted in same
accel = plot(ecmSkimObdTime,acceleratorPedalPosition);
speed = plot(esp_a8_Time,vehicleSpeed);
accel.DisplayName = 'Pedal';
accel.DisplayName = 'Speed';

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
    plotAttribute = plot(xValues, yValues);
    title(plotTitle) % title
    legend(plotLengend)
    xlabel(xPlotLabel) % label for x axis
    ylabel(yPlotLabel) % label for y axis



end
