import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

MouseArea{
    id: key_mouse_area

    //key borad with numbers and letters
    width: 150
    height: width
    property double number_key: 1
    property var number_key_letters: {
        1 : "",
        2 : "A B C",
        3 : "D E F",
        4 : "G H I",
        5 : "J K L",
        6 : "M N O",
        7 : "P Q R S",
        8 : "T U V",
        9 : "W X Y Z",
        0 : "+",
        10 : "*",
        11 : "#"
    }
    onPressed: {
        //when pressed switch to azure color
        key_rectangle.color = dashboard_Utils.vi_azure
    }
    onReleased: {
        key_rectangle.color = dashboard_Utils.vi_transparent
    }

    Rectangle {
        id: key_rectangle
        color: dashboard_Utils.vi_transparent
        radius: width/2
        border.color: dashboard_Utils.vi_white
        border.width: 3
        anchors.fill: parent

        Text {
            id: key_number
            width: 151
            height: 82
            color: dashboard_Utils.vi_white
            text: key_mouse_area.number_key
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 60
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: -34
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: key_letters
            width: 151
            height: 82
            color: dashboard_Utils.vi_white
            text: ""
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 14
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
            Component.onCompleted: {
                text = key_mouse_area.number_key_letters[key_mouse_area.number_key]
            }
        }
    }
    Dashboard_Utils{id: dashboard_Utils}
}
