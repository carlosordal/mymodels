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
rowsOnPlot = 4;
columnsOnPlot = 2;
deltaTimePlot = duration('0:0:01');

figure
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
createPlot(rowsOnPlot, columnsOnPlot, 3, ...
  das_a3_Time, aebRequestId, ...
  'AEB request ID', 'AEB request ID', ...
  'Time (s)', 'AEB request ID')



% detect time index to start ploting area of interest

for i=1 : numel(fcwDisplay)
  if fcwDisplay(i)  ~= 0
    timeIndexFcwActivation = i;
    %disp(['FCW status changed on ', num2str(timeIndex)])
    fcwTimeActivation = das_a3_Time(i);
    %disp(['FCW was activated at ', char(fcwTimeActivation)]) 
    startPlotAtTime = fcwTimeActivation - deltaTimePlot;
    startPlotAtTime = round(seconds(startPlotAtTime));
    startPlotAtTime = duration(['0:0:',num2str(startPlotAtTime)]);
    %disp(['Start plotting at ', char(startPlotAt)]) 
    break
  end
end
      %extract time index for start plot activation - window
for i=1 : numel(das_a3_Time)
  if das_a3_Time(i) >= startPlotAtTime
    startPlotAtIndex = i;
    %disp(['FCW start plot at index: ', num2str(startPlotAtIndex)])
    break
  end
end

% detect time index to stop ploting area of interest
% distant to Object transition from published to not published
aebRequested = false;
for i=1 : numel(aebRequestId)
  if aebRequestId(i) ~= 0
    aebRequested = true;
  end
  if aebRequested && (aebRequestId(i) == 0)
    timeIndexAebDeactivaded = i;
    %disp(['AEB Index DE activation 952?: ', num2str(timeIndexAebDeactivaded)])
    aebDeacticationTime = das_a3_Time(i);
    stopPlotAtTime = aebDeacticationTime + deltaTimePlot;
    stopPlotAtTime = round(seconds(stopPlotAtTime));
    stopPlotAtTime = duration(['0:0:',num2str(stopPlotAtTime)]);
    %disp(['Stop plotting at ', char(stopPlotAtTime)]) 
    
    break
  end
    %timeIndexDistancePublished = i;
    %disp(['Distance Index activation', num2str(timeIndexDistancePublished)])
    %distanceTimeActivation = das_a4_Time(i);
    %disp(['FCW was activated at ', char(fcwTimeActivation)]) 

    
  %end
end

%extract Time index for stop plotting for das_a3
for i= 1 : numel(das_a3_Time)
    if das_a3_Time(i) >= stopPlotAtTime
      stopPlotAtIndex = i;
      break
    end
end
das_a3_Time_short = das_a3_Time(startPlotAtIndex : stopPlotAtIndex);
fcwDisplay_short = fcwDisplay(startPlotAtIndex : stopPlotAtIndex);

createPlot(rowsOnPlot, columnsOnPlot, 2, ...
  das_a3_Time_short, fcwDisplay_short, ...
  'FCW State', 'FCW State', ...
  'Time (s)', 'FCW State')
aebRequestId_short = aebRequestId(startPlotAtIndex : stopPlotAtIndex);

createPlot(rowsOnPlot, columnsOnPlot, 4, ...
  das_a3_Time_short, aebRequestId_short, ...
  'AEB request ID', 'AEB request ID', ...
  'Time (s)', 'AEB request ID')

% Vehicle Speed
vehicle_speed = signalTable.ESP_A8.VEH_SPEED;
esp_a8_Time = signalTable.ESP_A8.Time;

createPlot(rowsOnPlot, columnsOnPlot, 5, ...
  esp_a8_Time, vehicle_speed, ...
  'Vehicle Speed', 'Vehicle Speed', ...
  'Time (s)', 'Speed (km/h)')

%extract time index for start plot activation - esp_a8
for i=1 : numel(esp_a8_Time)
  if esp_a8_Time(i) >= startPlotAtTime
    startPlotAtIndex = i;
    %disp(['FCW start plot at index: ', num2str(startPlotAtIndex)])
    break
  end
end
%extract Time index for stop plotting for esp_a8
for i= 1 : numel(esp_a8_Time)
    if esp_a8_Time(i) >= stopPlotAtTime
      stopPlotAtIndex = i;
      break
    end
end
esp_a8_Time_short = esp_a8_Time(startPlotAtIndex : stopPlotAtIndex);
vehicleSpeedShort = vehicle_speed(startPlotAtIndex : stopPlotAtIndex);

createPlot(rowsOnPlot, columnsOnPlot, 6, ...
  esp_a8_Time_short, vehicleSpeedShort, ...
  'Vehicle Speed', 'Vehicle Speed', ...
  'Time (s)', 'Speed (km/h)')
  
% Distance to Object
distanceToObject = signalTable.DAS_A4.ObjIntrstDist;
das_a4_Time = signalTable.DAS_A4.Time;

createPlot(rowsOnPlot, columnsOnPlot, 7, ...
  das_a4_Time, distanceToObject, ...
  'Distance to Object', 'Distance to Object', ...
  'Time (s)', 'Distance (m)')

%extract time index for start plot activation - das_a4
for i=1 : numel(das_a4_Time)
  if das_a4_Time(i) >= startPlotAtTime
    startPlotAtIndex = i;
    %disp(['FCW start plot at index: ', num2str(startPlotAtIndex)])
    break
  end
end
%extract Time index for stop plotting for das_a4
for i= 1 : numel(das_a4_Time)
    if das_a4_Time(i) >= stopPlotAtTime
      stopPlotAtIndex = i;
      break
    end
end
das_a4_Time_short = das_a4_Time(startPlotAtIndex : stopPlotAtIndex);
distanceToObjectShort = distanceToObject(startPlotAtIndex : stopPlotAtIndex);

createPlot(rowsOnPlot, columnsOnPlot, 8, ...
  das_a4_Time_short, distanceToObjectShort, ...
  'Vehicle Speed', 'Vehicle Speed', ...
  'Time (s)', 'Speed (km/h)')


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
