import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.13
import "../../../qml/default/default_db"


import com.vigrade.VIClass 1.0


Item {


    //.........................................................................
    //user parameters

    property double dim_sim_name: 400                   //DiM simulator name (150, 250, 400)
    property bool dimC: (root.dim_sim_name >= 350)      //true: DiM cable (400,..) or false: Sag DiM (150, 250,...)
    property bool data_check_mode: false                //forces pos_LP when using datacheck on dimC
    property bool platform_tracking_mode: true          //enable the tracking of the platform

    property bool steering_wheel_visibility: true   //if the steering wheel appears in pause


    //local varibales to RTDB mapping
    property var qml_properties__RTDB_variables:
        ({   pos_long_LP:                   "VI_DriveSim.Outputs.Platform.Cueing.POSLONG_LP",
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
             steering_input:                "VI_CarRealTime.Inputs.Driver_Demands.str_swa",
             solver_status:                 "VI_DriveSim.Outputs.Vicrt.Status",
             aB_drive_status:               "VI_DriveSim.Inputs.ECAT.Brake.DriveStatus",
             aB_drive_fault:                "VI_DriveSim.Inputs.ECAT.Brake.Fault",
             aB_drive_programStatus:        "VI_DriveSim.Inputs.ECAT.Brake.ProgramStatus",
             str_drive_status:              "VI_DriveSim.Inputs.ECAT.SteeringWheel.DriveStatus",
             str_drive_fault:               "VI_DriveSim.Inputs.ECAT.SteeringWheel.Fault",
             str_drive_programStatus:       "VI_DriveSim.Inputs.ECAT.SteeringWheel.ProgramStatus",
             //lap
             lap_num:                       "VI_DriveSim.Outputs.Vicrt.Lap.Num",
             lap_time:                      "VI_DriveSim.Outputs.Vicrt.Lap.Time",

             platform_sound_notice:         "bk_1/enable_sound_notice",
             platform_sound_notice_level:   "BK.SPECIAL_CUSTOM_TRIGGER_PARKING_SENSOR_FRONT_LEFT"
         })


    //.........................................................................


    id: root
    visible: true

    width: Window.width
    height: Window.height
//    width: 1280
//    height: 720


    property double std_width: 1280
    property double std_height: 720

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

    property double steering_input: 0           //steering input [rad]

    property double solver_status: 0        //crt solver status

    property double aB_drive_status: 0          //active brake status
    property double aB_drive_fault: 1
    property double aB_drive_programStatus: 0

    property double str_drive_status: 0         //steeering wheel status
    property double str_drive_fault: 1
    property double str_drive_programStatus: 0

    //lap times value
    property double lap_num: 0
    property double lap_time: 0

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


    Image {
        id: carbon_fiber
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        fillMode: Image.Stretch
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "images/carbon-fiber.jpg"


        //Photo by <a href="/photographer/takje-63859">takje</a> from <a href="https://freeimages.com/">FreeImages</a>
    }

    Item{
        id: scaling
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        scale: dashboard_Utils.resize_content(parent.width, parent.height, root.std_width, root.std_height)


        Item {
            id: background
            x: 0
            y: 0
            width: parent.width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Image {
                id: vi_grade_logo
                x: 884
                y: 595
                width: 262
                height: 146
                scale: 0.7
                anchors.horizontalCenterOffset: 300
                anchors.verticalCenterOffset: 320
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "images/vi-grade.png"
            }

            DriveSim_connection_item {
                id: driveSim_connection_item
                width: 381
                height: 80
                anchors.verticalCenter: parent.verticalCenter
                driveSim_connection_rectColor: dashboard_Utils.vi_black
                driveSim_connected: dashboard_Utils.driveSim_activity
                anchors.verticalCenterOffset: 320
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: hour
                x: 414
                y: 658
                color: dashboard_Utils.vi_cream
                text: new Date().toLocaleTimeString(Qt.locale("en_EN"),Locale.ShortFormat)
                anchors.horizontalCenterOffset: -300
                font.family: "Sansation"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenterOffset: 320
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

        Platform {
            id: platform
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -30
            anchors.horizontalCenterOffset: 0
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

        Cueing_status_limits {
            id: cueing_status_limits
            cueing_status: root.cueing_status
            cueing_request: root.cueing_request
            status_operation: root.status_operation
            status_stream: root.status_stream
            status_hmi: root.status_hmi
            solver_status: root.solver_status
            cueing_status_limit_lat_roll: root.cueing_status_limit_lat_roll
            cueing_status_limit_long_pitch: root.cueing_status_limit_long_pitch
            cueing_status_limit_vert: root.cueing_status_limit_vert
            cueing_status_limit_yaw: root.cueing_status_limit_yaw
            anchors.verticalCenterOffset: 150
            anchors.horizontalCenterOffset: -480
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: rectangle_steering_wheel
            x: 939
            y: 60
            width: 236
            height: 123
            color: dashboard_Utils.vi_black
            radius: 10
            border.width: 0
            anchors.verticalCenterOffset: -150
            anchors.horizontalCenterOffset: -480
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Steering_wheel_widget {
                id: steering_wheel_widget
                x: 26
                y: 25
                solver_status: dashboard_Utils.vICRT_SOLVER_STATUS_STARTED      //in this way it is always grey
                str_wheel_Rotation: root.steering_input
                str_wheel_forced_Visible: root.steering_wheel_visibility
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text_angleVisible: true
            }
        }

        Active_brake_status {
            id: active_brake_status
            anchors.verticalCenterOffset: -150
            anchors.horizontalCenterOffset: 480
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            active_brake_status: root.aB_drive_status
            active_brake_fault: root.aB_drive_fault
            active_brake_programStatus: root.aB_drive_programStatus
            solver_status: root.solver_status
        }

        Steering_wheel_status {
            id: steering_wheel_status
            anchors.verticalCenterOffset: 150
            anchors.horizontalCenterOffset: 480
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            steering_wheel_fault: root.str_drive_fault
            steering_wheel_programStatus: root.str_drive_programStatus
            steering_wheel_status: root.str_drive_status
            solver_status: root.solver_status
        }
    }


    Monofur{}
    Sansation_Regular{}
    OpenSans_Regular{}
    Dashboard_Utils{
        id: dashboard_Utils
        focus: true
        Keys.onPressed: {
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
}


