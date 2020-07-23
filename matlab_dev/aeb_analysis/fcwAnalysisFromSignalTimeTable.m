% This function takes a mat file that contains Signal Time Tables, it
% identifies AEB events and analyze the test validity during Vehicle
% approach.
% Signals reviewed: Pedal Accelerator Position, Vehicle Acceleration and
% Vehicle Yaw Rate.
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
% Next steps:
% Does the yaw rate goes negative?
% move the yaw rate to a different plot?
% Examples:
% Analyze a mat file stored on google drive from a Mac Computer.
%     filePath = '/Volumes/GoogleDrive/Shared drives/Vehicle Controls/[05] - Vehicle Platforms/Chrysler Pacifica/GUv0 AEB Testing-docs/1211 AEB weeks testing/';
%     fileName = '09 1211 AEB 40kph 11_24.mat';
%     dataFieldAddress = 'canLogSignalsTable.ccan_rr_log';
%     aebAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)
%
% Analyze a mat file stored on mac:
%     filePath = '/Users/cordunoalbarran/Documents/Repo/mymodels/Matlab/aeb_analysis/can_logs';
%     fileName = '5-7 P010-Drv not brk bef FCW-40 kph trial 01.mat';
%     dataFieldAddress = 'canLogSignalsTable.ccan_rr_log';
%     aebAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)
%
% Analyze a mat file stored on google driver from a Windows computer:
%     filePath = 'G:\Shared drives\Vehicle Controls\[05] - Vehicle Platforms\Chrysler Pacifica\GUv0 AEB Testing-docs\1211 AEB weeks testing';
%     fileName = '09 1211 AEB 40kph 11_24.mat';
%     dataFieldAddress = 'canLogSignalsTable.ccan_rr_log';
%     aebAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)
%
% Analyze a mat file stored on Windows computer
%     filePath = 'C:\Users\cordunoalbarran\Repo\av-control-design\dspace\lib\AEB_matlab_analysis';
%     fileName = '5-7_P010-Drv_not_brk_bef_FCW-40_kph_trial_01_ccan_rr_DATA.mat';
%     dataFieldAddress = 'SignalTable'; 
%     aebAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)
% references:
% AEB test procotol: https://docs.google.com/document/d/1pz1lNJWJckO5f-3dfKTAUUEOIpNzPw4-Id30lYpt1wo/edit#
% plot

function aebAnalysisFromSignalTimeTable(filePath, fileName, dataFieldAddress)

  fullName = fullfile(filePath, fileName);


  


  %addpath(filePath);
  aebMatFile = load(fullName);            % it contains the canLogSignalsTable

  % Find can log data location within the matfile
  ccanTableData = aebMatFile;
  if ~isempty(dataFieldAddress)
    fields = split(dataFieldAddress, '.');
    for i=1 : numel(fields)
      ccanTableData = ccanTableData.(string(fields(i)));
    end
  end

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
  minDistanceTime     = findEqualToValueTimeStamp(distanceToObjectPublished, distanceStopValue);

  approachStartTime   = minDistanceTime - approachLength;
  startPlotTime       = approachStartTime;
  stopPlotTime        = aebRequestStopTime + extendPlotTime;
  focusAreaTimeWindow = timerange(startPlotTime,stopPlotTime);

  % find Time when AEB actually starts -0.5 m/s^2.
  % AEB actuator used to shorten the acceleration vector
  aebDefaultValue       = 0;
  aebDecelStart         = -0.5;
  aebActuatorSignal     = ccanTableData.ESP_A2(:,'DAS_RqActv');
  [aebActuatorStartTime, aebActuatorStartValue, ...
    aebActuatorStopTime, aebActuatorStopValue] = ...
      signalEdgesDetection(aebActuatorSignal, aebDefaultValue );
  aebActiveTimeWindow   = timerange(aebActuatorStartTime, aebActuatorStopTime);
  vehAccelOnAebRequest  = ccanTableData.ESP_A4(aebActiveTimeWindow,'VehAccel_X');
  aebTestStartTime      = findLessThanValueTimeStamp(vehAccelOnAebRequest, aebDecelStart);

  %% Test Checks
  disp('******************************************************************************');
  disp(['**** VEHICLE AEB TEST CHECK. File: ', fileName]);
  % Vehicle Speed Max and Min during vehicle approach ESP_A8.VEH_SPEED
  testCheckTimeWindow = timerange(approachStartTime, aebTestStartTime);
  vehSpeedApproach    = ccanTableData.ESP_A8(testCheckTimeWindow, 'VEH_SPEED');

  vehicleSpeedTest    = identifyVehicleSpeedTest(vehSpeedApproach);
  vehicleSpeedCheck   = checkVehicleSpeed(vehicleSpeedTest, vehSpeedApproach);

  % Accelerator Pedal Position Check
  % Accelerator pedal position must not fluctuate more than ±5% of the full travel 
  % from the original pedal position at the start of the valid approach phase.
  %acceleratorPedalTolerance = 5; %± 5
      % ECM_A5.ActlAccelPdlPosn Check
  ecmPedalPosition    = ccanTableData.ECM_A5(testCheckTimeWindow, 'ActlAccelPdlPosn');
  ecmAccelPedalPosCheck  = checkAccelPedalPosition(ecmPedalPosition);
      % OBD Check (ISO 15031-5.4 PID 49)
  obdPedalPosition = ccanTableData.ECM_SKIM_OBD(testCheckTimeWindow, 'AccelPdlPosn_OBD');
  obdAccelPedalPosCheck = checkAccelPedalPosition(obdPedalPosition);


  % Yaw Rate Check. Tolerance %± 1 deg/s
  yawRateTolerance = 1;   
  orcYawRate    = ccanTableData.ORC_YRS_DATA(testCheckTimeWindow, 'YawRate');
  yawRateCheck  = checkVehicleYawRate(orcYawRate);



  if vehicleSpeedCheck && ecmPedalPosition && obdAccelPedalPosCheck && yawRateCheck
    disp('VALID TEST');
  else
    disp(['NOT A VALID TEST: Speed: ', num2str(vehicleSpeedCheck), ...
          ', ECM_A5 Accel Pedal: ', num2str(ecmAccelPedalPosCheck), ...
          ', OBD Accel Pedal: ', num2str(obdAccelPedalPosCheck), ...
          ', Yaw Rate: ', num2str(yawRateCheck),  ...
          ]);
  end


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
  % FCW Display - Full
  figure(plotAllData)
  hold on;
  fcwDisplayFull      =  ccanTableData.DAS_A3(:, 'As_DispRq');
  plotFcwDisplay      = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
    fcwDisplayFull.Time, fcwDisplayFull.As_DispRq, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'DAS A3.As DispRq', ...
    'Time (s)', 'FCW State');
  % FCW Display - Focus
  fcwDisplayEvent     = ccanTableData.DAS_A3(focusAreaTimeWindow,'As_DispRq');
  figure(plotFocusArea);
  hold on;
  plotFcwDisplayFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
    fcwDisplayEvent.Time, fcwDisplayEvent.As_DispRq, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'FCW Warning Status', ...
    'Time (s)', 'FCW State');

  % -------------------------------------------------------------------------
  % AEB Request Status - Full - DAS_A3.DAS_Rq_ID
  figure(plotAllData);
  hold on;
  aebRequestFull      =  ccanTableData.DAS_A3(:, 'DAS_Rq_ID');
  plotAebRequest      = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
    aebRequestFull.Time, aebRequestFull.DAS_Rq_ID, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'AEB Request Status', ...
    'Time (s)', 'AEB Status');
  % AEB Request Status - Focus Area - DAS_A3.DAS_Rq_ID
  aebRequestEvent     = ccanTableData.DAS_A3(focusAreaTimeWindow,'DAS_Rq_ID');
  figure(plotFocusArea);
  hold on;
  plotAebRequestFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
    aebRequestEvent.Time, aebRequestEvent.DAS_Rq_ID, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'AEB Request Status', ...
    'Time (s)', 'AEB Status');

  % -------------------------------------------------------------------------
  % AEB Actuator Status - Full - ESP_A2.DAS_Rq_Act
  figure(plotAllData);
  hold on;
  aebActuatorFull     =  ccanTableData.ESP_A2(:,'DAS_RqActv');
  plotAebActuator     = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
    aebActuatorFull.Time, aebActuatorFull.DAS_RqActv, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'AEB Actuator Status', ...
    'Time (s)', 'AEB Status');
  % AEB Actuator Status - Focus Area - ESP_A2.DAS_RqActv
  aebActuatorEvent    = ccanTableData.ESP_A2(focusAreaTimeWindow,'DAS_RqActv');
  figure(plotFocusArea);
  hold on;
  plotAebActuatorFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
    aebActuatorEvent.Time, aebActuatorEvent.DAS_RqActv, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'AEB Actuator Status', ...
    'Time (s)', 'AEB Status');

  % -------------------------------------------------------------------------
  % Vehicle Yaw Rate - Full - ORC_YRS_DATA.YawRate;
  figure(plotAllData);
  hold on;
  yyaxis right;
  vehicleOrcYawRateFull     =  ccanTableData.ORC_YRS_DATA(:,'YawRate');
  plotOrcYawRateFull        = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
    vehicleOrcYawRateFull.Time, vehicleOrcYawRateFull.YawRate, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'ORC Yaw Rate', ...
    'Time (s)', 'Yaw Rate deg/s');
  % Vehicle Yaw Rate - Focus Area - ORC_YRS_DATA.YawRate;
  vehicleOrcYawRateEvent    = ccanTableData.ORC_YRS_DATA(focusAreaTimeWindow,'YawRate');
  figure(plotFocusArea);
  hold on;
  yyaxis right;
  plotOrcYawRateFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
    vehicleOrcYawRateEvent.Time, vehicleOrcYawRateEvent.YawRate, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'ORC Yaw Rate', ...
    'Time (s)', 'Yaw Rate deg/s');

  % -------------------------------------------------------------------------
  % Vehicle Yaw Rate - Full - ESP_A4.VehYawRate_Raw
  figure(plotAllData);
  hold on;
  yyaxis right;
  vehicleEspYawRateFull     = ccanTableData.ESP_A4(:,'VehYawRate_Raw');
  plotEspYawRateFull        = createPlot(rowsOnFullPlot, columnsOnFullPlot, 1, ...
    vehicleEspYawRateFull.Time, vehicleEspYawRateFull.VehYawRate_Raw, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'ESP A4 Yaw Rate', ...
    'Time (s)', 'Yaw Rate deg/s');
  % Vehicle Yaw Rate - Focus Area - ESP_A4.VehYawRate_Raw
  vehicleEspYawRateEvent    = ccanTableData.ESP_A4(focusAreaTimeWindow,'VehYawRate_Raw');
  figure(plotFocusArea);
  hold on;
  yyaxis right;
  plotEspYawRateFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 1, ...
    vehicleEspYawRateEvent.Time, vehicleEspYawRateEvent.VehYawRate_Raw, ...
    'FCW State - AEB Req/Act Status - Yaw Rate', 'ESP A4 Yaw Rate', ...
    'Time (s)', 'Yaw Rate deg/s');





  % -------------------------------------------------------------------------
  plotVerticalLines(approachStartTime, aebActuatorStartTime, aebTestStartTime);


  % -------------------------------------------------------------------------
  % Vehicle Speed - Full - ESP_A8.VEH_SPEED
  figure(plotAllData);
  hold on;
  vehicleSpeedFull          = ccanTableData.ESP_A8(:,'VEH_SPEED');
  plotVehicleSpeed          = createPlot(rowsOnFullPlot, columnsOnFullPlot, 2, ...
    vehicleSpeedFull.Time, vehicleSpeedFull.VEH_SPEED, ...
    'Vehicle Speed and Acceleration', 'Vehicle Speed', ...
    'Time (s)', 'Speed km/h');
  % Vehicle Speed - Focus Area - ESP_A8.VEH_SPEED
  vehicleAccelerationEvent  = ccanTableData.ESP_A8(focusAreaTimeWindow,'VEH_SPEED');
  figure(plotFocusArea);
  hold on;
  plotVehicleSpeedFocus     = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 2, ...
    vehicleAccelerationEvent.Time, vehicleAccelerationEvent.VEH_SPEED, ...
    'Vehicle Speed and Acceleration', 'Vehicle Speed', ...
    'Time (s)', 'Speed km/h');

  % -------------------------------------------------------------------------
  % Vehicle Acceleration - Full - ESP_A4.VehAccel_X
  figure(plotAllData);
  hold on;
  yyaxis right;
  vehicleAccelerationFull       = ccanTableData.ESP_A4(:,'VehAccel_X');
  plotVehicleAcceleration       = createPlot(rowsOnFullPlot, columnsOnFullPlot, 2, ...
    vehicleAccelerationFull.Time, vehicleAccelerationFull.VehAccel_X, ...
    'Vehicle Speed and Acceleration', 'Vehicle Acceleration', ...
    'Time (s)', 'Acceleration m/s^2');
  % Vehicle Acceleration - Focus Area - ESP_A4.VehAccel_X
  vehicleAccelerationEvent      = ccanTableData.ESP_A4(focusAreaTimeWindow,'VehAccel_X');
  figure(plotFocusArea);
  hold on;
  yyaxis right;
  plotVehicleAccelerationFocus  = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 2, ...
    vehicleAccelerationEvent.Time, vehicleAccelerationEvent.VehAccel_X, ...
    'Vehicle Speed and Acceleration', 'Vehicle Acceleration', ...
    'Time (s)', 'Acceleration m/s^2');

  % -------------------------------------------------------------------------
  % Vertical Lines
  plotVerticalLines(approachStartTime, aebActuatorStartTime, aebTestStartTime);

  % -------------------------------------------------------------------------
  % OBD Accelerator Pedal Position - Full - ECM_SKIM_OBD.AccelPdlPosn_OBD
  figure(plotAllData);
  hold on;
  %yyaxis right;
  accelPedalObdFull      = ccanTableData.ECM_SKIM_OBD(:,'AccelPdlPosn_OBD');
  plotAccelPedalObdFull  = createPlot(rowsOnFullPlot, columnsOnFullPlot, 3, ...
    accelPedalObdFull.Time, accelPedalObdFull.AccelPdlPosn_OBD, ...
    'Accelerator Pedal Position & Distance to Object', 'OBD ISDO 15031 Accel Pedal Pos', ...
    'Time (s)', 'Position(%)');

  % OBD Accelerator Pedal Position - Focus Area - ECM_SKIM_OBD.AccelPdlPosn_OBD
  accelPedalObdFocus     = ccanTableData.ECM_SKIM_OBD(focusAreaTimeWindow,'AccelPdlPosn_OBD');
  figure(plotFocusArea);
  hold on;
  %yyaxis right;
  plotAccelPedalObdFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 3, ...
    accelPedalObdFocus.Time, accelPedalObdFocus.AccelPdlPosn_OBD, ...
    'Accelerator Pedal Position & Distance to Object', 'OBD ISDO 15031 Accel Pedal Pos', ...
    'Time (s)', 'Position(%)');

  % -------------------------------------------------------------------------
  % ECM_A5 Accelerator Pedal Position - Full - ECM_A5.ActlAccelPdlPosn
  figure(plotAllData);
  hold on;
  %yyaxis right;
  accelPedalEcmFull     = ccanTableData.ECM_A5(:,'ActlAccelPdlPosn');
  plotAccelPedalEcmFull = createPlot(rowsOnFullPlot, columnsOnFullPlot, 3, ...
    accelPedalEcmFull.Time, accelPedalEcmFull.ActlAccelPdlPosn, ...
    'Accelerator Pedal Position & Distance to Object', 'ECM A5 Accel Pedal Pos', ...
    'Time (s)', 'Position(%)');

  % ECM_A5 Accelerator Pedal Position - Focus Area - ECM_A5.ActlAccelPdlPosn
  accelPedalEcmFocus    = ccanTableData.ECM_A5(focusAreaTimeWindow,'ActlAccelPdlPosn');
  figure(plotFocusArea);
  hold on;
  %yyaxis right;
  plotAccelPedalEcmFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 3, ...
    accelPedalEcmFocus.Time, accelPedalEcmFocus.ActlAccelPdlPosn, ...
    'Accelerator Pedal Position & Distance to Object', 'ECM A5 Accel Pedal Pos', ...
    'Time (s)', 'Position(%)');

  % -------------------------------------------------------------------------
  % Distance To Object - Full - DAS_A4.ObjIntrstDist
  figure(plotAllData);
  hold on;
  yyaxis right;
  distanceToObjectFull      = ccanTableData.DAS_A4(:,'ObjIntrstDist');
  plotDistanceToObjectFull  = createPlot(rowsOnFullPlot, columnsOnFullPlot, 3, ...
    distanceToObjectFull .Time, distanceToObjectFull .ObjIntrstDist, ...
    'Accelerator Pedal Position & Distance to Object', 'Distance to Object', ...
    'Time (s)', 'Distance (m)');
  ylim([0 distanceStartValue + 2])    % adjust Distance to Object Scale

  % Distance To Object - Focus Area - DAS_A4.ObjIntrstDist
  distanceToObjectEvent     = ccanTableData.DAS_A4(focusAreaTimeWindow,'ObjIntrstDist');
  figure(plotFocusArea);
  hold on;
  yyaxis right;
  plotDistanceToObjectFocus = createPlot(rowsOnFocusPlot, columnsOnFocusPlot, 3, ...
    distanceToObjectEvent.Time, distanceToObjectEvent.ObjIntrstDist, ...
    'Accelerator Pedal Position & Distance to Object', 'Distance to Object', ...
    'Time (s)', 'Distance (m)');
  ylim([0 distanceStartValue + 2])    % adjust Distance to Object Scale

  % -------------------------------------------------------------------------
  plotVerticalLines(approachStartTime, aebActuatorStartTime, aebTestStartTime);



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

      %plotAttribute.DisplayName = plotLengend;
      %legend('ESP A4.VehAccel X','AEB start -0.5m/s^2');
      %verticalLine.Color = 'r';
      plotAttribute.LineWidth = 2 ;
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

  function verticalLine = plotVerticalLine(timeStamp, legendStr, lineColor)
    verticalLine             = xline(timeStamp);
    verticalLine.DisplayName = legendStr;
    verticalLine.Color       = lineColor;
    verticalLine.LineWidth   = 2;
    verticalLine.LineStyle   = '--';
  end

  function plotVerticalLines(approachStartTime, aebActuatorStartTime, aebTestStartTime)
    % Vehicle Approach Start
    lineColor = [0.3, 0.3 , 0.3];
    vehicleApproachLine = plotVerticalLine(approachStartTime, 'Vehicle Approach Start', lineColor);
  %   % AEB Actuator Active
  %   lineColor = [0.5, 0.5 , 0.5];
  %   aebActuatorActiveLine = plotVerticalLine(aebActuatorStartTime, 'AEB Actuator Active', lineColor);
    % AEB start -0.5 m/s^2 - Vertical Line
    lineColor = [1.00,0.00,1.00];
    aebTestStartLine = plotVerticalLine(aebTestStartTime, 'AEB Test Start -0.5 m/s^2', lineColor);

    % -------------------------------------------------------------------------
  end
end