% @File      : launcher.m
% @Contact   : info@vi-grade.com
% @License   : PROPRIETARY/CONFIDENTIAL (https://www.vi-grade.com/license.txt)
% @Copyright : (c) 2006-2023, VI-grade GmbH, Darmstadt, Germany, All Rights Reserved
% ----------------------------------------------------------------------------------
%% clearing
 
clc
clear mex
close all

if exist('scons_WORLDSIMOFFLINE_TOPDIR')~=1
    clearvars -except user_limited_run_number

    % VI-CarRealTime addpath
    addpath_vicrt_2023

    % VI-WorldSim addpath
    addpath_viworldsim_2023
    interactive_mode=1;
else    
    interactive_mode=0;
end
 
% displaying start up
disp('<strong>Starting the Auto-Pilot example... </strong>')
disp('<strong>Press Ctrl + C in the Command Window to abort the simulation prior to the programmed finish</strong>')
disp('...')
 
% print banner
vi_worldsim_version;
 
% function to update the vicrt_cdb.cfg for the default example
update_example_vicrt_cdb
 
%% visual settings
 
worldsim_settings = vi_worldsim_options;

% optional settings to override default
worldsim_settings.enable_visual = interactive_mode;
worldsim_settings.verbose = 0;
worldsim_settings.car_name = 'ego';
 
Sensor_Freq_worldsim = 50;
 
%% scenario and VI-CarRealTime send definition
 
% scenario_path = '../scenarios/Auto_Pilot_test_flat.json';
%scenario_path = 'C:\VI-grade\VI-WorldSim 2023\Scenarios\UPL Test Scenarios\mcity.json';
scenario_path = 'D:\Data\UPL\Pete\WorldSim\Simulink\scenarios\Custom\highway_on_off_ramp_adas_sensors_ap.json';

 
simulation_crt = '../VI-CarRealTime_model/SedanCar_WorldSim_Offline_send_svm.xml';
%% starting WS
 
worldsim_process = vi_worldsim_start_process (worldsim_settings);
 
%% stop conditions
 
% max simulation time allowed
stop_time = 12;
 
% max number of collision before launching the stop
stop_number_collisions = 10;
 
% min speed before stopping
stop_speed = 0.001;

 %% load Simulink parameters using the dedicated script

evalin('base','run(''AutoPilot_parameters.m'')');     % the evalin is needed to write output of the script inside the base workspace

%% load VI-WorldSim scenario and run the Simulink
 
% loading the Simulink
idx=length(find(strcmp('auto_pilot_upl',find_system('SearchDepth', 0))));
if idx==0
    load_system('auto_pilot_upl');
end    
 
% loading the scenario
initCond = vi_worldsim_load_scenario(worldsim_process,scenario_path,'auto_pilot_upl');
%initCond.rdf = '..\..\..\cdb\tracks.cdb\roads.tbl\WS_MCity.rdf';
initCond.initialVelocity = 20;
 
% run simulation
sim('auto_pilot_udp');
 
%% stop processes
 
vi_worldsim_stop_process(worldsim_process);