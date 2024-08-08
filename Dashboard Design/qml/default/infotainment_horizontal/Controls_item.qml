import QtQuick 2.12
import "../../../qml/default/default_db"

Item {
    id: controls_item
    width: 1080
    height: 1150

    //abs and tcs activities
    property bool abs_activity_value: false
    property bool tcs_activity_value: false
    property string abs_activity_rtdb: ""
    property string tcs_activity_rtdb: ""
    property bool esp_activity_value: false
    property string esp_activity_rtdb: ""
    property bool hill_hold_activity_value: false
    property string hill_hold_activity_rtdb: ""
    property bool launch_control_activity_value: false
    property string launch_control_activity_rtdb: ""

    //eps : 1, 2, 3
    property double eps_value: 0
    property string eps_rtdb: ""
    //automatic shifting mode : 0 comfort, 1 sport
    property bool shifting_mode_value: false
    property string shifting_mode_rtdb: ""


    //draggable item to switch root state

    Dragger_item{
        stateOnLeft: "adas"
        stateOnRight: "lights"
    }


    Rectangle {
        id: adas_background
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: dashboard_Utils.vi_transparent
            }
            GradientStop {
                position: 0.001
                color: dashboard_Utils.vi_black
            }
            GradientStop {
                position: 0.85
                color: dashboard_Utils.vi_black
            }
            GradientStop {
                position: 1
                color: dashboard_Utils.vi_transparent
            }
            orientation: Gradient.Horizontal
        }
    }
    Text {
        id: controls_text
        width: 1081
        height: 200
        color: dashboard_Utils.vi_white
        text: qsTr("CONTROLS")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        anchors.verticalCenterOffset: -400
    }





    //button that gets the dashboard to home state
    Grid {
        id: abs_tcs_esp_launch_hill_item
        width: 1080
        height: 200
        anchors.verticalCenter: parent.verticalCenter
        spacing: -20
        horizontalItemAlignment: Grid.AlignHCenter
        verticalItemAlignment: Grid.AlignVCenter
        rows: 2
        columns: 4
        anchors.verticalCenterOffset: -252
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Item{
            width: 480
            height: 56
            Text {
                id: vehicle_text
                x: 0
                y: 0
                color: dashboard_Utils.vi_white
                text: qsTr("Vehicle controls")
                font.pixelSize: 50
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: "Sansation"
                leftPadding: 40
            }
        }


        Button_item_mouse {
            id: abs_button
            width: 220
            height: 220
            button_textFontpixelSize: 90
            button_textText: "ABS"
            button_background_color_value: value ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_white
            value: controls_item.abs_activity_value
            value_rtdb: controls_item.abs_activity_rtdb
        }

        Button_item_mouse {
            id: tcs_button
            width: 220
            height: 220
            button_textFontpixelSize: 90
            button_textText: "TCS"
            button_background_color_value: value ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_white
            value_rtdb: controls_item.tcs_activity_rtdb
            onReleased: {
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Gearbox.internal_TCS_Activity", !tcs_button.value)
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Clutch.internal_TCS_Activity", !tcs_button.value)
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Central_Differential.internal_TCS_Activity", !tcs_button.value)
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Front_Differential.internal_TCS_Activity", !tcs_button.value)
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Rear_Differential.internal_TCS_Activity", !tcs_button.value)
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Front_Left_Wheel.internal_TCS_Activity", !tcs_button.value)
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Front_Right_Wheel.internal_TCS_Activity", !tcs_button.value)
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Rear_Left_Wheel.internal_TCS_Activity", !tcs_button.value)
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Rear_Right_Wheel.internal_TCS_Activity", !tcs_button.value)
            }

            value: controls_item.tcs_activity_value
        }

        Item {
            width: 220
            height: 220
        }

        Item {
            width: 405
            height: 56
        }

        Button_item_mouse {
            id: esp_button
            width: 220
            height: 220
            button_textText: "ESP"
            value_rtdb: controls_item.esp_activity_rtdb
            value: controls_item.esp_activity_value
            button_background_color_value: value ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_white
        }

        Button_item_mouse {
            id: hill_hold_button
            width: 220
            height: 220
            button_textFontpixelSize: 68
            button_textText: "HILL\nHOLD"
            value_rtdb: controls_item.hill_hold_activity_rtdb
            value: controls_item.hill_hold_activity_value
            button_background_color_value: value ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_white
        }


        Button_item_mouse {
            id: launch_control_button
            width: 220
            height: 220
            button_textFontpixelSize: 40
            button_textText: "LAUNCH\nCONTROL"
            value_rtdb: controls_item.launch_control_activity_rtdb
            value: controls_item.launch_control_activity_value
            button_background_color_value: value ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_white
            onReleased: {
                viclass.setChannelValue("VI_CarRealTime.Inputs.Generic_Engine_to_Clutch.internal_launch_control_activation", !launch_control_button.value)
            }
        }
    }

    Item {
        id: vehicle_controls
        width: 1080
        height: 516
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 136
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            id: steering_controls
            x: 0
            y: 0
            width: 1080
            height: parent.height/3
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: parent.height/3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0

            Text {
                id: eps_text
                color: dashboard_Utils.vi_white
                text: qsTr("Steering EPS map")
                anchors.fill: parent
                font.pixelSize: 50
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                leftPadding: 40
                font.family: "Sansation"
            }

            Button_item_mouse {
                id: eps_1_button
                x: 74
                y: -92
                width: 364
                height: 340
                button_textFontpixelSize: 120
                button_textText: "#1"
                button_background_color_value: (controls_item.eps_value <= 1 || controls_item.eps_value > 3) ? dashboard_Utils.vi_acid_green :
                                                                                                               dashboard_Utils.vi_white
                anchors.horizontalCenterOffset: 36
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                scale: 0.4
                //take into account also 0 that is the default map
                value: (controls_item.eps_value <= 1 || controls_item.eps_value > 3)
                onReleased: {
                    viclass.setChannelValue(controls_item.eps_rtdb, 1)
                }
            }

            Button_item_mouse {
                id: eps_2_button
                x: 81
                y: -89
                width: 364
                height: 340
                button_textFontpixelSize: 120
                button_background_color_value: (controls_item.eps_value === 2) ? dashboard_Utils.vi_acid_green :
                                                                                 dashboard_Utils.vi_white
                anchors.horizontalCenterOffset: 216
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                button_textText: "#2"
                scale: 0.4
                value: controls_item.eps_value === 2
                onReleased: {
                    viclass.setChannelValue(controls_item.eps_rtdb, 2)
                }
            }

            Button_item_mouse {
                id: eps_3_button
                x: 76
                y: -89
                width: 364
                height: 340
                button_textFontpixelSize: 120
                button_background_color_value: (controls_item.eps_value === 3) ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_white
                anchors.horizontalCenterOffset: 396
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                button_textText: "#3"
                scale: 0.4
                value: controls_item.eps_value === 3
                onReleased: {
                    viclass.setChannelValue(controls_item.eps_rtdb, 3)
                }
            }
        }

        Item {
            id: shifting_controls
            x: -3
            y: 9
            width: 1080
            height: parent.height/3
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0

            Text {
                id: shifting_text
                color: dashboard_Utils.vi_white
                text: qsTr("Shifting mode")
                anchors.fill: parent
                font.pixelSize: 50
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: "Sansation"
                leftPadding: 40
            }

            Button_item_mouse {
                id: shift_comfort_button
                x: 74
                y: -92
                width: 364
                height: 340
                button_textFontpixelSize: 80
                button_background_color_value: !controls_item.shifting_mode_value ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_white
                anchors.horizontalCenterOffset: 36
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                button_textText: "comfort"
                scale: 0.4
                value: controls_item.shifting_mode_value
                value_rtdb: controls_item.shifting_mode_rtdb
            }

            Button_item_mouse {
                id: shift_sport_button
                x: 82
                y: -98
                width: 364
                height: 340
                button_textFontpixelSize: 80
                button_background_color_value: controls_item.shifting_mode_value ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_white
                anchors.horizontalCenterOffset: 216
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                button_textText: "sport"
                scale: 0.4
                value: controls_item.shifting_mode_value
                value_rtdb: controls_item.shifting_mode_rtdb
            }
        }
    }

    Button_item_mouse {
        id: exit_to_home
        width: 150
        height: 150
        button_icon_value: "images/home_icon.png"
        button_background_color_value: dashboard_Utils.vi_red
        anchors.verticalCenterOffset: 500
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        button_icon_scale_value: 2
        onReleased: {
            root.state = "home"
        }
    }


    Dashboard_Utils{id: dashboard_Utils}





}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5;height:1032;width:1080}D{i:14}D{i:15}
}
##^##*/
