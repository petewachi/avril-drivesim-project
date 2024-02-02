
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
disp('<strong>Starting the LSS (LKA + LDW) example... </strong>')
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

scenario_path = "../scenarios/LSS_72kph_Mercedes_Eclass.json";
% scenario_path = 'D:\Data\UPL\Pete\WorldSim\Simulink\scenarios\Custom\highway_trigger_alert.json';

simulation_crt = '../VI-CarRealTime_model/SedanCar_WorldSim_Offline_send_svm.xml';


%% starting WS

worldsim_process = vi_worldsim_start_process (worldsim_settings);

%% stop conditions

% max simulation time allowed
stop_time = 20;

% max number of collision before launching the stop
stop_number_collisions = 5;

% min speed before stopping
stop_speed = 0.001;

% initialize maximum run defined by the user
if exist('user_limited_run_number')~=1
    %     this is the case when this launcher script is started alone
    user_limited_run_number = 100000;
end
limited_run_number = 0;

%% load Simulink parameters using the dedicated script

% evalin('base','run(''LSS_parameters.m'')');     % the evalin is needed to write output of the script inside the base workspace

%% load VI-WorldSim scenario and run the Simulink

% define variants
variant_LKA_activation = linspace (-0.05,0.05,3);
variant_approaching_speed = v_lat;

% initialize result matrixes
positive_accepted_acceleration = 0.115;  % this is the threshold in [g]
result_max_accelerations = zeros(numel(variant_LKA_activation),numel(variant_approaching_speed));
negative_accepted_acceleration = -0.115;  % this is the threshold in [g]
result_min_accelerations = zeros(numel(variant_LKA_activation),numel(variant_approaching_speed));
result_crossed_lanes = zeros(numel(variant_LKA_activation),numel(variant_approaching_speed));
max_crossed_lanes_accepted = 1950;


% plotting
doe_figure = figure('Position', [100 500 500 400]);
title(" LSS test - Cumulative Crossed Lanes ")
hold on
grid on
xlabel("LKA controller setup")
xlim([min(variant_LKA_activation) max(variant_LKA_activation)]*1.7)
ylabel("lane marking approaching speed (m/s)")
ylim([min(variant_approaching_speed)-0.1 max(variant_approaching_speed)+0.1])

% loading the Simulink to set model workspace variables
idx=length(find(strcmp('lss_online',find_system('SearchDepth', 0))));
if idx==0
    load_system('lss_online');
end    

% loading the scenario
initCond = vi_worldsim_load_scenario(worldsim_process,scenario_path,'lss_online');


% staring main loop

for index_variant_LKA_activation = 1:numel(variant_LKA_activation)
    %     putting variant inside the algorithm. in this case the lateral meter threshold to
    %     start LKA activation
    LKA_Lane_Gap_Activate(1) = variant_LKA_activation(index_variant_LKA_activation);
    
    
    %
    for index_variant_approaching_speed = 1:numel(variant_approaching_speed)
        
        limited_run_number = limited_run_number + 1;
            
        %         selecting all the ncap prescribed variant. in this case
        %         the distance y
        %         is placed into the struct of VI-CarRealTime and the
        %         approaching speed
        %         control to reach the left line
        
        disp("========================!!!!!!!!!!!!!!!!!!!!!=======================")
        disp(strcat("The LKA controller setup is: ",string(variant_LKA_activation(index_variant_LKA_activation))," [m]"))
        disp("========================!!!!!!!!!!!!!!!!!!!!!=======================")
        disp(strcat("The lane marking approaching speed is: ",string(variant_approaching_speed(index_variant_approaching_speed)), " m/s"))
        disp("========================!!!!!!!!!!!!!!!!!!!!!=======================")
        
        %         setting the vehicle target speed and initial y offset
        target_speed = initCond.initialVelocity * 3.6;
        initCond.initialLocation(2) = d(index_variant_approaching_speed);
        %             start the simulation
%         sim('lss_online')
        
        %             fill the 3d matrix for minimum distance and collisions
        result_max_accelerations(index_variant_LKA_activation, index_variant_approaching_speed) = max(lateral_accelerations);
        result_min_accelerations(index_variant_LKA_activation, index_variant_approaching_speed) = min(lateral_accelerations);
        result_crossed_lanes(index_variant_LKA_activation, index_variant_approaching_speed) = sum(crossed_lanes);
        %             starting the live plotting.
        %             defining the color of the marker if passed or not
        %             (if collision occurs, test is not passed)
        if (result_crossed_lanes(index_variant_LKA_activation, index_variant_approaching_speed) > max_crossed_lanes_accepted)
            scatter_color = 'red';
        else
            scatter_color = 'green';
        end
        
        %             plotting
        
        figure(doe_figure)
        scatter(variant_LKA_activation(index_variant_LKA_activation), variant_approaching_speed(index_variant_approaching_speed), ...
            70 + 0.5 * result_crossed_lanes(index_variant_LKA_activation, index_variant_approaching_speed)  ...
            , scatter_color, 'filled')
        % break the loop in case the user want
        if (user_limited_run_number <= limited_run_number)
            break;
        end
    end
    % break the loop in case the user want
    if (user_limited_run_number <= limited_run_number)
        break;
    end
end

% plotting tables for accelerations threshold

accelerations(positive_accepted_acceleration,negative_accepted_acceleration);

%% stop processes

vi_worldsim_stop_process(worldsim_process);