import QtQuick 2.12

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"




Item {
    id: messages_item
    property string message_value: ""
    property string message_action_value: ""
    property color rectangle_border: dashboard_Utils.vi_transparent
    width: 768
    height: 200
    opacity: 0
    onMessage_valueChanged: {
        message_animation.restart()
    }
    onMessage_action_valueChanged: {
        message_animation.restart()
    }

    PropertyAnimation{
        id: message_animation
        target: messages_item
        property: "opacity"
        to:1
        duration: 2000
        alwaysRunToEnd: true
        easing.type: Easing.OutQuint
        //when finished go toout animation
        onFinished: message_animation_off.restart()
    }
    PropertyAnimation{
        id: message_animation_off
        target: messages_item
        property: "opacity"
        to:0
        duration: 2000
        alwaysRunToEnd: true
        easing.type: Easing.OutQuint
    }

    Rectangle {
        id: messages_rectangle
        color: dashboard_Utils.vi_dark_grey
        radius: width/20
        border.color: messages_item.rectangle_border
        border.width: 10
        anchors.fill: parent

        Text {
            id: messgaes_text
            width: 769
            height: parent.height/2
            color: dashboard_Utils.vi_white
            text: messages_item.message_value
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 45
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            anchors.verticalCenterOffset: messages_item.message_action_value == "" ? 0 : -parent.height/4
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: messgaes_control_text
            width: 769
            height: parent.height/2
            color: dashboard_Utils.vi_red
            anchors.verticalCenterOffset: messages_item.message_value == "" ? 0 : parent.height/4
            text: messages_item.message_action_value
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 60
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Dashboard_Utils{id: dashboard_Utils}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.1;height:200;width:768}
}
##^##*/
