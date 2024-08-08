import QtQuick 2.12

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {

    property double gear_value: 0

    id: gear_item
    width: parent.width/4
    height: parent.height/7*3
    anchors.verticalCenterOffset: -parent.height/7
    Rectangle {
        id: border_gear
        color: dashboard_Utils.vi_transparent
        radius: 10
        border.color: dashboard_Utils.vi_transparent
        border.width: 6
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
    }

    Text {
        id: gear_text
        color: dashboard_Utils.vi_yellow
        text: dashboard_Utils.gear_to_string(gear_item.gear_value)
        anchors.fill: parent
        font.pixelSize: 200
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Open Sans"
        layer.smooth: true
        leftPadding: 10
        bottomPadding: 10
    }

    Dashboard_Utils{id: dashboard_Utils}



}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66;height:227.1428571428571;width:256}
}
##^##*/
