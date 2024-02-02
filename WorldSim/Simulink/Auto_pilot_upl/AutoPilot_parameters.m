% @File      : AutoPilot_parameters.m
% @Contact   : info@vi-grade.com
% @License   : PROPRIETARY/CONFIDENTIAL (https://www.vi-grade.com/license.txt)
% @Copyright : (c) 2006-2023, VI-grade GmbH, Darmstadt, Germany, All Rights Reserved
% ----------------------------------------------------------------------------------
%% defining Simulink variables
 
Lane_Width = 3.7 ; % Target In Lane Width (m)
radar_source = 2;
No_Target_Display_Value = 0 ; % Value to send to scaner when no target is present
ADAS_Control_Mode = 1 ;
 
% filtering function coefficients
Wn = 1/500;                   % Normalized cutoff frequency
[butter_b,butter_a] = butter(2,Wn,'low');  % Butterworth filter
 
% Dimension of the vehicle used. In demo the Mercedes E class
% vehicle_width = 1.86;
vehicle_width = 2.2; %Added margins
vehicle_length = 4.7;
 
% basic target speed. this will be override later for DoE
target_speed = 120;
 
%% Adaptive Cruise Control
ACC_Module_Activity_Flag = 1 ;
 
ACC_Ready_Speed = 30 ; % (km/h) Speed above which ACC is available
ACC_MaxThrottle = 130 ;
ACC_MaxBrake = 50 ;
ACC_SensorMaxDistance = 250 ; %(m)
ACC_Speed_Distance_Gain = [0.1 0.15 0.2 0.25] ; %4 values for 4 distance possible(m/km/h)
ACC_Speed_Distance_control = 3; %to select the gain to control distance to front car. 3 is default
% Classic cruise control controller
ACC_Classic_P = 15 ;
ACC_Classic_I = 5 ;
% Adaptive cruise control controller
ACC_Adaptive_P = [5 7.5] ;
ACC_Adaptive_I = 0 ;
ACC_Adaptive_D = 0 ;
 
%% Auto Pilot
AP_Activity_Flag = 1 ;
try
    AP_Freq_Hz = Sensor_Freq_worldsim ;
catch
    Sensor_Freq_worldsim = 50; %Default
    AP_Freq_Hz = Sensor_Freq_worldsim; 
end
AP_P = [0.2 0.2] ;
AP_I = [0.05 0.05] ;
AP_D = [0.3 0.3] ;
AP_Dyn_Rate_Limiter_Gain = 0.1 ;
AP_Dyn_Rate_Limiter_Power = 10 ;
AP_Error_Max = 3 ;
AP_Steer_Rate_Max_radps = 1 ; % (rad/s)
AP_Max_Error_dydt_Disable = 0.5 ;
AP_Transition_Rate = 0.5 ;
AP_Steer_Error_Max = 0.7 ;
AP_On_Request_Time = 0.01 ;
 

%% Active Emergency Brake modular
AEB_Module_Activity_Flag = 1;
 
AEB_Freq_Hz = Sensor_Freq_worldsim/2 ;
 
AEB_Max_Speed = 150 ; % (km/h) Speed at which AEB is disabled
AEB_Brake_Rate = inf ; % Brake application rate limit (1/s)
AEB_Brake_Release_Rate = 25 ; % Brake release rate limit (1/s)
AEB_Steer_Max = 180 ; % Steer (deg) at which AABS is deactivated
AEB_Max_Decel = [8 15] ; % vehicle max deceleration (m/s^2)
AEB_Min_Distance_at_Stop = 1; % this is the design distance when car is stopped
 
 
%WorldSim case
AEB_Pedestrian_type = 68 ; %maybe 68 in version 2021.3 on
AEB_Distance_To_Collision_Brake = 5 ; % distance (m) at which to activate AEB
AEB_Gain = [1 1];
AEB_Gain_set = 60; %reference speed value for the AEB maneuver 50
AEB_Gain_set_mult = 0.03; %gain to increase AEB gain dependency 0.025
AEB_Alarm_Freq = 5 ; % Frequency of alarm beeps
AEB_Max_Distance = 22;
 