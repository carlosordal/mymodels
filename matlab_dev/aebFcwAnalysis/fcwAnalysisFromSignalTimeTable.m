% FCW Analysis.
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
% - Can Data log input should have an FCW event and there shouldn't be a
% contact between the POV (Principal Other Vehicle) and the SV (Subject Vehicle).
% Examples:
% Analyze a mat file stored on google drive from a Mac Computer.
    %filePath = '/Volumes/GoogleDrive/My Drive/CAN log analysis/FCW testing/';
    %fileName = '5-7 P010-Drv Brk bef FCW 20 pct-25kph trial 01.mat';
    %fileName = '5-7 P010-Drv Brk bef FCW-20kph trial 03.mat';
    filePath = '/Volumes/GoogleDrive/Shared drives/Vehicle Controls/[05] - Vehicle Platforms/Chrysler Pacifica/GUv0 AEB Testing-docs/5-7 Pacifica AEB testing/70 kph';
               
    %fileName = '5-7 P010 -Drv brk aft FCW-70 kph trial 03 5-07-2019 1-47-59 pm.mat';
    %fileName = '5-7 P010 -Drv brk aft FCW-70 kph trial 01 5-07-2019 1-42-03 pm.mat';
    fileName = '5-7 P010 -Drv brk aft FCW-70 kph trial 02 5-07-2019 1-44-15 pm.mat';     %distance to object ok. starts at 42
    %fileName = '5-7 P010 -Drv not brk bef FCW-70 kph trial 01 5-07-2019 1-30-39 pm.mat';  %distance to object starts at 37, FCW was triggered just before that
    dataFieldAddress = 'canLogSignalsTable.ccan_rr_log';
%     fcwAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)
% references:
% FCW test procotol: https://docs.google.com/document/d/1v_sqoNpXhQZlxVPPby96P5zLXEhmausLMWLzhzJ6j-I/edit#heading=h.6z95h6k2mnwt

%function fcwAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)

  fullName = fullfile(filePath, fileName);

  %addpath(filePath);
  matFile = load(fullName);            % it contains the canLogSignalsTable

  % Find can log data location within the matfile
  ccanTableData = matFile;
  if ~isempty(dataFieldAddress)
    fields = split(dataFieldAddress, '.');
    for i=1 : numel(fields)
      ccanTableData = ccanTableData.(string(fields(i)));
    end
  end



  

%   % Find FCW Start and Stop Time
  fcwRequestId                  = ccanTableData.DAS_A3(:, 'As_DispRq');
  fcwDefaultValue       = 0;
  [fcwStartTime, fcwStartValue, ...
    fcwStopTime, fcwStopValue]  = ...
    signalEdgesDetection(fcwRequestId, fcwDefaultValue);

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
  resampleDistance = retime(distanceToObjectPublished,'regular','linear','SampleRate',200);
  
  % Find the Test start time.
  distanceTestStart = 150;      % m. Defined on FCW protocol
  vehicleSpeedTest  = 72;       % km/h. Defined on FCW protocol
  convertionToMps   = 3.6;      % m/h to m/s. 

  
  deltaDitanceToTestStart   = distanceTestStart - minDistanceValue;
  deltaTimeTestStart        = (deltaDitanceToTestStart/vehicleSpeedTest)*convertionToMps;
  deltaDurationTestStart    = duration(strcat('0:0:',num2str(deltaTimeTestStart)));
  extendPlotTime            = duration('0:0:1');
  
  % Find Time To Collision (TTC) 2.1s and the limit 90% 1.89 s
  ttc = 2.1;
  limitTtc = 1.89;    % 90% if ttc
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
    
    
  testStartTime             = minDistanceTime - deltaDurationTestStart;
  stopPlotTime              = fcwStartTime + extendPlotTime;
  focusAreaTimeWindow       = timerange(testStartTime,stopPlotTime);

%   %% Test Checks
%   disp('******************************************************************************');
%   disp(['**** VEHICLE AEB TEST CHECK. File: ', fileName]);
%   % Vehicle Speed Max and Min during vehicle approach ESP_A8.VEH_SPEED
%   testCheckTimeWindow = timerange(approachStartTime, aebTestStartTime);
%   vehSpeedApproach    = ccanTableData.ESP_A8(testCheckTimeWindow, 'VEH_SPEED');
% 
%   vehicleSpeedTest    = identifyVehicleSpeedTest(vehSpeedApproach);
%   vehicleSpeedCheck   = checkVehicleSpeed(vehicleSpeedTest, vehSpeedApproach);
% 
%   % Accelerator Pedal Position Check
%   % Accelerator pedal position must not fluctuate more than ±5% of the full travel 
%   % from the original pedal position at the start of the valid approach phase.
%   %acceleratorPedalTolerance = 5; %± 5
%       % ECM_A5.ActlAccelPdlPosn Check
%   ecmPedalPosition    = ccanTableData.ECM_A5(testCheckTimeWindow, 'ActlAccelPdlPosn');
%   ecmAccelPedalPosCheck  = checkAccelPedalPosition(ecmPedalPosition);
%       % OBD Check (ISO 15031-5.4 PID 49)
%   obdPedalPosition = ccanTableData.ECM_SKIM_OBD(testCheckTimeWindow, 'AccelPdlPosn_OBD');
%   obdAccelPedalPosCheck = checkAccelPedalPosition(obdPedalPosition);
% 
% 
%   % Yaw Rate Check. Tolerance %± 1 deg/s
%   yawRateTolerance = 1;   
%   orcYawRate    = ccanTableData.ORC_YRS_DATA(testCheckTimeWindow, 'YawRate');
%   yawRateCheck  = checkVehicleYawRate(orcYawRate);
% 
% 
% 
%   if vehicleSpeedCheck && ecmPedalPosition && obdAccelPedalPosCheck && yawRateCheck
%     disp('VALID TEST');
%   else
%     disp(['NOT A VALID TEST: Speed: ', num2str(vehicleSpeedCheck), ...
%           ', ECM_A5 Accel Pedal: ', num2str(ecmAccelPedalPosCheck), ...
%           ', OBD Accel Pedal: ', num2str(obdAccelPedalPosCheck), ...
%           ', Yaw Rate: ', num2str(yawRateCheck),  ...
%           ]);
%   end


  %% ************************ PLOTS ***********************
  % Create 2 figures. Full plot and Focus Area plot.
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
  %movegui(plotAllData,'west');
  %set(gcf, 'Position', get(0, 'Screensize'));     %figure on full screen

  % Figure: Plot Focus Area
  rowsOnFocusPlot     = rowsOnFullPlot;
  columnsOnFocusPlot  = columnsOnFullPlot;
  leftPosition = leftBorderWidth + plotWidht;
  position2 = [leftPosition,bottomOffset,plotWidht,plotHeight];
  plotFocusArea = figure('NumberTitle', 'off', 'Name', ['Focus Area Plotted: ',fileName], 'Position', position2);
  %movegui(plotFocusArea,'east');
  %set(gcf, 'Position', get(0, 'Screensize'));    % Plot on screen size

  % -------------------------------------------------------------------------
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
  figure1Title = 'FCW State - AEB Req/Act Status - Yaw Rate';
  figure1Xaxis = 'Time (s)';
  figure1Yaxis = 'FCW State';

  hold on;
  plotFcwDisplayFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
    fcwDisplayEvent.Time, fcwDisplayEvent.As_DispRq, ...
    figure1Title, 'FCW Warning Status', ...
    figure1Xaxis, figure1Yaxis);

  % -------------------------------------------------------------------------
%   % AEB Request Status - Full - DAS_A3.DAS_Rq_ID
%   figure(plotAllData);
%   hold on;
%   aebRequestFull      =  ccanTableData.DAS_A3(:, 'DAS_Rq_ID');
%   plotAebRequest      = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
%     aebRequestFull.Time, aebRequestFull.DAS_Rq_ID, ...
%     'FCW State - AEB Req/Act Status - Yaw Rate', 'AEB Request Status', ...
%     'Time (s)', 'AEB Status');
%   % AEB Request Status - Focus Area - DAS_A3.DAS_Rq_ID
%   aebRequestEvent     = ccanTableData.DAS_A3(focusAreaTimeWindow,'DAS_Rq_ID');
%   figure(plotFocusArea);
%   hold on;
%   plotAebRequestFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
%     aebRequestEvent.Time, aebRequestEvent.DAS_Rq_ID, ...
%     'FCW State - AEB Req/Act Status - Yaw Rate', 'AEB Request Status', ...
%     'Time (s)', 'AEB Status');

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

  % Vehicle Yaw Rate - Focus Area - ORC_YRS_DATA.YawRate;
  vehicleOrcYawRateEvent    = ccanTableData.ORC_YRS_DATA(focusAreaTimeWindow,'YawRate');
  figure(plotFocusArea);
  hold on;
  yyaxis right;
%   plotOrcYawRateFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
%     vehicleOrcYawRateEvent.Time, vehicleOrcYawRateEvent.YawRate, ...
%     'FCW State - AEB Req/Act Status - Yaw Rate', 'ORC Yaw Rate', ...
%     'Time (s)', 'Yaw Rate deg/s');

  % -------------------------------------------------------------------------
  % Vehicle Yaw Rate - Full - ESP_A4.VehYawRate_Raw
  figure(plotAllData);
  hold on;
  yyaxis right;
  vehicleEspYawRateFull     = ccanTableData.ESP_A4(:,'VehYawRate_Raw');
%   plotEspYawRateFull        = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
%     vehicleEspYawRateFull.Time, vehicleEspYawRateFull.VehYawRate_Raw, ...
%     'FCW State - AEB Req/Act Status - Yaw Rate', 'ESP A4 Yaw Rate', ...
%     'Time (s)', 'Yaw Rate deg/s');
  % Vehicle Yaw Rate - Focus Area - ESP_A4.VehYawRate_Raw
  vehicleEspYawRateEvent    = ccanTableData.ESP_A4(focusAreaTimeWindow,'VehYawRate_Raw');
  figure(plotFocusArea);
  hold on;
  yyaxis right;
%   plotEspYawRateFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
%     vehicleEspYawRateEvent.Time, vehicleEspYawRateEvent.VehYawRate_Raw, ...
%     'FCW State - AEB Req/Act Status - Yaw Rate', 'ESP A4 Yaw Rate', ...
%     'Time (s)', 'Yaw Rate deg/s');
  vehicleEspYawRateOffset    = ccanTableData.ESP_A4(focusAreaTimeWindow,'VehYawRate_Offset');
%   plotEspYawRateOffset = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
%   vehicleEspYawRateOffset.Time, vehicleEspYawRateOffset.VehYawRate_Offset, ...
%   'FCW State - AEB Req/Act Status - Yaw Rate', 'ESP A4 Yaw Rate Offset', ...
%   'Time (s)', 'Yaw Rate deg/s');

  vehicleEspYawRateCalc    = vehicleEspYawRateEvent.VehYawRate_Raw - vehicleEspYawRateOffset.VehYawRate_Offset;
  plotEspYawRateCalc = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
  vehicleEspYawRateOffset.Time, vehicleEspYawRateCalc, ...
  figure1Title, 'ESP A4 Yaw Rate with Offset', ...
  figure1Xaxis, 'Yaw Rate deg/s');

  % -------------------------------------------------------------------------
  plotVerticalLines(testStartTime, 'Test Start', ...
    fcwStartTime, 'FCW Warning', ...
    timeStampCollisionNominal, 'Time To Collision Nominal', ...
    timeStampCollisionLimit, 'Time To Collision Limit');

  
  


  % -------------------------------------------------------------------------
  % Vehicle Speed - Full - ESP_A8.VEH_SPEED
  figure(plotAllData);
  figure2Title = 'Vehicle Speed and Acceleration';
  figure2Xaxis = 'Time (s)';
  figure2Yaxis = 'Speed km/h';
  hold on;
  vehicleSpeedFull          = ccanTableData.ESP_A8(:,'VEH_SPEED');
  plotVehicleSpeed          = createPlot(rowsOnFullPlot, columnsOnFullPlot, 2, ...
    vehicleSpeedFull.Time, vehicleSpeedFull.VEH_SPEED, ...
    figure2Title, 'Vehicle Speed', ...
    figure2Xaxis, figure2Yaxis);
  % Vehicle Speed - Focus Area - ESP_A8.VEH_SPEED
  vehicleAccelerationEvent  = ccanTableData.ESP_A8(focusAreaTimeWindow,'VEH_SPEED');
  figure(plotFocusArea);
  hold on;
  plotVehicleSpeedFocus     = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 2, ...
    vehicleAccelerationEvent.Time, vehicleAccelerationEvent.VEH_SPEED, ...
    figure2Title, 'Vehicle Speed', ...
    figure2Xaxis, figure2Yaxis);

  % -------------------------------------------------------------------------
  % Vehicle Acceleration - Full - ESP_A4.VehAccel_X
  figure(plotAllData);
  hold on;
  yyaxis right;
  vehicleAccelerationFull       = ccanTableData.ESP_A4(:,'VehAccel_X');
  plotVehicleAcceleration       = createPlot(rowsOnFullPlot, columnsOnFullPlot, 2, ...
    vehicleAccelerationFull.Time, vehicleAccelerationFull.VehAccel_X, ...
    figure2Title, 'Vehicle Acceleration', ...
    figure2Xaxis, 'Acceleration m/s^2');

  % Vehicle Acceleration - Focus Area - ESP_A4.VehAccel_X
  vehicleAccelerationEvent      = ccanTableData.ESP_A4(focusAreaTimeWindow,'VehAccel_X');
  figure(plotFocusArea);
  hold on;
  yyaxis right;
  plotVehicleAccelerationFocus  = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 2, ...
    vehicleAccelerationEvent.Time, vehicleAccelerationEvent.VehAccel_X, ...
    figure2Title, 'Vehicle Acceleration', ...
    figure2Xaxis, 'Acceleration m/s^2');

  % -------------------------------------------------------------------------
  % Vertical Lines
  plotVerticalLines(testStartTime, 'Test Start', ...
    fcwStartTime, 'FCW Warning', ...
    timeStampCollisionNominal, 'Time To Collision Nominal', ...
    timeStampCollisionLimit, 'Time To Collision Limit');

  % -------------------------------------------------------------------------
  % OBD Accelerator Pedal Position - Full - ECM_SKIM_OBD.AccelPdlPosn_OBD
  figure(plotAllData);
  figure3Title = 'Accelerator Pedal Position & Distance to Object';
  figure3Xaxis = 'Time (s)';
  figure3Yaxis = 'Position(%)';
  hold on;
  %yyaxis right;
  accelPedalObdFull      = ccanTableData.ECM_SKIM_OBD(:,'AccelPdlPosn_OBD');
  plotAccelPedalObdFull  = createPlot(rowsOnFullPlot, columnsOnFullPlot, 3, ...
    accelPedalObdFull.Time, accelPedalObdFull.AccelPdlPosn_OBD, ...
    figure3Title, 'OBD ISDO 15031 Accel Pedal Pos', ...
    figure3Xaxis, figure3Yaxis);

  % OBD Accelerator Pedal Position - Focus Area - ECM_SKIM_OBD.AccelPdlPosn_OBD
  accelPedalObdFocus     = ccanTableData.ECM_SKIM_OBD(focusAreaTimeWindow,'AccelPdlPosn_OBD');
  figure(plotFocusArea);
  hold on;
  %yyaxis right;
  plotAccelPedalObdFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 3, ...
    accelPedalObdFocus.Time, accelPedalObdFocus.AccelPdlPosn_OBD, ...
    figure3Title, 'OBD ISDO 15031 Accel Pedal Pos', ...
    figure3Xaxis, figure3Yaxis);

  % -------------------------------------------------------------------------
  % ECM_A5 Accelerator Pedal Position - Full - ECM_A5.ActlAccelPdlPosn
  figure(plotAllData);
  hold on;
  %yyaxis right;
  accelPedalEcmFull     = ccanTableData.ECM_A5(:,'ActlAccelPdlPosn');
  plotAccelPedalEcmFull = createPlot(rowsOnFullPlot, columnsOnFullPlot, 3, ...
    accelPedalEcmFull.Time, accelPedalEcmFull.ActlAccelPdlPosn, ...
    figure3Title, 'ECM A5 Accel Pedal Pos', ...
    figure3Xaxis, figure3Yaxis);


  % ECM_A5 Accelerator Pedal Position - Focus Area - ECM_A5.ActlAccelPdlPosn
  accelPedalEcmFocus    = ccanTableData.ECM_A5(focusAreaTimeWindow,'ActlAccelPdlPosn');
  figure(plotFocusArea);
  hold on;
  %yyaxis right;
  plotAccelPedalEcmFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 3, ...
    accelPedalEcmFocus.Time, accelPedalEcmFocus.ActlAccelPdlPosn, ...
    figure3Title, 'ECM A5 Accel Pedal Pos', ...
    figure3Xaxis, figure3Yaxis);

  
  % -------------------------------------------------------------------------
  % Distance To Object - Full - DAS_A4.ObjIntrstDist
  figure(plotAllData);
  hold on;
  yyaxis right;
  distanceToObjectFull      = ccanTableData.DAS_A4(:,'ObjIntrstDist');
  plotDistanceToObjectFull  = createPlot(rowsOnFullPlot, columnsOnFullPlot, 3, ...
    distanceToObjectFull .Time, distanceToObjectFull .ObjIntrstDist, ...
    figure3Title, 'Distance to Object', ...
    figure3Xaxis, 'Distance (m)');

  ylim([0 distanceStartValue + 2])    % adjust Distance to Object Scale

  % Distance To Object - Focus Area - DAS_A4.ObjIntrstDist
  distanceToObjectEvent     = ccanTableData.DAS_A4(focusAreaTimeWindow,'ObjIntrstDist');
  figure(plotFocusArea);
  hold on;
  yyaxis right;
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
  function accelPedalPosCheck = checkAccelPedalPosition(obdPedalPosition)
    accelPedalTolerance = 5;        %± 5%
    accelPedalPosStart  = obdPedalPosition.(1)(1);
    maxPedalAccepted    = accelPedalPosStart + accelPedalTolerance;
    minPedalAccepted    = accelPedalPosStart - accelPedalTolerance;

    accelPedalPosMin    = min(obdPedalPosition.(1));
    accelPedalPosMax    = max(obdPedalPosition.(1));


    if accelPedalPosMax <= maxPedalAccepted
      maxPedalCheck = true;
    else 
      maxPedalCheck = false;
    end
    if accelPedalPosMin >= minPedalAccepted
      minPedalCheck = true;
    else 
      minPedalCheck = false;
    end

    disp(['* ACCELERERATOR PEDAL POSITION CHECK. Initial Value: ', num2str(accelPedalPosStart), '%. (Tolerance ± 5%)']);
    disp(['-- Actual Vehicle Max Accel Pedal: ', num2str(accelPedalPosMax), ', Result: ', num2str(maxPedalCheck), '. (Max Accepted: ', num2str(maxPedalAccepted),')']);
    disp(['-- Actual Vehicle Min Accel Pedal: ', num2str(accelPedalPosMin), ', Result: ', num2str(minPedalCheck), '. (Min Accepted: ', num2str(minPedalAccepted),')']);

    if maxPedalCheck && minPedalCheck
      disp('--- Accelerator Pedal Position is Valid during Vehicle Approach Phase');
      accelPedalPosCheck = true;
    else
      disp('--- Accelerator Pedal Position is NOT Valid during Vehicle Approach Phase');
      accelPedalPosCheck = false;
    end
  end

  function detectVehicleSpeedTest = identifyVehicleSpeedTest(vehicleSpeedAproach)
    vehicleSpeedMean      = mean(vehicleSpeedAproach.(1));

    if (35 < vehicleSpeedMean) && (vehicleSpeedMean < 45)
      detectVehicleSpeedTest = 40;
    elseif (15 < vehicleSpeedMean) && (vehicleSpeedMean < 25)
      detectVehicleSpeedTest = 20;
      checkVehicleSpeed(detectVehicleSpeedTest,vehicleSpeedTolerance, ...
        vehicleSpeedMax, vehicleSpeedMin);
    else 
      error('Average Vehicle Speed out of range')
    end
  end

  function vehicleSpeedCheck = checkVehicleSpeed( ...
    vehicleSpeedTest, vehicleSpeedAproach)

    vehicleSpeedTolerance = 1; %+- 1 km/h
    vehicleSpeedMin       = min(vehicleSpeedAproach.(1));
    vehicleSpeedMax       = max(vehicleSpeedAproach.(1));

    maxSpeedAccepted = vehicleSpeedTest + vehicleSpeedTolerance;
    minSpeedAccepted = vehicleSpeedTest - vehicleSpeedTolerance;
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

    disp(['* VEHICLE SPEED CHECK. TEST SPEED: ', num2str(vehicleSpeedTest), 'km/h test. (Tolerance: ± 1 km/h):']);
    disp(['-- Actual Vehicle Max Speed: ', num2str(vehicleSpeedMax), ', Result: ', num2str(maxSpeedCheck), '. (Max Accepted: ', num2str(maxSpeedAccepted),')']);
    disp(['-- Actual Vehicle Min Speed: ', num2str(vehicleSpeedMin), ', Result: ', num2str(minSpeedCheck), '. (Min Accepted: ', num2str(minSpeedAccepted),')']);
    if maxSpeedCheck && minSpeedCheck
      disp('--- Speed Check is Valid during Vehicle Approach Phase');
      vehicleSpeedCheck = true;
    else
      disp('--- Speed Check is NOT Valid during Vehicle Approach Phase');
      vehicleSpeedCheck = false;
    end

  end

  function yawRateCheck = checkVehicleYawRate(vehicleYawRateTable)
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

    disp('* VEHICLE YAW RATE CHECK. (Tolerance: ± 1 deg/s):');
    disp(['-- Actual Vehicle Max Yaw Rate: ', num2str(vehicleYawRateMax), ', Result: ', num2str(maxYawRateCheck), '. (Max Accepted: ', num2str(maxYawRateAccepted),')']);
    disp(['-- Actual Vehicle Min Yaw Rate: ', num2str(vehicleYawRateMin), ', Result: ', num2str(minYawRateCheck), '. (Min Accepted: ', num2str(minYawRateAccepted),')']);
    if maxYawRateCheck && minYawRateCheck
      disp('--- Speed Check is Valid during Vehicle Approach Phase');
      yawRateCheck = true;
    else
      disp('--- Speed Check is NOT Valid during Vehicle Approach Phase');
      yawRateCheck = false;
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
  end

  function plotVerticalLines(line1TimeStamp, line1Legend, ...
    line2TimeStamp, line2Legend, ...
    line3TimeStamp, line3Legend, ...
    line4TimeStamp, line4Legend)
    % Vertical line 1 - gray
    lineColor = [0.3, 0.3 , 0.3];
    lineStyle = '--';
    plotVerticalLine(line1TimeStamp, line1Legend, lineColor, lineStyle);
    % Vertical Line 2 - purple; pink [1.00,0.00,1.00];
    lineColor = [0.4940, 0.1840, 0.5560];
    lineStyle = ':';
    plotVerticalLine(line2TimeStamp, line2Legend, lineColor, lineStyle);
    % Vertical Line 3 - green
    % dark orange [0.91 0.41 0.17]
    lineColor = [0 0.5 0];

    lineStyle = '-.';
    plotVerticalLine(line3TimeStamp, line3Legend, lineColor, lineStyle);
    % Vertical Line 4 - red
    lineColor = [1 0 0];
    lineStyle = '-.';
    plotVerticalLine(line4TimeStamp, line4Legend, lineColor, lineStyle);
    
    

    % -------------------------------------------------------------------------
  end
%end