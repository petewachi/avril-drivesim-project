import QtQuick 2.12
import QtQuick.Window 2.2
import "../../../qml/default/default_db"

import com.vigrade.VIClass 1.0


Item {

    //.........................................................................
    //user parameters
    property double slip_limit: 12      //slip light threshold

    property bool rpm_lights_mode: false        //rpm top lights mode
                                                //false: from border to center true:from left to right
    property double rpm_green1: 7000            //first rpm green light
    property double rpm_green2: 7500            //second rpm green light
    property double rpm_yellow1: 8000           //rpm yellow light
    property double rpm_yellow2: 8500           //second rpm yellow light
    property double rpm_red: 9000               //rpm red light
    property double rpm_limit: 9100               //rpm limit light --> make it blink

    property bool mph_values: false          //mph visualization

    property bool steering_wheel_visibility: false   //forced steering wheel visibility

    property double battery_soc_yellow: 20      //level at which battery becomes yellow [%]
    property double battery_soc_red: 5          //level at which battery becomes red [%]

    property double motor_max: 550              //power/current/torque maximum
    property double motor_regen_max: 100              //power/current/torque maximum

    property bool gg_diagram_split: true       //show splitted lateral and longitudinal values
    property double gg_diagram_max_g: 1.5       //max acc [g]
    property double gg_diagram_circle_width: 15 //width of the gg pointer [pixel]
    property double gg_trace_time: 3            //trace persistent time

    property int lap_best_time_type: 1  //calculation type of last and best time.
    //0: dashboard calculation ()
    //1: carrealtime calculation from VI_CarRealTime.Outputs.path_sensor.total_lap_time
    //2: external source (e.g. simulink) --> needs to specify in lap_time_best and lap_last_time

    property int lap_diff_type: 0  //calculation type of diff and predicted time.
    //0: dashboard calculation ()
    //1: external source (e.g. simulink) --> needs to specify in lap_time_best and lap_last_time
    property string csv_file: ""  //path to custom csv to load for diff
    property string csv_lap_time_string_header: "Vicrt_Lap_Time"        // csv drivesim: "VI_DriveSim.Outputs.Vicrt.Lap.Time"
    // csv winTAX: "Vicrt_Lap_Time"
    property string csv_path_s_string_header: "path_sensor_path_s"      // csv drivesim: "VI_CarRealTime.Outputs.driving_machine_monitor.path_s"
    // csv winTAX: "path_sensor_path_s"

    property double dim_sim_name: 400               //DiM simulator name (150, 250, 400)
    property bool dimC: (root.dim_sim_name >= 350)  //true: DiM cable (400,..) or false: Sag DiM (150, 250,...)
    property bool data_check_mode: false    //forces pos_LP when using datacheck on dimC
    property bool platform_tracking_mode: true          //enable the tracking of the platform

    property string drd_path: "../../../qml/default/default_db/files/Calabogie.drd"  //path to custom drd to load
    property int drd_subsampling: 10           //load only one point every drd_subsampling

    //local varibales to RTDB mapping
    property var qml_properties__RTDB_variables:
        ({
             steering_input:                "VI_CarRealTime.Inputs.Driver_Demands.str_swa",
             brake_demand:                  "VI_CarRealTime.Inputs.Driver_Demands.brake",
             throttle_demand:               "VI_CarRealTime.Inputs.Driver_Demands.throttle",
             solver_status:                 "VI_DriveSim.Outputs.Vicrt.Status",
             gear:                          "VI_CarRealTime.Outputs.transmission.gear",
             rpm:                           "VI_CarRealTime.Outputs.engine.engine_rpm",
             shifting_mode:                 "VI_CarRealTime.Inputs.GearBox.automatic_gearbox_shifting_mode",
             speed:                         "VI_CarRealTime.Outputs.chassis_velocities.longitudinal",
             lateral_acceleration:          "VI_CarRealTime.Outputs.chassis_accelerations.lateral",
             longitudinal_acceleration:     "VI_CarRealTime.Outputs.chassis_accelerations.longitudinal",
             motor_to_clutch:               "VI_CarRealTime.Outputs.motor_to_clutch.Power_KW",
             motor_to_gearbox:              "VI_CarRealTime.Outputs.motor_to_gearbox.Power_KW",
             motor_to_central_differential: "VI_CarRealTime.Outputs.motor_to_central_differential.Power_KW",
             motor_to_front_differential:   "VI_CarRealTime.Outputs.motor_to_front_differential.Power_KW",
             motor_to_rear_differential:    "VI_CarRealTime.Outputs.motor_to_rear_differential.Power_KW",
             motor_to_front_left_wheel:     "VI_CarRealTime.Outputs.motor_to_front_left_wheel.Power_KW",
             motor_to_front_right_wheel:    "VI_CarRealTime.Outputs.motor_to_front_right_wheel.Power_KW",
             motor_to_rear_left_wheel:      "VI_CarRealTime.Outputs.motor_to_rear_left_wheel.Power_KW",
             motor_to_rear_right_wheel:     "VI_CarRealTime.Outputs.motor_to_rear_right_wheel.Power_KW",
             battery_soc:                   "VI_CarRealTime.Outputs.BatteryInternal.SOC",
             path_s:                        "VI_CarRealTime.Outputs.driving_machine_monitor.path_s",
             //lap
             lap_num:                       "VI_DriveSim.Outputs.Vicrt.Lap.Num",
             lap_time:                      "VI_DriveSim.Outputs.Vicrt.Lap.Time",
             //lap_time_last:                 "",       //TO BE USED uncommented when using external source for lap time last/best
             lap_time_last_crt:             "VI_CarRealTime.Outputs.path_sensor.total_lap_time",
             //lap_time_best:                 "",       //TO BE USED uncommented when using external source for lap time last/best
             //lap_time_diff:                 "",       //TO BE USED uncommented when using external source for lap time diff
             //slip of vehicle and tires
             vehicle_side_slip:             "VI_CarRealTime.Outputs.Vehicle.Side_Slip_Angle",
             slip_front_right:              "VI_CarRealTime.Outputs.tir_wheel_tire_kinematics.longitudinal_slip_front",
             slip_front_left:               "VI_CarRealTime.Outputs.til_wheel_tire_kinematics.longitudinal_slip_front",
             slip_rear_left:                "VI_CarRealTime.Outputs.til_wheel_tire_kinematics.longitudinal_slip_rear",
             slip_rear_right:               "VI_CarRealTime.Outputs.tir_wheel_tire_kinematics.longitudinal_slip_rear",
             front_left_wheel_toe:          "VI_CarRealTime.Outputs.wheel_angles.toe_L1",
             rear_left_wheel_toe:           "VI_CarRealTime.Outputs.wheel_angles.toe_L2",
             front_right_wheel_toe:         "VI_CarRealTime.Outputs.wheel_angles.toe_R1",
             rear_right_wheel_toe:          "VI_CarRealTime.Outputs.wheel_angles.toe_R2",
             front_left_tire_normal_force:  "VI_CarRealTime.Outputs.til_wheel_tire_forces.normal_front",
             rear_left_tire_normal_force:   "VI_CarRealTime.Outputs.til_wheel_tire_forces.normal_rear",
             front_right_tire_normal_force: "VI_CarRealTime.Outputs.tir_wheel_tire_forces.normal_front",
             rear_right_tire_normal_force:  "VI_CarRealTime.Outputs.tir_wheel_tire_forces.normal_rear",
             //abs and tcs activities
             abs_activity_fl :              "VI_CarRealTime.Outputs.Brake.ABS_Activity.L1" ,
             abs_activity_fr :              "VI_CarRealTime.Outputs.Brake.ABS_Activity.R1" ,
             abs_activity_rl :              "VI_CarRealTime.Outputs.Brake.ABS_Activity.L2" ,
             abs_activity_rr :              "VI_CarRealTime.Outputs.Brake.ABS_Activity.R2" ,
             tcs_activity_engine :                      "VI_CarRealTime.Outputs.engine.TCS_activity" ,
             tcs_activity_motor_to_clutch:              "VI_CarRealTime.Outputs.motor_to_clutch.TCS_activity" ,
             tcs_activity_motor_to_gearbox:             "VI_CarRealTime.Outputs.motor_to_gearbox.TCS_activity" ,
             tcs_activity_motor_to_central_differential:"VI_CarRealTime.Outputs.motor_to_central_differential.TCS_activity" ,
             tcs_activity_motor_to_front_differential : "VI_CarRealTime.Outputs.motor_to_front_differential.TCS_activity" ,
             tcs_activity_motor_to_rear_differential :  "VI_CarRealTime.Outputs.motor_to_rear_differential.TCS_activity" ,
             tcs_activity_motor_to_front_left_wheel :   "VI_CarRealTime.Outputs.motor_to_front_left_wheel.TCS_activity" ,
             tcs_activity_motor_to_front_right_wheel :  "VI_CarRealTime.Outputs.motor_to_front_right_wheel.TCS_activity" ,
             tcs_activity_motor_to_rear_left_wheel :    "VI_CarRealTime.Outputs.motor_to_rear_left_wheel.TCS_activity" ,
             tcs_activity_motor_to_rear_right_wheel :   "VI_CarRealTime.Outputs.motor_to_rear_right_wheel.TCS_activity" ,

             esp_activity :                                     "VI_CarRealTime.Outputs.Brake_System.ESP_Activity" ,
             hill_hold_activity :                               "VI_CarRealTime.Outputs.Brake_System.Hill_Holder_Activity" ,
             launch_control_activity:                           "VI_CarRealTime.Outputs.engine.Launch_Control_activity" ,
             launch_control_engine_internal_activation:         "VI_CarRealTime.Inputs.Engine.internal_launch_control_activation" ,
             launch_control_engine_clutch_internal_activation:  "VI_CarRealTime.Inputs.Generic_Engine_to_Clutch.internal_launch_control_activation" ,
             //lights values
             highBeamLeft:                  "VI_DriveSim.Outputs.VehicleLights.HighBeamLeft" ,
             highBeamRight:                 "VI_DriveSim.Outputs.VehicleLights.HighBeamRight" ,
             lowBeamLeft:                   "VI_DriveSim.Outputs.VehicleLights.LowBeamLeft" ,
             lowBeamRight:                  "VI_DriveSim.Outputs.VehicleLights.LowBeamRight" ,
             weather:                       "WorldSim.Environment.Weather.Wetness" ,
             //tires temp pressure
             tire_temp_FL:                  "VI_CarRealTime.Outputs.Tire.Temperature_1.L1" ,
             tire_temp_FR:                  "VI_CarRealTime.Outputs.Tire.Temperature_1.R1" ,
             tire_temp_RL:                  "VI_CarRealTime.Outputs.Tire.Temperature_1.L2" ,
             tire_temp_RR:                  "VI_CarRealTime.Outputs.Tire.Temperature_1.R2" ,

             tire_pres_FL:                  "VI_CarRealTime.Outputs.Tire.Pressure.L1" ,
             tire_pres_FR:                  "VI_CarRealTime.Outputs.Tire.Pressure.R1" ,
             tire_pres_RL:                  "VI_CarRealTime.Outputs.Tire.Pressure.L2" ,
             tire_pres_RR:                  "VI_CarRealTime.Outputs.Tire.Pressure.R2" ,

             //platform channels
             pos_long_LP:                   "VI_DriveSim.Outputs.Platform.Cueing.POSLONG_LP",
             pos_lat_LP:                    "VI_DriveSim.Outputs.Platform.Cueing.POSLAT_LP",
             pos_yaw_LP:                    "VI_DriveSim.Outputs.Platform.Cueing.POSYAW_LP",
             pos_long_DiMc:                 "VI_DriveSim.Inputs.DiMc.discframe.x",
             pos_lat_DiMc:                  "VI_DriveSim.Inputs.DiMc.discframe.y",
             pos_yaw_DiMc:                  "VI_DriveSim.Inputs.DiMc.discframe.yaw",
             cueing_status:                 "VI_DriveSim.Outputs.Platform.Cueing.STATUS",
             cueing_request:                "VI_DriveSim.Inputs.Platform.Cueing.REQUEST",
             cueing_status_limit_long_pitch:"VI_DriveSim.Outputs.Platform.Cueing.CUEING_STATUS_XY",
             cueing_status_limit_lat_roll:  "VI_DriveSim.Outputs.Platform.Cueing.CUEING_STATUS_YX",
             cueing_status_limit_yaw:       "VI_DriveSim.Outputs.Platform.Cueing.CUEING_STATUS_ZA",
             cueing_status_limit_vert:      "VI_DriveSim.Outputs.Platform.Cueing.CUEING_STATUS_ZV",
             status_operation:              "VI_DriveSim.Inputs.Platform.STATUS",
             status_stream:                 "VI_DriveSim.Inputs.Platform.STREAM_STATUS",
             status_hmi:                    "VI_DriveSim.Inputs.Platform.HMI_REQ",
             platform_sound_notice:         "bk_1/enable_sound_notice",
             platform_sound_notice_level:   "BK.SPECIAL_CUSTOM_TRIGGER_PARKING_SENSOR_FRONT_LEFT"

//             reset_best_lap:                "VI_DriveSim.Inputs.ECAT.BECKH.DIG6",
//             page_down:                     "VI_DriveSim.Inputs.ECAT.BECKH.DIG7",
//             page_up:                       "VI_DriveSim.Inputs.ECAT.BECKH.DIG8"
         })
    //.........................................................................


    id: root
    visible: true

    width: Window.width
    height: Window.height
//    width: 1920       //to uncomment when editing in qt-design studio
//    height: 720

    property double std_width: 1270
    property double std_height: 720
    property bool reset_best_lap: false     //reset best lap and diff time
    property bool page_up: false            //page up
    property bool page_down: false          //page down

    //general data
    property double solver_status: 1        //
    property double fuel_consumption: 5     //l/100km
    property double steering_input: 0       //rad
    property double brake_demand: 0         //%
    property double throttle_demand: 0      //%
    property int gear: 0                    //gear selected
    property double rpm: 9050                 //rpm
    property bool shifting_mode: false      //false: comfort, true: sport mode
    property double speed: 0                //speed in km/h. to switch to miles, change mph_values
    property double path_s: 0               //path_sdistance from origin [m]

    //gg diagram
    property double lateral_acceleration: 0         //lateral acc in [g]
    property double longitudinal_acceleration: 0    //longitudinal acc in [g]

    //vehicle and wheel side slips
    property double vehicle_side_slip: 0 //"VI_CarRealTime.Outputs.Vehicle.Side_Slip_Angle"
    property double slip_front_right: 50
    property double slip_front_left: 50
    property double slip_rear_left: 50
    property double slip_rear_right: 50

    property double front_left_wheel_toe: 0     //"VI_CarRealTime.Outputs.wheel_angles.toe_L1"};
    property double rear_left_wheel_toe: 0      //"VI_CarRealTime.Outputs.wheel_angles.toe_L2"};
    property double front_right_wheel_toe: 0    //"VI_CarRealTime.Outputs.wheel_angles.toe_R1"};
    property double rear_right_wheel_toe: 0     //"VI_CarRealTime.Outputs.wheel_angles.toe_R2"};: 0        //vehicle side slip rad

    property double front_left_tire_normal_force: 1     //"VI_CarRealTime.Outputs.til_wheel_tire_forces.normal_front"};
    property double rear_left_tire_normal_force: 1      //"VI_CarRealTime.Outputs.til_wheel_tire_forces.normal_rear"};
    property double front_right_tire_normal_force: 1    //"VI_CarRealTime.Outputs.tir_wheel_tire_forces.normal_front"};
    property double rear_right_tire_normal_force: 1     //"VI_CarRealTime.Outputs.tir_wheel_tire_forces.normal_rear"};

    //lap times value
    property double lap_num: 0
    property double lap_time: 0
    property double lap_time_last: 0
    property double lap_time_last_crt: 0
    property double lap_time_best: 0
    property double lap_time_diff: 0

    //abs and tcs activities
    property bool abs_activity_fl : true
    property bool abs_activity_fr : true
    property bool abs_activity_rl : true
    property bool abs_activity_rr : true
    property bool abs_activity: (root.abs_activity_fl || root.abs_activity_fr||
                                 root.abs_activity_rl || root.abs_activity_rr)
    property bool tcs_activity_engine : true
    property bool tcs_activity_motor_to_clutch : true
    property bool tcs_activity_motor_to_gearbox : true
    property bool tcs_activity_motor_to_central_differential : true
    property bool tcs_activity_motor_to_front_differential : true
    property bool tcs_activity_motor_to_rear_differential : true
    property bool tcs_activity_motor_to_front_left_wheel : true
    property bool tcs_activity_motor_to_front_right_wheel : true
    property bool tcs_activity_motor_to_rear_left_wheel : true
    property bool tcs_activity_motor_to_rear_right_wheel : true
    property bool tcs_activity: (root.tcs_activity_engine || root.tcs_activity_motor_to_clutch || root.tcs_activity_motor_to_gearbox
                                 ||root.tcs_activity_motor_to_front_differential ||
                                 root.tcs_activity_motor_to_rear_differential || root.tcs_activity_motor_to_central_differential ||
                                 root.tcs_activity_motor_to_front_left_wheel || root.tcs_activity_motor_to_front_right_wheel ||
                                 root.tcs_activity_motor_to_rear_left_wheel||  root.tcs_activity_motor_to_rear_right_wheel)
    property bool esp_activity: true
    property bool hill_hold_activity: true
    property bool launch_control_activity: false
    property bool launch_control_engine_internal_activation: false
    property bool launch_control_engine_clutch_internal_activation: false
    property bool launch_control_internal_activation: (root.launch_control_engine_internal_activation || root.launch_control_engine_clutch_internal_activation)

    //lights values
    property bool highBeamLeft: true
    property bool highBeamRight: false
    property bool highBeam_on: root.highBeamLeft || root.highBeamRight
    property bool lowBeamLeft: true
    property bool lowBeamRight: false
    property bool lowBeam_on: root.lowBeamLeft|| root.lowBeamRight

    //tire temp and pressure
    property double tire_temp_FL: 85               //front left                     //RTDB TO MAP !!!!!
    property double tire_temp_FR: 85               //front right                    //RTDB TO MAP !!!!!
    property double tire_temp_RL: 85               //rear left                      //RTDB TO MAP !!!!!
    property double tire_temp_RR: 85               //rear right                     //RTDB TO MAP !!!!!

    property double tire_pres_FL: 1.5               //front left                    //RTDB TO MAP !!!!!
    property double tire_pres_FR: 1.5               //front right                   //RTDB TO MAP !!!!!
    property double tire_pres_RL: 1.5               //rear left                     //RTDB TO MAP !!!!!
    property double tire_pres_RR: 1.5               //rear right                    //RTDB TO MAP !!!!!

    //state of charge and torque/current
    //EV dashboard
    property double motor_to_clutch : 0
    property double motor_to_gearbox : 0
    property double motor_to_central_differential : 0
    property double motor_to_front_differential : 0
    property double motor_to_rear_differential : 0
    property double motor_to_front_left_wheel : 0
    property double motor_to_front_right_wheel : 0
    property double motor_to_rear_left_wheel : 0
    property double motor_to_rear_right_wheel : 0
    property double motor: (root.motor_to_clutch + root.motor_to_gearbox +
                            root.motor_to_front_differential + root.motor_to_rear_differential + root.motor_to_central_differential +
                            root.motor_to_front_left_wheel + root.motor_to_front_right_wheel+
                            root.motor_to_rear_left_wheel + root.motor_to_rear_right_wheel)
    property double battery_soc: 100

    //worldsim weather wetness
    property double weather: 0

    //platform DiM values
    property double pos_long_LP: 0                      //cueing position
    property double pos_lat_LP: 0
    property double pos_yaw_LP: 0
    property double pos_lat_DiMc: 0              //DiMc channels m
    property double pos_long_DiMc: 0             //m
    property double pos_yaw_DiMc: 0              //rad
    property double cueing_status: 0
    property double cueing_request: 0
    property double status_operation: 0                         // operation platform status
    property double status_stream: 0                            // stream status coming from plc/pmac
    property double status_hmi: 0                               // hmi status

    property double cueing_status_limit_long_pitch : 0      //status of the 4 subsystem of cueing
    property double cueing_status_limit_lat_roll : 0
    property double cueing_status_limit_yaw : 0
    property double cueing_status_limit_vert : 0

    property bool platform_sound_notice: false      //platform sound for positional cueing
    property double platform_sound_notice_level: 0  //platform sound level yellow for positional cueing

    Viclass{
        id: viclass

        Component.onCompleted: {
            viclass.setDashboardId(dashboardId);
            //number of rtdb channels
            var i = 0;
            for (var item in root.qml_properties__RTDB_variables) {i++}
            viclass.setChannelsNumber(i);
            //map and register RTDB items
            i = 0;
            for (item in root.qml_properties__RTDB_variables) {
                viclass.registerChannel(i,root.qml_properties__RTDB_variables[item]);
                i++;
            }
        }
        onMapChanged: {
            var mapObject = {}
            mapObject = viclass.getValues()
            //map rdtb to local variables
            var i = 0;
            for (var item in root.qml_properties__RTDB_variables) {
                root[item] = mapObject[i];
                i++;
            }
            //setting connection to true becaus ethe map is changed
            dashboard_Utils.driveSim_activity = true
            //starting the timer that sets to false after a timeout
            dashboard_Utils.driveSim_timeout_function()
        }
    }

    Rectangle{
        id: background_back
        color: "#212121"
        anchors.fill: parent

        Rectangle {
            id: rectangle
            color: dashboard_Utils.vi_black
            radius: height/20
            anchors.fill: parent
            anchors.bottomMargin: 50*scaling.scale
            anchors.topMargin: 60*scaling.scale
            anchors.leftMargin: 50*scaling.scale
            anchors.rightMargin: 50*scaling.scale
        }

        Slip_lights_item {
            id: slip_lights_left_item
            width: 38
            height: 200
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -110*scaling.scale
            anchors.horizontalCenterOffset: -parent.width/2 +30*scaling.scale
            anchors.horizontalCenter: parent.horizontalCenter
            slip_front_value: root.slip_front_left
            slip_rear_value: root.slip_rear_left
            slip_limit_value: root.slip_limit
            scale: root.width/root.std_width
        }

        Slip_lights_item {
            id: slip_lights_right_item
            x: 1876
            y: 79
            width: 38
            height: 200
            slip_front_value: root.slip_front_right
            slip_rear_value: root.slip_rear_right
            slip_limit_value: root.slip_limit
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -110*scaling.scale
            anchors.horizontalCenterOffset: parent.width/2-30*scaling.scale
            anchors.horizontalCenter: parent.horizontalCenter
            scale: root.width/root.std_width
        }

        Rpm_lights_item {
            id: rpm_lights_item
            x: 448
            y: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            scale: root.height/root.std_height
            anchors.verticalCenterOffset: -(parent.height/2-30*scaling.scale)
            rpm_limit_value: root.rpm_limit
            lights_mode: root.rpm_lights_mode
            rpm_yellow2_value: root.rpm_yellow2
            rpm_yellow1_value: root.rpm_yellow1
            rpm_red_value: root.rpm_red
            rpm_green2_value: root.rpm_green2
            rpm_green1_value: root.rpm_green1
            rpm_value: root.rpm
            height: 50
            width: 1024
        }

    }

    Item{
        id: scaling
        width: parent.width
        height: parent.height
        scale: dashboard_Utils.resize_content(parent.width, parent.height, root.std_width, root.std_height)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Item {
            id: background
            width: parent.width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            //scale: 1/dashboard_Utils.resize_content(parent.width, parent.height, root.std_width, root.std_height)

            Image {
                id: back
                x: 232
                y: -207
                width: 1280
                height: 720
                visible: false
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "images/GT3_background.png"
                mipmap: true
                antialiasing: true
            }


        }

        Item {
            id: quadro
            width: 1024
            height: 530
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 25
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter

            Speed_component {
                id: speed_item
                width: 248
                height: 76
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -9
                anchors.verticalCenter: parent.verticalCenter
                mph_value: root.mph_values
                speed_unit_visibility: true
                speed: root.speed
                anchors.verticalCenterOffset: -275
            }

            Dash_page_item {
                id: dash_page_item
                x: 0
                y: 0
                visible: !launch_control_component.visible
                weather_value: root.weather
                anchors.verticalCenter: parent.verticalCenter
                low_beam_value: root.lowBeam_on
                high_beam_value: root.highBeam_on
                esp_on: root.esp_activity
                hill_hold_on: root.hill_hold_activity
                anchors.horizontalCenterOffset: -366
                anchors.verticalCenterOffset: -275
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Gear_item {
                id: gear_item
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                scale: !launch_control_component.visible ? 1.2 :0.5
                anchors.horizontalCenterOffset: !launch_control_component.visible ? 0: -366
                anchors.verticalCenterOffset: !launch_control_component.visible ? -84 : -275
                gear_value: root.gear
            }


            Laptime_item {
                id: laptime_item
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 354
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -84
                lap_last_time_crt_value: root.lap_time_last_crt
                lap_best_time_value: root.lap_time_best
                internal_last_best_computation: root.lap_best_time_type
                lap_time_value: root.lap_time
                lap_num_value: root.lap_num
                lap_last_time_value: root.lap_time_last
            }

            TimeDiff_predicted_item {
                id: timeDiff_predicted_item
                anchors.verticalCenter: parent.verticalCenter
                solver_status: root.solver_status
                path_s: root.path_s
                lap_diff_type: root.lap_diff_type
                lap_num: root.lap_num
                lap_time_value: root.lap_time
                lap_diff_value: root.lap_time_diff
                lap_best_time_value: root.lap_time_best
                csv_file: root.csv_file
                csv_lap_time_string_header: root.csv_lap_time_string_header
                csv_path_s_string_header: root.csv_path_s_string_header
                best_laptime_text: laptime_item.best_laptime_text
                anchors.verticalCenterOffset: -85
                anchors.horizontalCenterOffset: -366
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rpm_component {
                id: rpm_component
                width: 248
                height: 76
                rpm_unit_visibility: true
                anchors.verticalCenter: parent.verticalCenter
                rpm: root.rpm
                anchors.verticalCenterOffset: -275
                anchors.horizontalCenterOffset: 422
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Tire_item {
                id: tire_press_item
                width: 192
                height: 210
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -460
                anchors.verticalCenterOffset: 133
                anchors.horizontalCenter: parent.horizontalCenter
                tire_red_value: 2.2
                tire_yellow_value: 1.8
                tire_green_value: 1
                tire_RR_value: root.tire_pres_RR
                tire_RL_value: root.tire_pres_RL
                tire_FR_value: root.tire_pres_FR
                tire_FL_value: root.tire_pres_FL
                central_text_value: "PRESS"
                unit_of_measure_value: "bar"
            }

            Tire_item {
                id: tire_temp_item
                width: 192
                height: 210
                anchors.verticalCenter: parent.verticalCenter
                tire_RR_value: root.tire_temp_RR
                tire_RL_value: root.tire_temp_RL
                tire_FR_value: root.tire_temp_FR
                tire_FL_value: root.tire_temp_FL
                anchors.verticalCenterOffset: 133
                anchors.horizontalCenterOffset: -262
                anchors.horizontalCenter: parent.horizontalCenter
                unit_of_measure_value: "°C"
                central_text_value: "TEMP"
            }

            Steering_wheel_widget {
                id: steering_wheel_widget
                x: 437
                y: 389
                anchors.verticalCenter: parent.verticalCenter
                str_wheel_forced_Visible: root.steering_wheel_visibility
                str_wheel_Rotation: root.steering_input
                solver_status: root.solver_status
                anchors.verticalCenterOffset: 133
                anchors.horizontalCenter: parent.horizontalCenter
            }


            GG_diagram {
                id: gG_diagram
                width: 240
                height: 240
                visible: root.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED
                anchors.verticalCenter: parent.verticalCenter
                gg_circleWidth: root.gg_diagram_circle_width
                gg_trace_time: root.gg_trace_time
                solver_status: root.solver_status
                split_g: root.gg_diagram_split
                anchors.horizontalCenterOffset: 0
                max_g: root.gg_diagram_max_g
                longitudinal: root.longitudinal_acceleration
                lateral: root.lateral_acceleration
                anchors.verticalCenterOffset: 133
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Controls_activity_item {
                id: abs_activity_item
                width: 192
                height: 74
                anchors.verticalCenter: parent.verticalCenter
                control_value: root.abs_activity
                anchors.verticalCenterOffset: 133
                anchors.horizontalCenterOffset: 261
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Controls_activity_item {
                id: tcs_activity_item
                width: 192
                height: 74
                anchors.verticalCenter: parent.verticalCenter
                control_value: root.tcs_activity
                control_name_value: "TCS"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 453
                anchors.verticalCenterOffset: 133
            }

            Track_component {
                id: track_component
                width: 300
                height: 300
                anchors.verticalCenter: parent.verticalCenter
                path_to_drd: root.drd_path
                path_s: root.path_s
                drd_subsampling: root.drd_subsampling
                rect_pointerWidth: 10
                track_width: 2
                anchors.verticalCenterOffset: 123
                anchors.horizontalCenterOffset: -341
                anchors.horizontalCenter: parent.horizontalCenter
                track_color: dashboard_Utils.vi_cream
            }

            Map_settings_item {
                id: map_settings_item
                width: 384
                height: 302
                visible: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 124
                anchors.horizontalCenterOffset: -374
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Power_regen_component{
                id: power_regen_component
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: 0
                scale: 1.2
                anchors.verticalCenterOffset: -94
                anchors.horizontalCenter: parent.horizontalCenter
                regen_max_value: root.motor_regen_max
                power_value: root.motor
                power_max_value: root.motor_max
            }

            Launch_control_component {
                id: launch_control_component
                height: 220
                throttle_value: root.throttle_demand
                launch_control_value: root.launch_control_activity
                launch_control_input_value: root.launch_control_internal_activation
                brake_value: root.brake_demand
                width: 1110
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -94
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Throttle_brake_component {
                id: throttle_brake_component
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 152
                anchors.horizontalCenterOffset: -366
                anchors.horizontalCenter: parent.horizontalCenter
                throttle_value: root.throttle_demand
                brake_value: root.brake_demand
                scale: 1
            }

            Battery_item {
                id: battery_item
                x: 185
                y: -101
                width: 391
                height: 42
                visible: false
                anchors.verticalCenter: parent.verticalCenter
                soc_value: root.battery_soc
                soc_yellow_value: root.battery_soc_yellow
                soc_red_value: root.battery_soc_red
                anchors.verticalCenterOffset: -272
                anchors.horizontalCenterOffset: 351
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Cueing_status_limits {
                id: cueing_status_limits
                width: 261
                height: 175
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 139
                anchors.horizontalCenterOffset: -476
                anchors.horizontalCenter: parent.horizontalCenter
                status_stream: root.status_stream
                status_operation: root.status_operation
                status_hmi: root.status_hmi
                solver_status: root.solver_status
                cueing_status_limit_yaw: root.cueing_status_limit_yaw
                cueing_status_limit_vert: root.cueing_status_limit_vert
                cueing_status_limit_long_pitch: root.cueing_status_limit_long_pitch
                cueing_status_limit_lat_roll: root.cueing_status_limit_lat_roll
                cueing_status: root.cueing_status
                cueing_request: root.cueing_request
            }


            Platform{
                id: platform_item
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 133
                anchors.horizontalCenterOffset: -268
                scale: 0.38
                anchors.horizontalCenter: parent.horizontalCenter
                platform_sound_notice: root.platform_sound_notice
                platform_sound_notice_level: root.platform_sound_notice_level
                dim_simulator: root.dim_sim_name
                pos_lat_LP: root.pos_lat_LP
                pos_long_LP: root.pos_long_LP
                pos_yaw_LP: root.pos_yaw_LP
                pos_lat_DiMc: root.pos_lat_DiMc
                pos_long_DiMc: root.pos_long_DiMc
                pos_yaw_DiMc: root.pos_yaw_DiMc
                dimC: root.dimC
                data_check_mode: root.data_check_mode
                solver_status: root.solver_status
                cueing_status: root.cueing_status
                lap_num: root.lap_num
                platform_tracking_mode: root.platform_tracking_mode
                driveSim_activity: dashboard_Utils.driveSim_activity
            }

            DriveSim_connection_item {
                id: driveSim_connection_item
                x: 327
                y: 470
                width: 370
                height: 76
                anchors.verticalCenter: parent.verticalCenter
                scale: 0.6
                driveSim_connection_rectColor: dashboard_Utils.vi_dark_grey
                driveSim_connection_rectRadius: 15
                driveSim_connected: dashboard_Utils.driveSim_activity
                anchors.verticalCenterOffset: 254
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: vigrade_logo
                x: 605
                y: 451
                anchors.verticalCenter: parent.verticalCenter
                source: "images/vi-grade.png"
                scale: 0.6
                anchors.verticalCenterOffset: 247
                anchors.horizontalCenterOffset: 262
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: hour
                x: 856
                y: 483
                color: dashboard_Utils.vi_cream
                text: new Date().toLocaleTimeString(Qt.locale("en_EN"),Locale.ShortFormat)
                anchors.horizontalCenterOffset: 453
                font.family: "Sansation"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenterOffset: 251
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                Timer{
                    id: change_of_hour
                    running: true
                    repeat: true
                    interval: 2000
                    onTriggered: {
                        hour.text =new Date().toLocaleTimeString(Qt.locale("en_EN"),Locale.ShortFormat)
                    }
                }
            }

            Rectangle {
                id: horizontal_separator
                width: 1150
                height: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -218
                anchors.horizontalCenter: parent.horizontalCenter
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop {
                        position: 0
                        color: dashboard_Utils.vi_transparent
                    }

                    GradientStop {
                        position: 0.2
                        color: dashboard_Utils.vi_cream
                    }

                    GradientStop {
                        position: 0.8
                        color: dashboard_Utils.vi_cream
                    }

                    GradientStop {
                        position: 1
                        color: dashboard_Utils.vi_transparent
                    }


                }
            }




        }

    }


    Sansation_Regular{}

    OpenSans_Regular{}

    Dashboard_Utils{
        id: dashboard_Utils
        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_R) {
                //reset best lap
                laptime_item.reset_lap_value ++;
                console.log("reset the best lap n°:" + laptime_item.reset_lap_value)
                //reset diff best lap
                timeDiff_predicted_item.reset_diff_value ++;
                console.log("reset the best diff lap n°:" + timeDiff_predicted_item.reset_diff_value)
            }
            if (event.key === Qt.Key_Left) {
                dashboard_Utils.change_page(-1)
            }
            if (event.key === Qt.Key_Right) {
                dashboard_Utils.change_page(1)
            }
            if (event.key === Qt.Key_D) {
                //check data check
                root.data_check_mode = !root.data_check_mode
            }
            if (event.key === Qt.Key_T) {
                //check tracking on/off
                root.platform_tracking_mode = !root.platform_tracking_mode
            }
        }
    }
    onReset_best_lapChanged: {
        if (reset_best_lap){
            laptime_item.reset_lap_value ++;
            timeDiff_predicted_item.reset_diff_value ++;
        }
    }
    onPage_upChanged: if (page_up)dashboard_Utils.change_page(1)
    onPage_downChanged: if (page_down)dashboard_Utils.change_page(-1)

    //switch automatically between states depending on current folder name

    //get current path
    property var folder_path: Qt.resolvedUrl(".").split("/")
    //select splitting current path the current folder (last non-void element of the array)
    state: "racing_EV" //root.folder_path[root.folder_path.length-2]
    states: [
        State {
            name: "racing"

            PropertyChanges {
                target: cueing_status_limits
                visible: false
            }

            PropertyChanges {
                target: platform_item
                visible: false
            }

            PropertyChanges {
                target: track_component
                visible: false
            }

            PropertyChanges {
                target: tire_press_item
                visible: false
            }

            PropertyChanges {
                target: tire_temp_item
                visible: false
            }

            PropertyChanges {
                target: battery_item
                visible: false
            }

            PropertyChanges {
                target: power_regen_component
                visible: false
            }

            PropertyChanges {
                target: map_settings_item
                visible: false
            }
        },
        State {
            name: "racing_EV"
            PropertyChanges {
                target: tire_press_item
                visible: false
            }

            PropertyChanges {
                target: tire_temp_item
                visible: false
            }

            PropertyChanges {
                target: cueing_status_limits
                visible: false
            }

            PropertyChanges {
                target: platform_item
                visible: false
            }

            PropertyChanges {
                target: map_settings_item
                visible: false
            }

            PropertyChanges {
                target: dash_page_item
                dash_page_value: 3
            }

            PropertyChanges {
                target: dash_page_item
                dash_page_value: 4
            }

            PropertyChanges {
                target: track_component
                visible: false
            }

            PropertyChanges {
                target: power_regen_component
                x: 9
                y: 316
            }

            PropertyChanges {
                target: battery_item
                visible: true
            }

            PropertyChanges {
                target: rpm_lights_item
                visible: false
            }

            PropertyChanges {
                target: gear_item
                visible: false
            }
        },
        State {
            name: "racing_DiM"

            PropertyChanges {
                target: map_settings_item
                visible: false
            }

            PropertyChanges {
                target: tire_press_item
                visible: false
            }

            PropertyChanges {
                target: tire_temp_item
                visible: false
            }

            PropertyChanges {
                target: throttle_brake_component
                visible: false
            }

            PropertyChanges {
                target: track_component
                visible: false
            }

            PropertyChanges {
                target: dash_page_item
                dash_page_value: 1
            }

            PropertyChanges {
                target: battery_item
                visible: false
            }

            PropertyChanges {
                target: power_regen_component
                visible: false
            }
        },
        State {
            name: "racing_DiM_EV"

            PropertyChanges {
                target: map_settings_item
                visible: false
            }

            PropertyChanges {
                target: tire_press_item
                visible: false
            }

            PropertyChanges {
                target: tire_temp_item
                visible: false
            }

            PropertyChanges {
                target: throttle_brake_component
                visible: false
            }

            PropertyChanges {
                target: track_component
                visible: false
            }

            PropertyChanges {
                target: dash_page_item
                dash_page_value: 4
            }

            PropertyChanges {
                target: power_regen_component
                x: 9
                y: 316
            }

            PropertyChanges {
                target: battery_item
                visible: true
            }

            PropertyChanges {
                target: rpm_lights_item
                visible: false
            }

            PropertyChanges {
                target: gear_item
                visible: false
            }
        },
        State {
            name: "racing_tire"

            PropertyChanges {
                target: cueing_status_limits
                visible: false
            }

            PropertyChanges {
                target: platform_item
                visible: false
            }

            PropertyChanges {
                target: map_settings_item
                visible: false
            }

            PropertyChanges {
                target: throttle_brake_component
                visible: false
            }

            PropertyChanges {
                target: track_component
                visible: false
            }

            PropertyChanges {
                target: battery_item
                visible: false
            }

            PropertyChanges {
                target: dash_page_item
                dash_page_value: 2
            }

            PropertyChanges {
                target: power_regen_component
                visible: false
            }
        },
        State {
            name: "racing_map"

            PropertyChanges {
                target: tire_press_item
                visible: false
            }

            PropertyChanges {
                target: tire_temp_item
                visible: false
            }

            PropertyChanges {
                target: cueing_status_limits
                visible: false
            }

            PropertyChanges {
                target: platform_item
                visible: false
            }

            PropertyChanges {
                target: map_settings_item
                visible: false
            }

            PropertyChanges {
                target: battery_item
                visible: false
            }

            PropertyChanges {
                target: dash_page_item
                dash_page_value: 3
            }

            PropertyChanges {
                target: power_regen_component
                visible: false
            }

            PropertyChanges {
                target: throttle_brake_component
                x: 636
                y: 282
                visible: false
            }
        }
    ]

}







/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
