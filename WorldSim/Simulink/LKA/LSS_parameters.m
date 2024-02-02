% @File      : LSS_parameters.m
% @Contact   : info@vi-grade.com
% @License   : PROPRIETARY/CONFIDENTIAL (https://www.vi-grade.com/license.txt)
% @Copyright : (c) 2006-2023, VI-grade GmbH, Darmstadt, Germany, All Rights Reserved
% ----------------------------------------------------------------------------------
%% defining Simulink variables
 
Lane_Width = 3.7 ; % Target In Lane Width (m)
radar_source = 2;
No_Target_Display_Value = 0 ;
ADAS_Control_Mode = 1 ;
 
% filtering function coefficients
Wn = 1/500;                   % Normalized cutoff frequency
[butter_b,butter_a] = butter(2,Wn,'low');  % Butterworth filter
 
% filtering function coefficients
Wn_lka_out = 1/10;                   % Normalized cutoff frequency
[butter_b_lka_out,butter_a_lka_out] = butter(2,Wn_lka_out,'low');  % Butterworth filter
 
% Dimension of the vehicle used. In demo the Mercedes E class
vehicle_width = 1.86;
vehicle_length = 4.7;
 
% basic target speed. this will be override later for DoE
target_speed = 72;
 
%% LSS test definitions
 
% d1 is the distance while turning - fixed per experiment
d1 = [0.06 0.14 0.24 0.38 0.54];
 
% d2 is the distance while turning - fixed per experiment
d2 = [0.7 0.9 0.8 0.75 0.6];
 
% d is the actual lateral distance for the initial y position - depends on
% the vehicle width
d = (Lane_Width + Lane_Width/2) - (d1 + d2 + vehicle_width/2);
 
% v_lat [m/s] is the approaching speed to the lateral line
v_lat = [0.2 0.3 0.4 0.5 0.6];
 
%% Lane Departure Warning
LDW_Activity_Flag = 1 ;
LDW_Freq_Hz = Sensor_Freq_worldsim ;
 
LDW_Steer_Vibration_Amplitude = 5 ; % (Nm)
LDW_Steer_Vibration_Freq = 25 ;  % (Hz)
LDW_LaneGap_Warning = [0.5 0.25]  ; % (m)
LDW_LaneGap_dydt_Warning = 50 ; %(m/s) 1.5
LDW_Min_Speed = 60 ; % (km/h)
 
%% Lane Keeping
LKA_Activity_Flag = 1 ;
LKA_Freq_Hz = Sensor_Freq_worldsim ;
AP_Transition_Rate = 0.5;
LKA_Lane_Gap_Activate = [0.25 0.125] ; % (m)
LKA_Lane_Gap_dydt_Activate = 50 ; % (m/s) 1.5
LKA_Min_Speed = 60 ; % (km/h)
LKA_P = [0.1 0.2] ;
LKA_I = [0.025 0.05] ;
LKA_D = [0.2 0.3] ;
LKA_Dyn_Rate_Limiter_Gain = 0.1 ;
LKA_Dyn_Rate_Limiter_Power = 10 ;
LKA_Error_Off = 0.5 ; % (m)
LKA_Error_dydt_Off = 1 ; % (m/s)
LKA_Error_Max = 3 ;
LKA_Steer_Rate_Max_radps = 1 ; % (rad/s)
LKA_On_Display_Freq = 5 ; %(hz)
 