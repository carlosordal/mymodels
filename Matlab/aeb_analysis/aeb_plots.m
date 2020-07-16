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


% Plots for Modules disengagement error


%% All data ploted 
rowsOnPlot = 4;
columnsOnPlot = 1;
figure('NumberTitle', 'off', 'Name', ['All Data Plotted: ',fileName]);
hold on % allow all vectors to be plotted in same
set(gcf, 'Position', get(0, 'Screensize'));

%fcw Display
fcwDisplay = signalTable.DAS_A3.As_DispRq;

% AEB request ID
aebRequestId = signalTable.DAS_A3.DAS_Rq_ID;
das_a3_Time = signalTable.DAS_A3.Time;

createPlot(rowsOnPlot, columnsOnPlot, 1, ...
  das_a3_Time, fcwDisplay, ...
  'FCW State', 'FCW State', ...
  'Time (s)', 'FCW State')
createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  das_a3_Time, aebRequestId, ...
  'AEB request ID', 'AEB request ID', ...
  'Time (s)', 'AEB request ID')

% Vehicle Speed
vehicle_speed = signalTable.ESP_A8.VEH_SPEED;
esp_a8_Time = signalTable.ESP_A8.Time;

createPlot(rowsOnPlot, columnsOnPlot, 3, ...
  esp_a8_Time, vehicle_speed, ...
  'Vehicle Speed', 'Vehicle Speed', ...
  'Time (s)', 'Speed (km/h)')
  
% Distance to Object
distanceToObject = signalTable.DAS_A4.ObjIntrstDist;
das_a4_Time = signalTable.DAS_A4.Time;

createPlot(rowsOnPlot, columnsOnPlot, 4, ...
  das_a4_Time, distanceToObject, ...
  'Distance to Object', 'Distance to Object', ...
  'Time (s)', 'Distance (m)')



%% Focus Aread plotted
deltaTimePlot = duration('0:0:00.5');
rowsOnPlot = 4;
columnsOnPlot = 1;
figure('NumberTitle', 'off', 'Name', ['Focus Area Plotted: ',fileName]);
hold on % allow all vectors to be plotted in same
set(gcf, 'Position', get(0, 'Screensize'));

% extract time of interest - FCW Warning Activation and AEB Request Stopped
[startPlotAtTime, stopPlotAtTime] = extractStartAndStopTime(fcwDisplay, aebRequestId, das_a3_Time, deltaTimePlot);

% Plot FCW Display & AEB Request ID from DAS_A3
[startPlotAtIndex, stopPlotAtIndex] = extractStartStopIndex(das_a3_Time, startPlotAtTime, stopPlotAtTime);

das_a3_Time_short = das_a3_Time(startPlotAtIndex : stopPlotAtIndex);
fcwDisplay_short = fcwDisplay(startPlotAtIndex : stopPlotAtIndex);

createPlot(rowsOnPlot, columnsOnPlot, 1, ...
  das_a3_Time_short, fcwDisplay_short, ...
  'FCW State', 'FCW State', ...
  'Time (s)', 'FCW State')
aebRequestId_short = aebRequestId(startPlotAtIndex : stopPlotAtIndex);

createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  das_a3_Time_short, aebRequestId_short, ...
  'AEB request ID', 'AEB request ID', ...
  'Time (s)', 'AEB request ID')

% Plot Vehicle Speed from ESP_A8
[startPlotAtIndex, stopPlotAtIndex] = extractStartStopIndex(das_a3_Time, startPlotAtTime, stopPlotAtTime);
esp_a8_Time_short = esp_a8_Time(startPlotAtIndex : stopPlotAtIndex);
vehicleSpeedShort = vehicle_speed(startPlotAtIndex : stopPlotAtIndex);

createPlot(rowsOnPlot, columnsOnPlot, 3, ...
  esp_a8_Time_short, vehicleSpeedShort, ...
  'Vehicle Speed', 'Vehicle Speed', ...
  'Time (s)', 'Speed (km/h)')

% Plot Distance to Object from DAS_A4
[dasA4StartIndex, dasA4StopIndex] = extractStartStopIndex(das_a4_Time, startPlotAtTime, stopPlotAtTime);
das_a4_Time_short = das_a4_Time(dasA4StartIndex : dasA4StopIndex);
distanceToObjectShort = distanceToObject(dasA4StartIndex : dasA4StopIndex);
createPlot(rowsOnPlot, columnsOnPlot, 4, ...
  das_a4_Time_short, distanceToObjectShort, ...
  'Vehicle Speed', 'Vehicle Speed', ...
  'Time (s)', 'Speed (km/h)')

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

function [startPlotAtTime, stopPlotAtTime] = extractStartAndStopTime( ...
  fcwDisplayData, aebRequestIdData, ...
  das_a3_TimeData, deltaTimePlot)
% detect time index to start and stop ploting area of interest
% start plot from FCW Display status - deltaTimePlot
  for i=1 : numel(fcwDisplayData)
    if fcwDisplayData(i)  ~= 0
      %timeIndexFcwActivation = i;
      %disp(['FCW status changed on ', num2str(timeIndex)])
      fcwTimeActivation = das_a3_TimeData(i);
      %disp(['FCW was activated at ', char(fcwTimeActivation)]) 
      startPlotAtTime = fcwTimeActivation - deltaTimePlot;
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
      %timeIndexAebDeactivaded = i;
      %disp(['AEB Index DE activation 952?: ', num2str(timeIndexAebDeactivaded)])
      aebDeacticationTime = das_a3_TimeData(i);
      stopPlotAtTime = aebDeacticationTime + deltaTimePlot;
      %stopPlotAtTime = round(seconds(stopPlotAtTime));
      %stopPlotAtTime = duration(['0:0:',num2str(stopPlotAtTime)]);
      %disp(['Stop plotting at ', char(stopPlotAtTime)]) 

      break
    end
      %timeIndexDistancePublished = i;
      %disp(['Distance Index activation', num2str(timeIndexDistancePublished)])
      %distanceTimeActivation = das_a4_Time(i);
      %disp(['FCW was activated at ', char(fcwTimeActivation)]) 


    %end
  end
end


function createPlot(rowsOnPlot, columnsOnPlot, position,...
  xValues, yValues,...
  plotTitle, plotLengend, ...
  xPlotLabel, yPlotLabel)
    subplot(rowsOnPlot, columnsOnPlot, position)
    plot(xValues, yValues)
    title(plotTitle) % title
    legend(plotLengend)
    xlabel(xPlotLabel) % label for x axis
    ylabel(yPlotLabel) % label for y axis



end
