import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.12
import "../../../qml/default/default_db"

import com.vigrade.VIClass 1.0

Item {

    //.........................................................................
    //user parameters

    property double rpm_max: 6000           //max rpm
    property double rpm_red: 5500           //max rpm

    property double speed_max: 280              //max kph
    property bool mph_values: false             //conversion from km/h to mph

    property double battery_soc_yellow: 20      //level at which battery becomes yellow [%]
    property double battery_soc_red: 5          //level at which battery becomes red [%]

    property double motor_max: 150              //power maximum
    property double motor_red: 90              //power at which bocomes red

    property bool gg_diagram_split: false       //show splitted lateral and longitudinal values
    property double gg_diagram_max_g: 1.5       //max acc [g]
    property double gg_diagram_circle_width: 15 //width of the gg pointer [pixel]
    property double gg_trace_time: 3            //trace persistent time

    property int lap_best_time_type: 1  //calculation type of last and best time.
                                        //0: dashboard calculation ()
                                        //1: carrealtime calculation from VI_CarRealTime.Outputs.path_sensor.total_lap_time
                                        //2: external source (e.g. simulink) --> needs to specify in lap_time_best and lap_last_time

    property bool steering_wheel_forced_visibility: false   //if the steering wheel appears in pause

    property double dim_sim_name: 400               //DiM simulator name (150, 250, 400)
    property bool dimC: (root.dim_sim_name >= 350)  //true: DiM cable (400,..) or false: Sag DiM (150, 250,...)
    property bool data_check_mode: false    //forces pos_LP when using datacheck on dimC
    property bool platform_tracking_mode: true          //enable the tracking of the platform

    //local varibales to RTDB mapping
    property var qml_properties__RTDB_variables:
        ({
             steering_input:                "VI_CarRealTime.Inputs.Driver_Demands.str_swa",
             solver_status:                 "VI_DriveSim.Outputs.Vicrt.Status",
             fuel_consumption:              "VI_CarRealTime.Outputs.fuel_consumption.instantaneous_Liter_100km",
             gear:                          "VI_CarRealTime.Outputs.transmission.gear",
             manual_shifting:               "VI_CarRealTime.Outputs.transmission.manual_shifting_activity",
             rpm:                           "VI_CarRealTime.Outputs.engine.engine_rpm",
             shifting_mode:                 "VI_CarRealTime.Inputs.GearBox.automatic_gearbox_shifting_mode",
             speed:                         "VI_CarRealTime.Outputs.chassis_velocities.longitudinal",
             brake_demand:                  "VI_CarRealTime.Inputs.Driver_Demands.brake",
             throttle_demand:               "VI_CarRealTime.Inputs.Driver_Demands.throttle",
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
             //lap
             lap_num:                       "VI_DriveSim.Outputs.Vicrt.Lap.Num",
             lap_time:                      "VI_DriveSim.Outputs.Vicrt.Lap.Time",
//             lap_time_last:                 "",
             lap_time_last_crt:             "VI_CarRealTime.Outputs.path_sensor.total_lap_time",
//             lap_time_best:                 "",
             //turn indicators
             right_turn_indicator:          "VI_DriveSim.Outputs.VehicleLights.IndicatorRight",
             left_turn_indicator:           "VI_DriveSim.Outputs.VehicleLights.IndicatorLeft",
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

             esp_activity :                 "VI_CarRealTime.Outputs.Brake_System.ESP_Activity" ,
             hill_hold_activity :           "VI_CarRealTime.Outputs.Brake_System.Hill_Holder_Activity" ,
             launch_control_activity:                           "VI_CarRealTime.Outputs.engine.Launch_Control_activity" ,
             launch_control_engine_internal_activation:         "VI_CarRealTime.Inputs.Engine.internal_launch_control_activation" ,
             launch_control_engine_clutch_internal_activation:  "VI_CarRealTime.Inputs.Generic_Engine_to_Clutch.internal_launch_control_activation" ,
             //lights values
             mainLightsSwitch:              "ADAS.Inputs.Generic.MainLightsSwitch" ,
             highBeamLeft:                  "VI_DriveSim.Outputs.VehicleLights.HighBeamLeft" ,
             highBeamRight:                 "VI_DriveSim.Outputs.VehicleLights.HighBeamRight" ,
             lowBeamLeft:                   "VI_DriveSim.Outputs.VehicleLights.LowBeamLeft" ,
             lowBeamRight:                  "VI_DriveSim.Outputs.VehicleLights.LowBeamRight" ,
             //ADAS activities
             //ACC
             acc_on:                        "ADAS.Outputs.ACC.ACC_On_Display" ,
             acc_ready:                     "ADAS.Outputs.ACC.ACC_Ready_Display" ,
             acc_target_speed:              "ADAS.Outputs.ACC.ACC_Target_Speed" ,
             acc_target_on_display:         "ADAS.Outputs.ACC.ACC_Target_Id_Display" ,   //if the car in front is present
             acc_distance_step:             "ADAS.Outputs.ACC.ACC_Distance_Step" ,
             //BSD
             bsd_on_Left:                   "ADAS.Outputs.BSD.BSD_Detected_Left" ,
             bsd_on_Right:                  "ADAS.Outputs.BSD.BSD_Detected_Right",
             //LDW
             ldw_white:                     "ADAS.Outputs.LDW.LDW_White" ,
             ldw_ready:                     "ADAS.Outputs.LDW.LDW_Ready" ,
             ldw_on:                        "ADAS.Outputs.LDW.LDW_On" ,
             ldw_on_Left:                   "ADAS.Outputs.LDW.LDW_On_Left" ,
             ldw_on_Right:                  "ADAS.Outputs.LDW.LDW_On_Right" ,
             //LKA
             lka_on:                        "ADAS.Outputs.LKA.LKA_On_Display" ,
             lka_ready:                     "ADAS.Outputs.LKA.LKA_Ready" ,
             lka_white:                     "ADAS.Outputs.LKA.LKA_White" ,
             lka_on_Left:                   "ADAS.Outputs.LKA.LKA_On_Left" ,
             lka_on_Right:                  "ADAS.Outputs.LKA.LKA_On_Right" ,
             //AEB
             aeb_ready:                     "ADAS.Outputs.AEB.AEB_Ready" ,
             aeb_on:                        "ADAS.Outputs.AEB.AEB_On",
             aeb_brake_demand:              "ADAS.Outputs.AEB.AEB_BrakeDemand",
             //Auto-Pilot
             ap_ready:                      "ADAS.Outputs.AP.AP_Ready" ,
             ap_on:                         "ADAS.Outputs.AP.AP_On",
             //generic adas error
             adas_error:                    "ADAS.Outputs.Generic.ADAS_Error" ,
             //TSR traffic sign recognition
//             tsr_activity:                  "ADAS.Outputs.KONRAD.Mobileye.at_least_one_sign" ,
//             tsr_speed:                     "ADAS.Outputs.KONRAD.Mobileye.speed_limit",

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
         })
    //.........................................................................

    id: root
    visible: true

//    width: 1920                             //uncomment  for editing in Qt Design Studio
//    height: 720                             //uncomment  for editing in Qt Design Studio

    width: Window.width
    height: Window.height

    property double std_width: 1920
    property double std_height: 720

    //general passenger data
    property double solver_status: 0        //
    property double fuel_consumption: 0     //l/100km
    property double steering_input: 0       //rad
    property int gear: 0                    //gear selected
    property bool manual_shifting: true     //gear manual shifting. if false, automatic shifting enabled
    property double rpm: 0                  //rpm
    property bool shifting_mode: false      //false: comfort, true: sport mode
    property double speed: 0                //speed in km/h. to switch to miles, change mph_values
    property double brake_demand: 0         //%
    property double throttle_demand: 0      //%

    //gg diagram
    property double lateral_acceleration: 0         //lateral acc in [g]
    property double longitudinal_acceleration: 0    //longitudinal acc in [g]

    //left and right turn indicators
    property bool right_turn_indicator: true
    property bool left_turn_indicator: true

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

    //lap times value
    property double lap_num: 0
    property double lap_time: 0
    property double lap_time_last: 0
    property double lap_time_last_crt: 0
    property double lap_time_best: 0

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
    property bool mainLightsSwitch: false
    property bool highBeamLeft: true
    property bool highBeamRight: false
    property bool highBeam_on: root.highBeamLeft || root.highBeamRight
    property bool lowBeamLeft: true
    property bool lowBeamRight: false
    property bool lowBeam_on: root.lowBeamLeft|| root.lowBeamRight

    //ADAS activities
    //ACC
    property bool acc_on: true
    property bool acc_ready: true
    property double acc_target_speed: 0
    property bool acc_target_on_display: true   //if the car in front is present
    property int acc_distance_step: 3
    //BSD
    property bool bsd_on_Left: true
    property bool bsd_on_Right: true
    //LDW
    property bool ldw_white: true
    property bool ldw_ready: true
    property bool ldw_on: true
    property bool ldw_on_Left: true
    property bool ldw_on_Right: true
    //LKA
    property bool lka_on: true
    property bool lka_ready: true
    property bool lka_white: true
    property bool lka_on_Left: true
    property bool lka_on_Right: true
    //AEB
    property bool aeb_ready: true
    property bool aeb_on: false
    property bool aeb_brake_demand: false
    //Auto-Pilot
    property bool ap_ready: true
    property bool ap_on: false
    //generic adas error
    property bool adas_error: false
    //TSR traffic sign recognition
    property bool tsr_activity: true
    property double tsr_speed: 50

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



    onAp_onChanged: {
        if (root.solver_status === 1){
            messages_item.rectangle_border = dashboard_Utils.vi_dark_grey
            if (root.ap_on){
                messages_item.message_value = "Auto-Pilot engaged"
                messages_item.message_action_value = ""
            }else{
                if (root.acc_on){
                    messages_item.message_value = "Auto-Pilot disengaged                        ACC still active"
                    messages_item.message_action_value = "TAKE STEER CONTROL!"
                }else{
                    messages_item.message_value = "Auto-Pilot disengaged"
                    messages_item.message_action_value = "TAKE CONTROL !"
                }
            }
        }
    }

    onAcc_onChanged: {
        if (root.solver_status === 1){
            messages_item.rectangle_border = dashboard_Utils.vi_dark_grey
            if (root.acc_on){
                messages_item.message_value = "Adaptive Cruise Control engaged"
                messages_item.message_action_value = ""
            }else{
                messages_item.message_value = "Adaptive Cruise Control disengaged"
                messages_item.message_action_value = "TAKE CONTROL !"
            }
        }
    }
    onAeb_onChanged: {
            if (root.aeb_on){
                messages_item.rectangle_border = dashboard_Utils.vi_red
                messages_item.message_value = ""
                messages_item.message_action_value = "EMERGENCY BRAKE !"
            }else{
                messages_item.rectangle_border = dashboard_Utils.vi_dark_grey
                messages_item.message_value = ""
                messages_item.message_action_value = ""
            }
            if (!root.aeb_brake_demand){
                messages_item.rectangle_border = dashboard_Utils.vi_dark_grey
                messages_item.message_value = "Ready to GO"
                messages_item.message_action_value = ""
            }
    }

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

    Rectangle {
        id: background
        color: dashboard_Utils.vi_black
        anchors.fill: parent
    }

    Item{
        id: scaling
        width: parent.width
        height: parent.height
        scale: dashboard_Utils.resize_content(parent.width, parent.height, root.std_width, root.std_height)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Speedometer_component {
            id: speed_item
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -660
            anchors.verticalCenter: parent.verticalCenter
            speed_value: root.speed
            shifting_mode: root.shifting_mode
            mph_value: root.mph_values
            max_speed_value: root.speed_max
            fuel_consumption: root.fuel_consumption
            solver_status: root.solver_status
            acc_target_speed: root.acc_target_speed
            acc_ready: root.acc_ready
            acc_on: root.acc_on
        }

        Rpm_component {
            id: rpm_item
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 660
            anchors.verticalCenter: parent.verticalCenter
            rpm_value: root.rpm
            rpm_red_value: root.rpm_red
            rpm_max_value: root.rpm_max
            gear_value: root.gear
            shifting_mode: root.shifting_mode
            automatic_shifting: !root.manual_shifting
        }

        Dashboard_Lights {
            id: lights_item
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            right_indicator: root.right_turn_indicator
            tcs_on: root.tcs_activity
            low_beam_on: root.lowBeam_on
            lka_white: root.lka_white
            lka_ready: root.lka_ready
            lka_on: root.lka_on
            light_switch: root.mainLightsSwitch
            left_indicator: root.left_turn_indicator
            ldw_white: root.ldw_white
            ldw_ready: root.ldw_ready
            ldw_on: root.ldw_on
            high_beam_on: root.highBeam_on
            ap_ready: root.ap_ready
            ap_on: root.ap_on
            aeb_ready: root.aeb_ready
            aeb_on: root.aeb_on
            abs_on: root.abs_activity
            esp_on: root.esp_activity
            hill_hold_on: root.hill_hold_activity
            anchors.verticalCenterOffset: -302
        }

        Battery_component {
            id: battery_item
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 660
            anchors.verticalCenter: parent.verticalCenter
            power_value: root.motor
            power_red_value: root.motor_red
            power_max_value: root.motor_max
            battery_soc_yellow_value: root.battery_soc_yellow
            battery_soc_value: root.battery_soc
            battery_soc_red_value: root.battery_soc_red
        }

        Steering_wheel_widget {
            id: steering_wheel_widget
            //visible: root.steering_wheel_visibility
            str_wheel_Rotation: root.steering_input
            solver_status: root.solver_status
            anchors.horizontalCenterOffset: 289
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            str_wheel_forced_Visible: root.steering_wheel_forced_visibility
            anchors.verticalCenterOffset: -98
        }

        Car_road_adas_component {
            id: cars_road
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            radar_red_visible_aeb: root.aeb_on
            radar_green_visible_aeb: root.aeb_ready
            radar_green_visible_acc: root.acc_on || root.ap_on
            lka_ready: root.lka_ready
            lka_on_right: root.lka_on_Right
            lka_on_left: root.lka_on_Left
            ldw_ready: root.ldw_ready
            ldw_on_right: root.ldw_on_Right
            ldw_on_left: root.ldw_on_Left
            front_car_visible_aeb: root.acc_target_on_display
            front_car_visible_acc: root.acc_target_on_display
            bsd_on_right: root.bsd_on_Right
            bsd_on_left: root.bsd_on_Left
            acc_levels: root.acc_distance_step
            anchors.verticalCenterOffset: 143
        }

        Messages_component {
            id: messages_item
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -160
        }

        Image {
            id: adas_error
            width: 156
            height: 128
            visible: root.adas_error
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/adas_error.png"
            anchors.verticalCenterOffset: 176
            anchors.horizontalCenterOffset: -406
            mipmap: true
            fillMode: Image.PreserveAspectFit
        }

        Traffic_sign_widget {
            id: traffic_sign_widget
            anchors.verticalCenterOffset: 70
            anchors.horizontalCenterOffset: -276
            scale: 0.8
            sign_speed: root.tsr_speed
            traffic_sign_activity: root.tsr_activity
        }
            Laptime_item{
                id: laptime_item
                anchors.verticalCenter: parent.verticalCenter
                lap_time_value: root.lap_time
                lap_num_value: root.lap_num
                lap_last_time_value: root.lap_time_last
                lap_last_time_crt_value: root.lap_time_last_crt
                lap_best_time_value: root.lap_time_best
                internal_last_best_computation: root.lap_best_time_type
                scale: 1.3
                laptime_backgroundColor: dashboard_Utils.vi_dark_grey
                anchors.verticalCenterOffset: 207
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
            }

            GG_diagram{
                id: gg_diagram
                anchors.verticalCenter: parent.verticalCenter
                split_g: root.gg_diagram_split
                max_g: root.gg_diagram_max_g
                longitudinal: root.longitudinal_acceleration
                lateral: root.lateral_acceleration
                gg_circleWidth: root.gg_diagram_circle_width
                gg_trace_time: root.gg_trace_time
                scale: 0.85
                solver_status: root.solver_status
                anchors.horizontalCenterOffset: 0
                anchors.verticalCenterOffset: -102
                anchors.horizontalCenter: parent.horizontalCenter
                gg_backgroundColor: dashboard_Utils.vi_dark_grey
            }

            Launch_control_component{
                id: launch_control_item
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                scale: 0.7
                anchors.verticalCenterOffset: -160
                throttle_value: root.throttle_demand
                launch_control_value: root.launch_control_activity
                launch_control_input_value: root.launch_control_internal_activation
                brake_value: root.brake_demand
            }

            Cueing_status_limits{
                id: cueing_status_item
                anchors.verticalCenter: parent.verticalCenter
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
                anchors.verticalCenterOffset: 211
                anchors.horizontalCenterOffset: 289
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Platform{
                id: platform_item
                anchors.verticalCenter: parent.verticalCenter
                scale: 0.5
                anchors.verticalCenterOffset: 205
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

            DriveSim_connection_item{
                id: drivesim_connection
                width: 340
                height: 85
                anchors.verticalCenter: parent.verticalCenter
                driveSim_connected: dashboard_Utils.driveSim_activity
                driveSim_connection_rectColor: dashboard_Utils.vi_dark_grey
                anchors.verticalCenterOffset: 311
                anchors.horizontalCenterOffset: 660
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: vigrade
                anchors.verticalCenter: parent.verticalCenter
                source: "images/vi-grade.png"
                mipmap: true
                scale: 0.8
                anchors.verticalCenterOffset: 303
                anchors.horizontalCenterOffset: -770
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: hour
                x: 414
                y: 658
                color: dashboard_Utils.vi_cream
                text: new Date().toLocaleTimeString(Qt.locale("en_EN"),Locale.ShortFormat)
                anchors.horizontalCenterOffset: -550
                font.family: "Sansation"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenterOffset: 311
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
    }

    OpenSans_Regular{}
    Monofur{}
    Sansation_Regular{}

    Dashboard_Utils{
        id: dashboard_Utils
        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_R) {
                //reset best lap
                laptime_item.reset_lap_value ++;
                console.log("reset the best lap n°:" + laptime_item.reset_lap_value)
            }
            if (event.key === Qt.Key_Left) {
                console.log("page down")
                dashboard_Utils.change_page(-1)
            }
            if (event.key === Qt.Key_Right) {
                console.log("page up")
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

    //switch automatically between states depending on current folder name

    //get current path
    property var folder_path: Qt.resolvedUrl(".").split("/")
    //select splitting current path the current folder (last non-void element of the array)
    state: "passenger" //root.folder_path[root.folder_path.length-2]
    states: [
        State {
            name: "passenger"

            PropertyChanges {
                target: platform_item
                visible: false
            }

            PropertyChanges {
                target: battery_item
                visible: false
            }

            PropertyChanges {
                target: cars_road
                visible: false
            }

            PropertyChanges {
                target: messages_item
                visible: false
            }

            PropertyChanges {
                target: cueing_status_item
                visible: false
            }

            PropertyChanges {
                target: adas_error
                visible: false
            }

            PropertyChanges {
                target: traffic_sign_widget
                visible: false
            }

            PropertyChanges {
                target: speed_item
                acc_visibility: false
            }
        },
        State {
            name: "passenger_EV"

            PropertyChanges {
                target: rpm_item
                visible: false
            }

            PropertyChanges {
                target: cars_road
                visible: false
            }

            PropertyChanges {
                target: messages_item
                visible: false
            }

            PropertyChanges {
                target: adas_error
                visible: false
            }

            PropertyChanges {
                target: cueing_status_item
                visible: false
            }

            PropertyChanges {
                target: platform_item
                visible: false
            }

            PropertyChanges {
                target: traffic_sign_widget
                visible: false
            }

            PropertyChanges {
                target: speed_item
                fuel_consumption_visibility: false
                acc_visibility: false
            }
        },
        State {
            name: "passenger_ADAS"

            PropertyChanges {
                target: cueing_status_item
                visible: false
            }

            PropertyChanges {
                target: platform_item
                visible: false
            }

            PropertyChanges {
                target: laptime_item
                visible: false
            }

            PropertyChanges {
                target: gg_diagram
                visible: false
            }

            PropertyChanges {
                target: battery_item
                visible: false
            }

            PropertyChanges {
                target: steering_wheel_widget
                anchors.verticalCenterOffset: 70
                anchors.horizontalCenterOffset: 289
            }

            PropertyChanges {
                target: traffic_sign_widget
                visible: false
            }
        },
        State {
            name: "passenger_ADAS_EV"
            PropertyChanges {
                target: cueing_status_item
                visible: false
            }

            PropertyChanges {
                target: platform_item
                visible: false
            }

            PropertyChanges {
                target: laptime_item
                visible: false
            }

            PropertyChanges {
                target: gg_diagram
                visible: false
            }

            PropertyChanges {
                target: steering_wheel_widget
                anchors.verticalCenterOffset: 70
                anchors.horizontalCenterOffset: 289
            }

            PropertyChanges {
                target: rpm_item
                visible: false
            }

            PropertyChanges {
                target: traffic_sign_widget
                visible: false
            }

            PropertyChanges {
                target: speed_item
                fuel_consumption_visibility: false
            }
        },
        State {
            name: "passenger_DiM"

            PropertyChanges {
                target: battery_item
                visible: false
            }

            PropertyChanges {
                target: cars_road
                visible: false
            }

            PropertyChanges {
                target: messages_item
                visible: false
            }

            PropertyChanges {
                target: adas_error
                visible: false
            }

            PropertyChanges {
                target: traffic_sign_widget
                visible: false
            }

            PropertyChanges {
                target: laptime_item
                scale: 0.8
                anchors.verticalCenterOffset: 205
                anchors.horizontalCenterOffset: -328
            }

            PropertyChanges {
                target: speed_item
                acc_visibility: false
            }
        },
        State {
            name: "passenger_DiM_EV"

            PropertyChanges {
                target: cars_road
                visible: false
            }

            PropertyChanges {
                target: messages_item
                visible: false
            }

            PropertyChanges {
                target: adas_error
                visible: false
            }

            PropertyChanges {
                target: traffic_sign_widget
                visible: false
            }

            PropertyChanges {
                target: laptime_item
                scale: 0.8
                anchors.verticalCenterOffset: 205
                anchors.horizontalCenterOffset: -328
            }

            PropertyChanges {
                target: rpm_item
                visible: false
            }

            PropertyChanges {
                target: speed_item
                fuel_consumption_visibility: false
                acc_visibility: false
            }
        }
    ]
}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
