% FCW Analysis.
% Next steps:
% declare tolerances and speed on a single place,
% transpose results table?
% add checks for max and min values.
% Display check's report needs to be converted to delta time, in order to
% compare it with 2.1 s.
% Fill in the rest of the checks.
% create a final struct in order to add information, file name to the
% report.
% do I need to plot the delta of vehicle speed and yaw rate for the result?
%
%
% Inputs:   1) filePath         - String that contains the file Path
%           2) fileName         - String that contains the file Name with extension.
%           3) dataFieldAddress - String that contains the field names 
%                                 separated by "." and indicates the
%                                 address of the Signal Time Table that will be
%                                 analyzed. If the data is stored on the
%                                 root of the mat file use dataFieldAddress
%                                 = '';
% Outputs:  1) Plots and Checks results displayed on Matlab terminal.
%
% Requirements:
% - Can Data log input should have an FCW event.
% Examples:
% Analyze a mat file stored on google drive from a Mac Computer.
    filePath = '/Volumes/GoogleDrive/Shared drives/Vehicle Controls/[05] - Vehicle Platforms/Chrysler Pacifica/GUv0 AEB Testing-docs/5-7 Pacifica AEB testing/70 kph';

    %fileName = '5-7 P010 -Drv brk aft FCW-70 kph trial 01 5-07-2019 1-42-03 pm.mat';
    fileName = '5-7 P010 -Drv brk aft FCW-70 kph trial 02 5-07-2019 1-44-15 pm.mat';     %distance to object ok. starts at 42, 68 kph at FCW actication.
    %fileName = '5-7 P010 -Drv brk aft FCW-70 kph trial 03 5-07-2019 1-47-59 pm.mat';  % FCW activated at 67 kph. FCW ok.
    %fileName = '5-7 P010 -Drv not brk bef FCW-70 kph trial 01 5-07-2019 1-30-39 pm.mat';  %distance to object starts at 37, FCW was triggered just before that. 66 kph at the moment of FCW activation
    dataFieldAddress = 'canLogSignalsTable.ccan_rr_log';
%     fcwAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)
% references:
% FCW test procotol: https://docs.google.com/document/d/1v_sqoNpXhQZlxVPPby96P5zLXEhmausLMWLzhzJ6j-I/edit#heading=h.6z95h6k2mnwt

%function fcwAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)

  fullName = fullfile(filePath, fileName);

  matFile = load(fullName);            % it contains the canLogSignalsTable

  % Find can log data location within the matfile
  ccanTableData = matFile;
  if ~isempty(dataFieldAddress)
    fields = split(dataFieldAddress, '.');
    for i=1 : numel(fields)
      ccanTableData = ccanTableData.(string(fields(i)));
    end
  end

  %% Locate Point of Intereres and Calculates TTC
%   % Find FCW Start and Stop Time
  fcwDisplayRequest = ccanTableData.DAS_A3(:, 'As_DispRq');
  fcwDefaultValue   = 0;
  [fcwStartTime, fcwStartValue, ...
    fcwStopTime, fcwStopValue]  = ...
    signalEdgesDetection(fcwDisplayRequest, fcwDefaultValue);

  % detect Distance to Object Stop being published
  distanceToObject      = ccanTableData.DAS_A4(:, 'ObjIntrstDist');
  distanceDefaultValue  = 254;
  [distanceStartTime, distanceStartValue, ...
    lastDistanceTime, minDistanceValue] = ...
    signalEdgesDetection(distanceToObject, distanceDefaultValue);

  % find initial Time when the minimum distance was reported.
  distanceTimeWindow        = timerange(distanceStartTime, lastDistanceTime);
  distanceToObjectPublished = distanceToObject(distanceTimeWindow,:);
  minDistanceTime           = findEqualToValueTimeStamp(distanceToObject, minDistanceValue);
  
  %resample Distance To Object
  resampleDistance  = retime(distanceToObjectPublished,'regular','linear','SampleRate',200);
  
  % Find the Test start time.
  distanceTestStart = 150;      % units: m. Defined on FCW protocol
  vehicleSpeedTest  = 72;       % units: km/h. Defined on FCW protocol
  convertionToMps   = 3.6;      % m/h to m/s. 

  
  % Find Distance to Test Start from First Distance to Object known
  deltaDistanceToTestStart = distanceTestStart - distanceStartValue;
  % calculate delta time to Test Start based on vehicle speed of 72 km/h
  deltaTimeTestStart      = (deltaDistanceToTestStart/vehicleSpeedTest)*convertionToMps;
  deltaDurationTestStart  = duration(strcat('0:0:',num2str(deltaTimeTestStart)));
  extendPlotTime          = duration('0:0:0.5');
  
  % Find Time To Collision (TTC) 2.1s and the limit 90% 1.89 s
  ttc       = 2.1;
  limitTtc  = 1.89;    % 90% if ttc
  distanceToCollisionNominal  = (vehicleSpeedTest * ttc)/convertionToMps;
  distanceToCollisionLimit    = (vehicleSpeedTest * limitTtc)/convertionToMps;
  
  % Detect if the distance to Collision Limit is part of the CAN publication
  if distanceToCollisionLimit < distanceStartValue
    disp('TTC published on CAN');
      %find Time Stamp of distanceCollisionLimit on resampled ObjIntrstDist
    timeIndexCollisionLimit = find((resampleDistance.ObjIntrstDist-distanceToCollisionLimit)<10^-1,1,'first');
    timeStampCollisionLimit = resampleDistance.Time(timeIndexCollisionLimit);

  else
    %vehicle speed at First Distance Published.
    disp(['** TTC limit was''not published. First Value: ', num2str(distanceStartValue)]);
      % Calculate timeStampCollisionLimit if distanceToCollisionLimit is
      % greater than values published, based on vehicle speed and distance
      % missing.
    minMissingDistance = distanceToCollisionLimit - distanceStartValue;
    minMissingTime = (minMissingDistance * convertionToMps)/vehicleSpeedTest;
    timeStampCollisionLimit = distanceToObjectPublished.Time(1) - duration(strcat('0:0:', num2str(minMissingTime)));

  end
  
  
  % Detect if the distance to Collision Nominal is part of the CAN publication
  if distanceToCollisionNominal < distanceStartValue
    % find Time Stamp of distanceCollisionNominal on resampled ObjIntrstDist
    timeIndexCollisionNominal = find((resampleDistance.ObjIntrstDist-distanceToCollisionNominal)<10^-1,1,'first');
    timeStampCollisionNominal = resampleDistance.Time(timeIndexCollisionNominal);
  else
      % Calculate timeStampCollisionNominal if distanceToCollisionLimit is
      % greater than values published, based on vehicle speed and distance
      % missing.
    minMissingDistance = distanceToCollisionNominal - distanceStartValue;
    minMissingTime = (minMissingDistance * convertionToMps)/vehicleSpeedTest;
    timeStampCollisionNominal = distanceToObjectPublished.Time(1) - duration(strcat('0:0:', num2str(minMissingTime)));
  end
    
    
  testStartTime             = distanceStartTime - deltaDurationTestStart;
  stopPlotTime              = fcwStartTime + extendPlotTime;
  focusAreaTimeWindow       = timerange(testStartTime,stopPlotTime);
  
  %% Create Table for final results

fcwChecksTable = table('Size',[3 8],'VariableTypes',{'double',...
  'double', 'double', 'logical', ...
  'double', 'double', 'logical', ...
  'logical'});
fcwChecksTable.Properties.VariableNames = {'Tolerance', ...
  'Max_Valid', 'Max_Actual', 'Is_Max_Valid', ...
  'Min_Valid', 'Min_Actual', 'Is_Min_Valid', ...
  'Result'};
fcwChecksTable.Properties.RowNames = { ...
  'FCW Veh Speed Check (km/h)', ...
  'FCW Veh Yaw Rate (deg/s)', ...
  'FCW Warning Displayed On Time'};


  %% Test Checks
  disp('******************************************************************************');
  disp(['**** VEHICLE FCW TEST CHECK. File: ', fileName]);
  % Vehicle Speed Max and Min during vehicle approach ESP_A8.VEH_SPEED
  % The SV vehicle speed cannot deviate from the nominal speed by more than 
  % 1.0 mph (1.6 km/h) for a period of 3.0 seconds prior to (1) the required 
  % FCW alert or (2) before the range falls to less than 90 percent of the 
  % minimum allowable range for onset of the required FCW alert.
  speedWindowCheck    = duration('0:0:03');
  timeStartCheckSpeed = timeStampCollisionLimit - speedWindowCheck;
  testSpeedWindow     = timerange(timeStartCheckSpeed, timeStampCollisionLimit);
  vehSpeedApproach    = ccanTableData.ESP_A8(testSpeedWindow, 'VEH_SPEED');
  [vehicleSpeedCheck, fcwChecksTable]   = fcwVehicleSpeedCheck(vehSpeedApproach, fcwChecksTable);



  % Yaw Rate Check. Tolerance %± 1 deg/s, ESP_A4.VehYawRate_Raw & Offset
  % The yaw rate of the SV must not exceed ±1.0 deg/sec during the test.
  yawRateTolerance  = 1;   
  
  vehicleEspYawRateEvent      = ccanTableData.ESP_A4(focusAreaTimeWindow,'VehYawRate_Raw');
  vehicleEspYawRateOffset     = ccanTableData.ESP_A4(focusAreaTimeWindow,'VehYawRate_Offset');
  vehicleEspYawRateWithOffset = vehicleEspYawRateEvent.VehYawRate_Raw - vehicleEspYawRateOffset.VehYawRate_Offset;
  yawRateWithOffset = timetable(vehicleEspYawRateEvent.Time, vehicleEspYawRateWithOffset);
  
  [yawRateCheck, fcwChecksTable]      = checkVehicleYawRate(yawRateWithOffset, fcwChecksTable);

  % Was the FCW displayed on time
  
%   if timeStampCollisionLimit > fcwStartTime
%     disp('-- FCW Warning Displayed on time');
%     fcwDisplayCheck =  true;
%   else
%     disp('-- FCW Warning NOT Displayed on time');
%     fcwDisplayCheck =  false;
%   end


%   if vehicleSpeedCheck && yawRateCheck && fcwDisplayCheck
%     disp('VALID TEST');
%   else
%     disp(['NOT A VALID TEST: Speed Check: ', num2str(vehicleSpeedCheck), ...
%           ', Yaw Rate Check: ', num2str(yawRateCheck),  ...
%           ', FCW Displayed Check: ', num2str(fcwDisplayCheck),  ...
%           ]);
%   end
  
  ttcCheckRowName = 'FCW Warning Displayed On Time';
%   fcwChecksTable{ttcCheckRowName, 'Tolerance'}     = yawRateTolerance;
%   fcwChecksTable{ttcCheckRowName, 'Max_Valid'}     = maxYawRateAccepted;
%   fcwChecksTable{ttcCheckRowName, 'Max_Actual'}    = vehicleYawRateMax;
%   fcwChecksTable{ttcCheckRowName, 'Is_Max_Valid'}  = maxYawRateCheck;
  fcwChecksTable{ttcCheckRowName, 'Min_Valid'}     = limitTtc;
  %fcwChecksTable{ttcCheckRowName, 'Min_Actual'}    = vehicleYawRateMin;
  fcwChecksTable{ttcCheckRowName, 'Is_Min_Valid'}  = fcwDisplayCheck;
  fcwChecksTable{ttcCheckRowName, 'Result'}        = fcwDisplayCheck;




    ttc       = 2.1;
  limitTtc  = 1.89; 

  %% ************************ PLOTS ***********************
  % Create 2 figures: Full plot and Focus Area plot.
  % Figure: Plot All Data
  rowsOnFullPlot      = 3;
  columnsOnFullPlot   = 1;
  bottomBorderWidth = 150;
  leftBorderWidth = 10;
  bottomOffset = 50;
  set(0,'Units','pixels');
  screensize = get(0,'ScreenSize');
  plotHeight = screensize(4)-bottomBorderWidth;
  plotWidht = screensize(3)/2- leftBorderWidth;
  position = [leftBorderWidth,bottomOffset,plotWidht,plotHeight]; %[left bottom width height]
  plotAllData = figure('NumberTitle', 'off', 'Name', ['All Data Plotted: ',fileName], 'Position', position);

  % Figure: Plot Focus Area
  rowsOnFocusPlot     = rowsOnFullPlot;
  columnsOnFocusPlot  = columnsOnFullPlot;
  leftPosition = leftBorderWidth + plotWidht;
  position2 = [leftPosition,bottomOffset,plotWidht,plotHeight];
  plotFocusArea = figure('NumberTitle', 'off', 'Name', ['Focus Area Plotted: ',fileName], 'Position', position2);
  %movegui(plotFocusArea,'east');
  %set(gcf, 'Position', get(0, 'Screensize'));    % Plot on screen size

  % -----------------------------------------------------------------------
  % PLOT 1
  % FCW Display - Full - DAS_A3.As_DispRq
  figure(plotAllData)
  hold on;
  fcwDisplayFull      =  ccanTableData.DAS_A3(:, 'As_DispRq');
  plotFcwDisplay      = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
    fcwDisplayFull.Time, fcwDisplayFull.As_DispRq, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'DAS A3.As DispRq', ...
    'Time (s)', 'FCW State');
  % FCW Display - Focus - DAS_A3.As_DispRq
  fcwDisplayEvent     = ccanTableData.DAS_A3(focusAreaTimeWindow,'As_DispRq');
  figure(plotFocusArea);
  figure1Title = 'FCW State - FCW Warning Status & Yaw Rate (with offset)';
  figure1Xaxis = 'Time (s)';
  figure1Yaxis = 'FCW State';

  hold on;
  plotFcwDisplayFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
    fcwDisplayEvent.Time, fcwDisplayEvent.As_DispRq, ...
    figure1Title, 'FCW Warning Status', ...
    figure1Xaxis, figure1Yaxis);

  % -------------------------------------------------------------------------
  % Vehicle Yaw Rate - Full - ORC_YRS_DATA.YawRate;
  figure(plotAllData);
  hold on;
  yyaxis right;
  vehicleOrcYawRateFull     =  ccanTableData.ORC_YRS_DATA(:,'YawRate');
  plotOrcYawRateFull        = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
    vehicleOrcYawRateFull.Time, vehicleOrcYawRateFull.YawRate, ...
    figure1Title, 'ORC Yaw Rate', ...
    figure1Xaxis, 'Yaw Rate deg/s');

  % Vehicle Yaw Rate - Focus - ESP_A4.VehYawRate_Raw and Offset calculus

  figure(plotFocusArea);
  hold on;
  yyaxis right;

  plotEspYawRateCalc        = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
  vehicleEspYawRateOffset.Time, vehicleEspYawRateWithOffset, ...
  figure1Title, 'ESP A4 Yaw Rate with Offset', ...
  figure1Xaxis, 'Yaw Rate deg/s');

  % -----------------------------------------------------------------------
  % Vertical lines
  plotVerticalLines(testStartTime, 'Test Start', ...
    fcwStartTime, 'FCW Warning', ...
    timeStampCollisionNominal, 'Time To Collision Nominal', ...
    timeStampCollisionLimit, 'Time To Collision Limit');
  % Horizontal lines
  maxYawRateLimit = yline(1,':','LineWidth',2);
  maxYawRateLimit.DisplayName = 'Max Yaw Rate Limit';
  minYawRateLimit = yline(-1,'-.','LineWidth',2);
  minYawRateLimit.DisplayName = 'Min Yaw Rate Limit';
  ylim([-1.1, 1.1])    % adjust Vehicle Speed axis

  % -----------------------------------------------------------------------
  % PLOT 2

  figure(plotAllData);
  figure2Title = 'Vehicle Speed';
  figure2Xaxis = 'Time (s)';
  figure2Yaxis = 'Speed (km/h)';
  
  % Vehicle Speed - Full - ESP_A8.VEH_SPEED
  hold on;
  vehicleSpeedFull          = ccanTableData.ESP_A8(:,'VEH_SPEED');
  plotVehicleSpeed          = createPlot(rowsOnFullPlot, columnsOnFullPlot, 2, ...
    vehicleSpeedFull.Time, vehicleSpeedFull.VEH_SPEED, ...
    figure2Title, 'Vehicle Speed', ...
    figure2Xaxis, figure2Yaxis);
  
  % Vehicle Speed - Focus Area - ESP_A8.VEH_SPEED
  vehicleSpeedEvent  = ccanTableData.ESP_A8(focusAreaTimeWindow,'VEH_SPEED');
  vehicleSpeedAtFcwLimitIndex = find((timeStampCollisionLimit - vehicleSpeedEvent.Time)< duration('0:0:0.01'), 1, 'first');
  vehicleSpeedAtFcwLimit      = vehicleSpeedEvent.VEH_SPEED(vehicleSpeedAtFcwLimitIndex);

  figure(plotFocusArea);
  hold on;
  plotVehicleSpeedFocus     = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 2, ...
    vehicleSpeedEvent.Time, vehicleSpeedEvent.VEH_SPEED, ...
    figure2Title, 'Vehicle Speed', ...
    figure2Xaxis, figure2Yaxis);


  % -----------------------------------------------------------------------
  % Vertical Lines
  plotVerticalLines(testStartTime, 'Test Start', ...
    fcwStartTime, 'FCW Warning', ...
    timeStampCollisionNominal, 'Time To Collision Nominal', ...
    timeStampCollisionLimit, 'Time To Collision Limit');
  
  % Horizontal lines
  maxSpeedLineLimit = yline(73.6,':','LineWidth',2);
  maxSpeedLineLimit.DisplayName = 'Max Speed Limit';
  minSpeedLineLimit = yline(70.4,'-.','LineWidth',2);
  minSpeedLineLimit.DisplayName = 'Min Speed Limit';
  
  
  % -----------------------------------------------------------------------
  % PLOT 3
  figure(plotAllData);
  figure3Title = 'Distance to Object';
  figure3Xaxis = 'Time (s)';
  figure3Yaxis = 'Position(%)';
  
  % Distance To Object - Full - DAS_A4.ObjIntrstDist
  figure(plotAllData);
  hold on;
  %yyaxis right;
  distanceToObjectFull      = ccanTableData.DAS_A4(:,'ObjIntrstDist');
  plotDistanceToObjectFull  = createPlot(rowsOnFullPlot, columnsOnFullPlot, 3, ...
    distanceToObjectFull.Time, distanceToObjectFull .ObjIntrstDist, ...
    figure3Title, 'Distance to Object', ...
    figure3Xaxis, 'Distance (m)');



  % Distance To Object - Focus Area - DAS_A4.ObjIntrstDist
  distanceToObjectEvent     = ccanTableData.DAS_A4(focusAreaTimeWindow,'ObjIntrstDist');
  figure(plotFocusArea);
  hold on;
  %yyaxis right;
  plotDistanceToObjectFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 3, ...
    distanceToObjectEvent.Time, distanceToObjectEvent.ObjIntrstDist, ...
    figure3Title, 'Distance to Object', ...
    figure3Xaxis, 'Distance (m)');

  ylim([0 distanceStartValue + 2])    % adjust Distance to Object Scale

  % -------------------------------------------------------------------------
  plotVerticalLines(testStartTime, 'Test Start', ...
    fcwStartTime, 'FCW Warning', ...
    timeStampCollisionNominal, 'Time To Collision Nominal', ...
    timeStampCollisionLimit, 'Time To Collision Limit');



  %% Functions

  function [vehicleSpeedCheck,  fcwChecksTable] = fcwVehicleSpeedCheck(vehicleSpeedAproach, fcwChecksTable)
    fcwVehicleSpeedRequired = 72; %72 km/h
    vehicleSpeedTolerance = 1.6; %± 1.6 km/h
    vehicleSpeedMin       = min(vehicleSpeedAproach.(1));
    vehicleSpeedMax       = max(vehicleSpeedAproach.(1));

    maxSpeedAccepted = fcwVehicleSpeedRequired + vehicleSpeedTolerance;
    minSpeedAccepted = fcwVehicleSpeedRequired - vehicleSpeedTolerance;
    if vehicleSpeedMax <= maxSpeedAccepted
      maxSpeedCheck = true;
    else 
      maxSpeedCheck = false;
    end
    if vehicleSpeedMin >= minSpeedAccepted
      minSpeedCheck = true;
    else 
      minSpeedCheck = false;
    end
    
    
%     disp('* FCW VEHICLE SPEED CHECK. TEST SPEED 72 km/h. (Tolerance: ± 1.6 km/h):');
%     disp(['-- Actual Vehicle Max Speed: ', num2str(vehicleSpeedMax), ', Result: ', num2str(maxSpeedCheck), '. (Max Accepted: ', num2str(maxSpeedAccepted),')']);
%     disp(['-- Actual Vehicle Min Speed: ', num2str(vehicleSpeedMin), ', Result: ', num2str(minSpeedCheck), '. (Min Accepted: ', num2str(minSpeedAccepted),')']);
    if maxSpeedCheck && minSpeedCheck
%       disp('--- Speed Check is Valid during Vehicle Approach Phase');
      vehicleSpeedCheck = true;
    else
%       disp('--- Speed Check is NOT Valid during Vehicle Approach Phase');
      vehicleSpeedCheck = false;
    end
    vehCheckRowName = 'FCW Veh Speed Check (km/h)';
    fcwChecksTable{vehCheckRowName, 'Tolerance'}     = vehicleSpeedTolerance;
    fcwChecksTable{vehCheckRowName, 'Max_Valid'}     = maxSpeedAccepted;
    fcwChecksTable{vehCheckRowName, 'Max_Actual'}    = vehicleSpeedMax;
    fcwChecksTable{vehCheckRowName, 'Is_Max_Valid'}  = maxSpeedCheck;
    fcwChecksTable{vehCheckRowName, 'Min_Valid'}     = minSpeedAccepted;
    fcwChecksTable{vehCheckRowName, 'Min_Actual'}    = vehicleSpeedMin;
    fcwChecksTable{vehCheckRowName, 'Is_Min_Valid'}  = minSpeedCheck;
    fcwChecksTable{vehCheckRowName, 'Result'}        = vehicleSpeedCheck;
  end

  function [yawRateCheck, fcwChecksTable] = checkVehicleYawRate(vehicleYawRateTable, fcwChecksTable)
    yawRateTolerance      = 1;        %+- 1 deg/s     
    vehicleYawRateMin     = min(vehicleYawRateTable.(1));
    vehicleYawRateMax     = max(vehicleYawRateTable.(1));

    maxYawRateAccepted = yawRateTolerance;
    minYawRateAccepted = yawRateTolerance * -1;
    if vehicleYawRateMax <= maxYawRateAccepted
      maxYawRateCheck = true;
    else 
      maxYawRateCheck = false;
    end

    if vehicleYawRateMin >= minYawRateAccepted
      minYawRateCheck = true;
    else 
      minYawRateCheck = false;
    end

%     disp('* FCW VEHICLE YAW RATE CHECK. (Tolerance: ± 1 deg/s):');
%     disp(['-- Actual Vehicle Max Yaw Rate: ', num2str(vehicleYawRateMax), ', Result: ', num2str(maxYawRateCheck), '. (Max Accepted: ', num2str(maxYawRateAccepted),')']);
%     disp(['-- Actual Vehicle Min Yaw Rate: ', num2str(vehicleYawRateMin), ', Result: ', num2str(minYawRateCheck), '. (Min Accepted: ', num2str(minYawRateAccepted),')']);
    if maxYawRateCheck && minYawRateCheck
%       disp('--- Yaw Rate is Valid during Vehicle Approach Phase');
      yawRateCheck = true;
    else
%       disp('--- Yaw Rate is NOT Valid during Vehicle Approach Phase');
      yawRateCheck = false;
    end
    
    yawCheckRowName = 'FCW Veh Yaw Rate (deg/s)';
    fcwChecksTable{yawCheckRowName, 'Tolerance'}     = yawRateTolerance;
    fcwChecksTable{yawCheckRowName, 'Max_Valid'}     = maxYawRateAccepted;
    fcwChecksTable{yawCheckRowName, 'Max_Actual'}    = vehicleYawRateMax;
    fcwChecksTable{yawCheckRowName, 'Is_Max_Valid'}  = maxYawRateCheck;
    fcwChecksTable{yawCheckRowName, 'Min_Valid'}     = minYawRateAccepted;
    fcwChecksTable{yawCheckRowName, 'Min_Actual'}    = vehicleYawRateMin;
    fcwChecksTable{yawCheckRowName, 'Is_Min_Valid'}  = minYawRateCheck;
    fcwChecksTable{yawCheckRowName, 'Result'}        = yawRateCheck;

  end

  function plotAttribute = createPlot(rowsOnPlot, columnsOnPlot, position,...
    xValues, yValues,...
    plotTitle, plotLengend, ...
    xPlotLabel, yPlotLabel)
      subplot(rowsOnPlot, columnsOnPlot, position)
      legend('-DynamicLegend');

      plotAttribute = plot(xValues, yValues, 'DisplayName',plotLengend);
      legend show;
      legend('location', 'south');

      plotAttribute.LineWidth = 2 ;

      title(plotTitle) % title
      xlabel(xPlotLabel) % label for x axis
      ylabel(yPlotLabel) % label for y axis



  end

  function [edgeStartTime, edgeStartValue, edgeStopTime, edgeStopValue] = ...
    signalEdgesDetection(signalData, initialValue)
  % this function detect edges from initial value and returning to the
  % initial value.
  % __/x----x\__ or ---\x____x/----.
  % Input (1) timeTable singal with variable of interest on position 1.
    edgeDetected = false;
    variableName = inputname(1);
    for i=1 : numel(signalData)
      if (signalData.(1)(i) ~= initialValue) && ~edgeDetected   %find change in original value
        edgeDetected = true;
        edgeStartTime = signalData.Time(i);
        edgeStartValue = signalData.(1)(i);
      elseif edgeDetected == false 
        edgeStartTime = {};
      end
      if (signalData.(1)(i) == initialValue) && edgeDetected      
        edgeStopTime = signalData.Time(i-1);
        edgeStopValue = signalData.(1)(i-1);
        break
      else
        edgeStopTime = {};
      end
    end
    if isempty(edgeStopTime) || isempty (edgeStartTime)
      error(['Rising/Falling Edges not found for: ', variableName]);
    end
  end

  function timeStamp = findEqualToValueTimeStamp(signalTimeTable, value)
    variableName = inputname(1);
    for i=1 : numel(signalTimeTable)
      if signalTimeTable.(1)(i) == value
        timeStamp = signalTimeTable.Time(i);
        break
      else
        timeStamp = {};
      end
    end
    if isempty(timeStamp)
      error(['Equal Value not found for : ', variableName]);
    end
  end

  function timeStamp = findLessThanValueTimeStamp(signalTimeTable, value)
    variableName = inputname(1);
    for i=1 : numel(signalTimeTable)
      if signalTimeTable.(1)(i) < value
        timeStamp = signalTimeTable.Time(i);
        break
      else
        timeStamp = {};
      end
    end
    if isempty(timeStamp)
      error(['Value Less Than: ', num2str(value),' not found for: ', variableName]);
    end
  end

  function plotVerticalLine(timeStamp, legendStr, lineColor, lineStyle)
    verticalLine             = xline(timeStamp);
    verticalLine.DisplayName = legendStr;
    verticalLine.Color       = lineColor;
    verticalLine.LineWidth   = 2;
    verticalLine.LineStyle   = lineStyle;
    verticalLine.Label = seconds(timeStamp);
    %verticalLine.LabelHorizontalAlignment = 

  end

  function plotVerticalLines(line1TimeStamp, line1Legend, ...
    line2TimeStamp, line2Legend, ...
    line3TimeStamp, line3Legend, ...
    line4TimeStamp, line4Legend)
    % Vertical line 1 - green
    lineColor = [0 0.5 0];

    lineStyle = '--';
    plotVerticalLine(line1TimeStamp, line1Legend, lineColor, lineStyle);
    % Vertical Line 2 - purple; pink [1.00,0.00,1.00];
    lineColor = [0.4940, 0.1840, 0.5560];
    lineStyle = ':';
    plotVerticalLine(line2TimeStamp, line2Legend, lineColor, lineStyle);
    % Vertical Line 3 - gray
    % dark orange [0.91 0.41 0.17]
    %lineColor = [0.3, 0.3 , 0.3]; %gray
    lineColor = [0.8 0.41 0.17];  %orange

    lineStyle = '-.';
    plotVerticalLine(line3TimeStamp, line3Legend, lineColor, lineStyle);
    % Vertical Line 4 - red
    lineColor = [1 0 0];
    lineStyle = '-.';
    plotVerticalLine(line4TimeStamp, line4Legend, lineColor, lineStyle);
    
    

    % -------------------------------------------------------------------------
  end
%end