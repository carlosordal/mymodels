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

dataMatLocation = 'canLogSignalsTable.ccan_rr_log';
dataMatLocation = split(dataMatLocation, '.');
level1 = string(dataMatLocation(1));
level2 = string(dataMatLocation(2));

addpath(filePath);
aebMatFile = load(fileName);            % it contains the canLogSignalsTable
ccanTableData = aebMatFile.(level1).(level2);
% matTopTitleList = fieldnames(aebMatFile);    % canLogs 
% ccanTableDatasData = aebMatFile.(matTopTitleList{1});
% dataLogsList = fieldnames(ccanTableDatasData);
% ccanTableData = ccanTableDatasData.(dataLogsList{1});


% Find Approach phase time and AEB End time
% Approach Phase Start/Plot Start = Min Distance Report Time - 5.4s
% Plot End Time = AEB Request Stop Time + Plot extension Time

% Find AEB Request Start and End Time
aebRequestId            = ccanTableData.DAS_A3(:, 'DAS_Rq_ID');
% aebRequestId = ccanTableData.DAS_A3.DAS_Rq_ID;
aebRequestDefaultValue  = 0;
[aebRequestStartTime, aebRequestStartValue, ...
  aebRequestStopTime, aebRequestStopValue] = ...
  signalEdgesDetection(aebRequestId, aebRequestDefaultValue);

% detect Distance to Object Stop being published
% distanceToObject = ccanTableData.DAS_A4.ObjIntrstDist;
% das_a4_Time = ccanTableData.DAS_A4.Time;
distanceToObject     = ccanTableData.DAS_A4(:, 'ObjIntrstDist');
distanceDefaultValue = 254;
[distanceStartTime, distanceStartValue, ...
  distanceStopTime, distanceStopValue] = ...
  signalEdgesDetection(distanceToObject, distanceDefaultValue);

% find Time when the minimum distance was reported.
timeWindow = timerange(distanceStartTime, distanceStopTime);
distanceToObjectPublished = distanceToObject(timeWindow,:);
approachLength      = duration('0:0:05.4');
extendPlotTime      = duration('0:0:1');
minDistanceTime     = getValueTime(distanceToObjectPublished, distanceStopValue);

approachStartTime   = minDistanceTime - approachLength;
startPlotTime       = approachStartTime;
stopPlotTime        = aebRequestStopTime + extendPlotTime;
focusAreaTimeWindow = timerange(startPlotTime,stopPlotTime);




% Create 2 figures. Full plot and Focus Area plot.
% Figure: Plot All Data
rowsOnFullPlot      = 5;
columnsOnFullPlot   = 1;
figure('NumberTitle', 'off', 'Name', ['All Data Plotted: ',fileName]);
plotAllData = 1;
set(gcf, 'Position', get(0, 'Screensize'));     %figure on full screen

% Figure: Plot Focus Area
rowsOnFocusPlot     = 5;
columnsOnFocusPlot  = 1;
figure('NumberTitle', 'off', 'Name', ['Focus Area Plotted: ',fileName]);
plotFocusArea = 2;
set(gcf, 'Position', get(0, 'Screensize'));

% FCW Display - Full
figure(plotAllData)
fcwDisplayFull      =  ccanTableData.DAS_A3(:, 'As_DispRq');
plotFcwDisplay      = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
  fcwDisplayFull.Time, fcwDisplayFull.As_DispRq, ...
  'FCW State', 'DAS A3.As DispRq', ...
  'Time (s)', 'FCW State');

% FCW Display - Focus
fcwDisplayEvent     = ccanTableData.DAS_A3(focusAreaTimeWindow,'As_DispRq');
figure(plotFocusArea)
plotFcwDisplayFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
  fcwDisplayEvent.Time, fcwDisplayEvent.As_DispRq, ...
  'FCW State', 'FCW Warning Status', ...
  'Time (s)', 'FCW State');



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

function [edgeStartTime, edgeStartValue, edgeStopTime, edgeSoptValue] = ...
  signalEdgesDetection(signalData, initialValue)
% this function detect edges from initial value and returning to the
% initial value.
% __/x----x\__ or ---\x____x/----.
% Input (1) timeTable singal with variable of interest on position 1.
  edgeDetected = false;
  variableName = inputname(1);
  for i=1 : numel(signalData)
    if (signalData.(1)(i) ~= initialValue) && ~edgeDetected
      edgeDetected = true;
      edgeStartTime = signalData.Time(i);
      edgeStartValue = signalData.(1)(i);
    elseif edgeDetected == false 
      edgeStartTime = {};
    end
    if (signalData.(1)(i) == initialValue) && edgeDetected      
      edgeStopTime = signalData.Time(i-1);
      edgeSoptValue = signalData.(1)(i-1);
      break
    else
      edgeStopTime = {};
    end
  end
  if isempty(edgeStopTime) || isempty (edgeStartTime)
    error(['Rising/Falling Edges not found for: ', variableName]);
  end
end

function timeStamp = getValueTime(signalTimeTable, value)

  for i=1 : numel(signalTimeTable)
    if signalTimeTable.(1)(i) == value
      timeStamp = signalTimeTable.Time(i);
      break
    end
  end
end


