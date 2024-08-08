import QtQuick 2.12
import QtQuick.Window 2.2
import "../../../qml/default/default_db"


Item {
    id: launch_control_component
    property bool launch_control_value: false
    property bool launch_control_input_value: false
    property double throttle_value: 0
    property double brake_value: 0
    property double launch_control_timeout: 5
    visible: (launch_control_component.launch_control_input_value || launch_control_component.launch_control_value)
    onLaunch_control_input_valueChanged: {
        if (launch_control_component.launch_control_input_value &&
                !launch_control_component.launch_control_value){
            launch_control_text_1.text = "Launch Control"
            launch_control_text_2.text = "press BRAKE over 95%"
            timer_launch.restart()
        }
    }
    onBrake_valueChanged: {
        if (launch_control_component.launch_control_input_value &&
                launch_control_component.brake_value > 95 &&
                !launch_control_component.launch_control_value){
            launch_control_text_1.text = "Launch Control"
            launch_control_text_2.text = "hold the brake and press THROTTLE over 95%"
            timer_launch.restart()
        }
        if (launch_control_component.brake_value === 0 &&
                launch_control_component.throttle_value > 95 &&
                launch_control_component.launch_control_value){
            launch_control_text_1.text = "Launch Control STARTED"
            launch_control_text_2.text = ""
            timer_launch.restart()
        }
    }
    onLaunch_control_valueChanged: {
        if (launch_control_component.launch_control_input_value &&
                launch_control_component.brake_value > 95 &&
                launch_control_component.throttle_value > 95 &&
                launch_control_component.launch_control_value){
            launch_control_text_1.text = "Launch Control ENABLED"
            launch_control_text_2.text = "release brake to START"
            timer_launch.restart()
        }else if (launch_control_component.launch_control_value &&
                  launch_control_component.throttle_value < 95){
            launch_control_text_1.text = "Launch Control ENABLED"
            launch_control_text_2.text = "hold the brake and press THROTTLE over 95%"
            timer_launch.restart()
        }else if (launch_control_component.launch_control_value){
            launch_control_text_1.text = "Launch Control ENABLED"
            launch_control_text_2.text = ""
            timer_launch.restart()
        }
    }
    Timer{
        id: timer_launch
        running: false
        repeat: false
        triggeredOnStart: true
        interval: launch_control_component.launch_control_timeout*1000
        onTriggered: {
            if(timer_launch.running){
                launch_control_component.visible = true
            }else{
                launch_control_component.visible = false
            }
        }
    }

    Rectangle {
        id: launch_control_background
        width: 1110
        height: 220
        color: dashboard_Utils.vi_orange
        radius: 20
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Column {
            id: column
            anchors.fill: parent
            Item{
                id: item2
                width: 1110
                height: parent.height/2

                Text {
                    id: launch_control_text_1
                    width: 1110
                    text: qsTr("Launch Control ENABLED")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 80
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    font.family: "Sansation"
                }
            }
            Item{
                id: item1
                width: 1110
                height: parent.height/2
                Text {
                    id: launch_control_text_2
                    width: 1110
                    text:  qsTr("release brake to START")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 50
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    font.family: "Sansation"
                }
            }
        }
    }
    Dashboard_Utils{id:dashboard_Utils}
}
