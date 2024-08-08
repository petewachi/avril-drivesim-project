import QtQuick 2.12

import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4


import QtQuick.Studio.Components 1.0
import QtGraphicalEffects 1.0
import "../../../qml/default/default_db"

import com.vigrade.VIClass 1.0          //to be commented while editing in Qt Design Studio


Item {


    //.........................................................................
    //worldsim master ip port of http server (as the one in DriveSim-WorldSim configuration section)
    property string ws_ip : "127.0.0.1"
    property string ws_port : "8080"

    //dimensions
    //    width: 1920
    //    height: 1080

    width: Window.width
    height: Window.height

    //.........................................................................
    //rtdb items
    property var qml_properties__RTDB_variables:
        ({
             solver_status:                 "VI_DriveSim.Outputs.Vicrt.Status",
             dashboard_state_from_other:    "HMI.Outputs.Menu",

             acc_activity:                  "ADAS_Modular_1/ACC_Module_Activity_Flag",
             ldw_activity:                  "ADAS_Modular_1/LDW_Activity_Flag",
             lka_activity:                  "ADAS_Modular_1/LKA_Activity_Flag",
             ap_activity:                   "ADAS_Modular_1/AP_Activity_Flag",
             aeb_activity:                  "ADAS_Modular_1/AEB_Module_Activity_Flag",
             adas_mode:                     "ADAS_Modular_1/ADAS_Control_Mode",

             highBeamLeft:                  "VI_DriveSim.Outputs.VehicleLights.HighBeamLeft",
             highBeamRight:                 "VI_DriveSim.Outputs.VehicleLights.HighBeamRight",
             lowBeamLeft:                   "VI_DriveSim.Outputs.VehicleLights.LowBeamLeft",
             lowBeamRight:                  "VI_DriveSim.Outputs.VehicleLights.LowBeamRight",
             lights_switch:                 "ADAS.Inputs.Generic.MainLightsSwitch",

             abs_activity:                  "VI_CarRealTime.Inputs.ABS.Internal_ABS_Activity",
             tcs_activity:                  "VI_CarRealTime.Inputs.TCS.Internal_TCS_Activity",             
             esp_activity :                 "VI_CarRealTime.Inputs.ESP.internal_ESP_activity" ,
             hill_hold_activity :           "VI_CarRealTime.Inputs.HillHolder.internal_HillHolder_activity" ,
             launch_control_engine_activity:"VI_CarRealTime.Inputs.Engine.internal_launch_control_activation" ,
             launch_control_engine_clutch_activity:"VI_CarRealTime.Inputs.Generic_Engine_to_Clutch.internal_launch_control_activation" ,
             eps_map:                       "VI_CarRealTime.Inputs.Steering_System.eps_map",
             shifting_mode:                 "VI_CarRealTime.Inputs.GearBox.automatic_gearbox_shifting_mode",

             //hmi
             incoming_call_trigger:         "HMI.Inputs.Calling",
             incoming_call_sound:           "BK.SPECIAL_CUSTOM_TRIGGER_HORN_2",
             radio_1_sound:                 "BK.SPECIAL_CUSTOM_TRIGGER_RADIO_SPEECH",
             radio_2_sound:                 "BK.SPECIAL_CUSTOM_TRIGGER_RADIO_MUSIC",

             //navigation system
             latitude:                      "WorldSim.ego.Sensors.GPS.GpsPosition.Latitude",
             longitude:                     "WorldSim.ego.Sensors.GPS.GpsPosition.Longitude"
         })

    //.........................................................................


    id: root
    visible: true

    //management of states, and incoming states from twin dashboard
    property var states_list: []
    property double dashboard_state: 0
    property double dashboard_state_from_other: 0

    //solver status
    property double solver_status: 0
    //hmi
    property double incoming_call_trigger: 0    //trigger for the incoming incoming_call_trigger
    property double incoming_call_sound: 0      //bk signal for call sound in simsound
    property double radio_1_sound: 0            //bk signal for even radio station in simsound
    property double radio_2_sound: 0            //bk signal for odd radio station in simsound

    property int std_width: 1300
    property int std_height: 1080

    //adas activity values
    property bool acc_activity: false       //"ADAS_Modular_1/ACC_Module_Activity_Flag"
    property bool ldw_activity: false       //"ADAS_Modular_1/LDW_Activity_Flag"
    property bool lka_activity: false       //"ADAS_Modular_1/LKA_Activity_Flag",
    property bool ap_activity: false        //"ADAS_Modular_1/AP_Activity_Flag",
    property bool aeb_activity: false       //"ADAS_Modular_1/AEB_Module_Activity_Flag",
    property double adas_mode: 1            //"ADAS_Modular_1/ADAS_Control_Mode",
    //possible values: 1: comfrot, 2:aggressive

    //headlamps signals
    property bool highBeamLeft: false       //"VI_DriveSim.Outputs.VehicleLights.HighBeamLeft",
    property bool highBeamRight: false      //"VI_DriveSim.Outputs.VehicleLights.HighBeamRight",
    property bool lowBeamLeft: false        //"VI_DriveSim.Outputs.VehicleLights.LowBeamLeft",
    property bool lowBeamRight: false       //"VI_DriveSim.Outputs.VehicleLights.LowBeamRight",
    property bool lights_switch: false      //"ADAS.Inputs.Generic.MainLightsSwitch",
    //values: 1: manula lights, 2: automatic

    //abs and tcs activities
    property bool abs_activity: false       //"VI_CarRealTime.Inputs.ABS.Internal_ABS_Activity",
    property bool tcs_activity: false
    property bool esp_activity: false
    property bool hill_hold_activity: false
    property bool launch_control_engine_activity: false
    property bool launch_control_engine_clutch_activity: false
    property bool launch_control_activity: (root.launch_control_engine_activity || root.launch_control_engine_clutch_activity)
    //eps : 1, 2, 3. o default (1)
    property double eps_map: 0              //"VI_CarRealTime.Inputs.Steering_System.eps_map",
    //automatic gearbox shifting mode
    property bool shifting_mode: false      //"VI_CarRealTime.Inputs.GearBox.automatic_gearbox_shifting_mode",
    //automatic shifting mode : 0 comfort, 1 sport

    //worldsim based navigation system
    property double latitude: 42.2991485595703
    property double longitude: -83.6989288330078

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

    Component.onCompleted: {
        //create the state list by adding an object to each position of the array "states_list"
        for (var item in root.states)
            root.states_list.push(root.states[item].name)
    }
    onStateChanged: {
        if (root.state === "radio"){
            //radio start when selected that menu
            radio_item.radio_sound = true;
        }

        //set the state number into a root local variable dashboard_state
        if (root.dashboard_state !== root.dashboard_state_from_other){
            for (var item in root.states){
                if (root.states[item].name === root.state){
                    root.dashboard_state = parseInt(item);
                }
            }
            // viclass set rtdb for dashboard_menu
            viclass.setChannelValue(root.qml_properties__RTDB_variables["dashboard_state_from_other"], root.dashboard_state)
        }
    }
    onDashboard_state_from_otherChanged: {
        // when the state from the rtdb changes, it can be becuase:
        //1. we set it from this dashboard in the "onStateChanged" function --> no action
        //2. we received a new state from a twin dashboard in another pc and we want to replicate it here --> start the trigger
        state_trigger.restart()
    }

    Timer{
        id: state_trigger
        running: false
        repeat: false
        interval: 100
        onTriggered: {
            //set the state as it is coming from the rtdb checking in the state list the good state for a number
            root.state = root.states_list[root.dashboard_state_from_other]
        }
    }

    onIncoming_call_triggerChanged: {
        // when the RTDB trigger of the clal is active, go to correct states
        if (root.incoming_call_trigger !== 0){
            root.state = "phone"
            phone_item.state = "incoming"
        }
    }

    Image {
        id: image_background
        x: 233
        y: 175
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.Stretch
        source: "images/dark-abstract-black.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        transformOrigin: Item.Center
    }

    Item{
        id: scaling
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        // this resize content is used to manage different window dimensions
        scale: dashboard_Utils.resize_content(parent.width, parent.height, root.std_width, root.std_height)

        Image {
            id: logo_image
            x: -843
            y: -1966
            width: 312
            height: 200
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "images/vi-grade.png"
            anchors.verticalCenterOffset: -470
            anchors.horizontalCenterOffset: -478
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Clocks{
            id: clock
            x: 131
            y: -1306
            width: 224
            height: 218
            color: "#00646464"
            anchors.verticalCenter: parent.verticalCenter
            scale: 1.1
            anchors.verticalCenterOffset: -420
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        DriveSim_connection_item {
            id: driveSim_connection_item
            x: 808
            y: -1829
            width: 340
            height: 110
            anchors.verticalCenter: parent.verticalCenter
            driveSim_connection_rectColor: dashboard_Utils.vi_black
            anchors.verticalCenterOffset: -470
            anchors.horizontalCenterOffset: 472
            anchors.horizontalCenter: parent.horizontalCenter
            driveSim_connected: dashboard_Utils.driveSim_activity
        }

        Item {
            id: functions_buttons_item
            width: root.std_width
            height: 825
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: 0
            anchors.verticalCenterOffset: 120
            anchors.horizontalCenter: parent.horizontalCenter

            //big buttons that are used to switch between pages
            Grid {
                id: functions_buttons_item_grid
                property double buttons_dimension: 300
                anchors.fill: parent
                topPadding: 50
                leftPadding: 5
                rows: 2
                columns: 4
                columnSpacing: 30
                rowSpacing: 100

                Button_item_mouse {
                    id: adas_button_item_mouse
                    width: functions_buttons_item_grid.buttons_dimension
                    height: functions_buttons_item_grid.buttons_dimension
                    button_background_color_value: dashboard_Utils.vi_green
                    button_icon_value: "images/adas_icon.png"
                    onReleased: {
                        console.log("adas")
                        root.state = "adas"
                    }
                }

                Button_item_mouse {
                    id: controlsbutton_item_mouse
                    width: functions_buttons_item_grid.buttons_dimension
                    height: functions_buttons_item_grid.buttons_dimension
                    button_background_color_value: dashboard_Utils.vi_petrol
                    button_icon_value: "images/abs_tcs_icon.png"
                    onReleased: {
                        console.log("controls")
                        root.state = "controls"
                    }
                }

                Button_item_mouse {
                    id: lights_button_item_mouse
                    width: functions_buttons_item_grid.buttons_dimension
                    height: functions_buttons_item_grid.buttons_dimension
                    button_background_color_value: dashboard_Utils.vi_yellow
                    button_icon_value: "images/lights_icon.png"
                    onReleased: {
                        console.log("lights")
                        root.state = "lights"
                    }
                }

                Button_item_mouse {
                    id: climate_button_item_mouse
                    width: functions_buttons_item_grid.buttons_dimension
                    height: functions_buttons_item_grid.buttons_dimension
                    button_background_color_value: dashboard_Utils.vi_azure
                    button_icon_value: "images/havc_icon.png"
                    onReleased: {
                        console.log("climate")
                        root.state = "climate"
                    }
                }

                Button_item_mouse {
                    id: radio_button_item_mouse
                    width: functions_buttons_item_grid.buttons_dimension
                    height: functions_buttons_item_grid.buttons_dimension
                    button_background_color_value: dashboard_Utils.vi_red
                    button_icon_value: "images/radio_icon.png"
                    onReleased: {
                        console.log("radio")
                        root.state = "radio"
                    }
                }

                Button_item_mouse {
                    id: phone_button_item_mouse
                    width: functions_buttons_item_grid.buttons_dimension
                    height: functions_buttons_item_grid.buttons_dimension
                    button_background_color_value: dashboard_Utils.vi_fucsia
                    button_icon_value: "images/phone_icon.png"
                    onReleased: {
                        console.log("phone")
                        root.state = "phone"
                    }
                }

                Button_item_mouse {
                    id: navi_button_item_mouse
                    width: functions_buttons_item_grid.buttons_dimension
                    height: functions_buttons_item_grid.buttons_dimension
                    button_icon_value: "images/navi_icon.png"
                    button_background_color_value: dashboard_Utils.vi_white
                    onReleased: {
                        console.log("simple_navigator")
                        root.state = "simple_navigator"
                    }
                }
            }
        }

        Adas_item {
            id: adas_item
            visible: false
            enabled: false
            acc_activity_value: root.acc_activity
            ldw_activity_value: root.ldw_activity
            lka_activity_value: root.lka_activity
            ap_activity_value: root.ap_activity
            aeb_activity_value: root.aeb_activity
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: 0
            scale: 0.8
            anchors.verticalCenterOffset: 74
            lka_activity_rtdb: root.qml_properties__RTDB_variables["lka_activity"]
            ldw_activity_rtdb: root.qml_properties__RTDB_variables["ldw_activity"]
            ap_activity_rtdb: root.qml_properties__RTDB_variables["ap_activity"]
            adas_mode_value: root.adas_mode
            aeb_activity_rtdb: root.qml_properties__RTDB_variables["aeb_activity"]
            adas_mode_rtdb: root.qml_properties__RTDB_variables["adas_mode"]
            acc_activity_rtdb: root.qml_properties__RTDB_variables["acc_activity"]
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls_item {
            id: controls_item
            visible: false
            enabled: false
            scale: 0.8
            anchors.verticalCenter: parent.verticalCenter
            tcs_activity_value: root.tcs_activity
            tcs_activity_rtdb: root.qml_properties__RTDB_variables["tcs_activity"]
            shifting_mode_value: root.shifting_mode
            shifting_mode_rtdb: root.qml_properties__RTDB_variables["shifting_mode"]
            eps_value: root.eps_map
            eps_rtdb: root.qml_properties__RTDB_variables["eps_map"]
            abs_activity_value: root.abs_activity
            abs_activity_rtdb: root.qml_properties__RTDB_variables["abs_activity"]
            esp_activity_value: root.esp_activity
            esp_activity_rtdb: root.qml_properties__RTDB_variables["esp_activity"]
            hill_hold_activity_value: root.hill_hold_activity
            hill_hold_activity_rtdb: root.qml_properties__RTDB_variables["hill_hold_activity"]
            launch_control_activity_value: root.launch_control_activity
            launch_control_activity_rtdb: root.qml_properties__RTDB_variables["launch_control_engine_activity"]
            anchors.verticalCenterOffset: 74
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Lights_item {
            id: lights_item
            visible: false
            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            lowBeamRight_value: root.lowBeamRight
            lowBeamRight_rtdb: root.qml_properties__RTDB_variables["lowBeamRight"]
            lowBeamLeft_value: root.lowBeamLeft
            lowBeamLeft_rtdb: root.qml_properties__RTDB_variables["lowBeamLeft"]
            lights_switch_value: root.lights_switch
            lights_switch_rtdb: root.qml_properties__RTDB_variables["lights_switch"]
            highBeamRight_value: root.highBeamRight
            highBeamLeft_value: root.highBeamLeft
            highBeamRight_rtdb: root.qml_properties__RTDB_variables["highBeamRight"]
            highBeamLeft_rtdb: root.qml_properties__RTDB_variables["highBeamLeft"]
            scale: 0.8
            anchors.verticalCenterOffset: 74
            anchors.horizontalCenter: parent.horizontalCenter
        }


        Climate_item {
            id: climate_item
            visible: false
            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            scale: 0.8
            anchors.verticalCenterOffset: 74
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Radio_item {
            id: radio_item
            visible: false
            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            scale: 0.8
            anchors.verticalCenterOffset: 74
            anchors.horizontalCenter: parent.horizontalCenter
            onStation_numberChanged: {
                if (radio_item.radio_sound){
                    //switch to the radio speech or sound depending on the radio station (even/odd rule)
                    if (!radio_item.station_number){
                        console.log("radio 2")
                        viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_1_sound"], 0)
                        viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_2_sound"], 1)
                    }else{
                        console.log("radio 1")
                        viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_1_sound"], 1)
                        viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_2_sound"], 0)
                    }
                }
            }
            onRadio_soundChanged: {
                if (!radio_item.radio_sound){
                    //switch off the radio when off
                    viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_1_sound"], 0)
                    viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_2_sound"], 0)
                }else{
                    //switch on depending on radio station
                    if (!radio_item.station_number){
                        viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_1_sound"], 0)
                        viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_2_sound"], 1)
                    }else{
                        viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_1_sound"], 1)
                        viclass.setChannelValue(root.qml_properties__RTDB_variables["radio_2_sound"], 0)
                    }
                }
            }
        }

        Phone_item {
            id: phone_item
            visible: false
            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            scale: 0.8
            anchors.verticalCenterOffset: 74
            anchors.horizontalCenter: parent.horizontalCenter
            onStateChanged: {
                if (phone_item.state === "incoming"){
                    viclass.setChannelValue(root.qml_properties__RTDB_variables["incoming_call_sound"], 1)
                }else{
                    viclass.setChannelValue(root.qml_properties__RTDB_variables["incoming_call_sound"], 0)
                }
            }
        }

        Simple_navigator{
            id: simple_navigator_item
            width: 1080
            height: 1150
            scale: 0.8
            visible: false
            enabled: false
            focus:true
            anchors.verticalCenter: parent.verticalCenter
            ws_ip: root.ws_ip
            ws_port: root.ws_port
            solver_status: root.solver_status
            longitude: root.longitude
            latitude: root.latitude
            anchors.verticalCenterOffset: 74
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Monofur{}
        Sansation_Regular{}
        OpenSans_Regular{}
        Dashboard_Utils{id: dashboard_Utils}
    }

    states: [
        State {
            name: "home"
        },
        State {
            name: "adas"

            PropertyChanges {
                target: functions_buttons_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: adas_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: climate_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: radio_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: phone_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: adas_button_item_mouse
            }

            PropertyChanges {
                target: lights_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: navi_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: controlsbutton_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: clock
                scale: 0
            }
            PropertyChanges {
                target: functions_buttons_item_grid
                leftPadding: 0
                topPadding: -10
                rows: 7
                columns: 1
                spacing: 0
                columnSpacing:0
                rowSpacing:-50
                buttons_dimension: 165
            }

        },
        State {
            name: "controls"

            PropertyChanges {
                target: functions_buttons_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: controls_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: navi_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: climate_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: radio_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: phone_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: adas_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: lights_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: controlsbutton_item_mouse
            }

            PropertyChanges {
                target: clock
                scale: 0
            }
            PropertyChanges {
                target: functions_buttons_item_grid
                leftPadding: 0
                topPadding: -10
                rows: 7
                columns: 1
                spacing: 0
                columnSpacing:0
                rowSpacing:-50
                buttons_dimension: 165
            }
        },

        State {
            name: "lights"

            PropertyChanges {
                target: functions_buttons_item
                visible: true
                enabled: true
            }
            PropertyChanges {
                target: lights_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: navi_button_item_mouse
                opacity: 0.5
            }


            PropertyChanges {
                target: climate_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: radio_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: phone_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: adas_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: lights_button_item_mouse
            }

            PropertyChanges {
                target: controlsbutton_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: clock
                scale: 0
            }
            PropertyChanges {
                target: functions_buttons_item_grid
                leftPadding: 0
                topPadding: -10
                rows: 7
                columns: 1
                spacing: 0
                columnSpacing:0
                rowSpacing:-50
                buttons_dimension: 165
            }

        },
        State {
            name: "climate"

            PropertyChanges {
                target: functions_buttons_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: climate_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: navi_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: climate_button_item_mouse
            }

            PropertyChanges {
                target: radio_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: phone_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: adas_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: lights_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: controlsbutton_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: clock
                scale: 0
            }
            PropertyChanges {
                target: functions_buttons_item_grid
                leftPadding: 0
                topPadding: -10
                rows: 7
                columns: 1
                spacing: 0
                columnSpacing:0
                rowSpacing:-50
                buttons_dimension: 165
            }
        },
        State {
            name: "radio"

            PropertyChanges {
                target: functions_buttons_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: radio_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: navi_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: climate_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: radio_button_item_mouse
            }

            PropertyChanges {
                target: phone_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: adas_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: lights_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: controlsbutton_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: clock
                scale: 0
            }
            PropertyChanges {
                target: functions_buttons_item_grid
                leftPadding: 0
                topPadding: -10
                rows: 7
                columns: 1
                spacing: 0
                columnSpacing:0
                rowSpacing:-50
                buttons_dimension: 165
            }
        },
        State {
            name: "phone"

            PropertyChanges {
                target: functions_buttons_item
                visible: true
                enabled: true
            }
            PropertyChanges {
                target: phone_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: navi_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: climate_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: radio_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: phone_button_item_mouse
            }

            PropertyChanges {
                target: adas_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: lights_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: controlsbutton_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: clock
                scale: 0
            }
            PropertyChanges {
                target: functions_buttons_item_grid
                leftPadding: 0
                topPadding: -10
                rows: 7
                columns: 1
                spacing: 0
                columnSpacing:0
                rowSpacing:-50
                buttons_dimension: 165
            }
        },
        State {
            name: "simple_navigator"

            PropertyChanges {
                target: functions_buttons_item
                visible: true
                enabled: true
            }
            PropertyChanges {
                target: simple_navigator_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: navi_button_item_mouse
            }

            PropertyChanges {
                target: climate_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: radio_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: phone_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: adas_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: lights_button_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: controlsbutton_item_mouse
                opacity: 0.5
            }

            PropertyChanges {
                target: clock
                scale: 0
            }
            PropertyChanges {
                target: functions_buttons_item_grid
                leftPadding: 0
                topPadding: -10
                rows: 7
                columns: 1
                spacing: 0
                columnSpacing:0
                rowSpacing:-50
                buttons_dimension: 165
            }
        }
    ]
    state: "home"
    transitions: [
        //when switching between states you have to:
        //1. pull up opacity to 1
        //2. for each big button:
        //  a. transition the scale
        //  b. opacity
        //  c. vertical and horizontal position
        Transition {
            reversible: true
            PropertyAnimation { targets: [  adas_item,
                    controls_item,
                    lights_item,
                    radio_item,
                    climate_item,
                    phone_item,
                    simple_navigator_item];
                properties: "opacity"; from: 0; to: 1; duration: 200; easing: Easing.InOutQuad }
            PropertyAnimation { targets: [
                    climate_button_item_mouse,
                    radio_button_item_mouse,
                    phone_button_item_mouse,
                    adas_button_item_mouse,
                    controlsbutton_item_mouse,
                    lights_button_item_mouse,
                    navi_button_item_mouse,
                    clock,
                    functions_buttons_item_grid];
                properties: "scale, opacity, leftPadding, topPadding, spacing, columnSpacing, rowSpacing"; duration: 1000; easing: Easing.InOutQuad }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
