import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

MouseArea {
    id: button_v2

    property bool checked_prop
    property bool always_white: false
    property bool green_button: false
    width: 75
    height: 48


    Rectangle {
        id: checkbox_item
        width: parent.width * 0.6
        height: parent.height/2
        color: dashboard_Utils.vi_black
        radius: 13
        border.color: dashboard_Utils.vi_white
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.width: 3
        anchors.verticalCenterOffset: 0


        Rectangle {
            id: checkbox_item1
            x: -7
            width: height
            height: parent.height + 10
            color: dashboard_Utils.vi_white
            radius: 16
            border.color: dashboard_Utils.vi_white
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            border.width: 6
        }

        NumberAnimation {
            id: switch_on
            target: checkbox_item1
            property: "x"
            duration: 300
            easing.type: Easing.InQuad
            alwaysRunToEnd: true
            running: checked_prop
            onStarted: {
                if(green_button){
                    button_v2.opacity = 1
                    checkbox_item1.color = dashboard_Utils.vi_green
                    checkbox_item1.border.color = dashboard_Utils.vi_green
                }else{
                    button_v2.opacity = 1
                }
            }
            from: -7
            to: 19
        }
        ColorAnimation{
            id: switch_on_color
            target: checkbox_item
            property: "color"
            duration: 300
            easing.type: Easing.InQuad
            alwaysRunToEnd: true
            running: checked_prop
            to: dashboard_Utils.vi_azure
        }


        NumberAnimation {
            id: switch_off
            target: checkbox_item1
            property: "x"
            duration: 300
            easing.type: Easing.InQuad
            alwaysRunToEnd: true
            running: !checked_prop
            onStarted: {

                if(green_button){
                    button_v2.opacity = 1
                    checkbox_item1.color = dashboard_Utils.vi_white
                    checkbox_item1.border.color = dashboard_Utils.vi_white
                }else{
                    if (!always_white){
                        checkbox_item1.color = dashboard_Utils.vi_white
                        checkbox_item1.border.color = dashboard_Utils.vi_white
                    }else{
                        checkbox_item1.color = dashboard_Utils.vi_white
                        checkbox_item1.border.color = dashboard_Utils.vi_white
                    }
                }

            }
            from: 19
            to: -7
        }

        ColorAnimation{
            id: switch_off_color
            target: checkbox_item
            property: "color"
            duration: 300
            easing.type: Easing.InQuad
            alwaysRunToEnd: true
            running: !checked_prop
            to: dashboard_Utils.vi_black
        }
    }
    acceptedButtons: Qt.AllButtons
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter


    Dashboard_Utils{id: dashboard_Utils}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:8}
}
##^##*/
