import QtQuick 2.12


import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {

    property int lap_num_value: 0
    property int lap_map_value: 1

    id: lap_item
    width: parent.width*3/4/2
    height: parent.height/7
    Text {
        id: lap_text
        width: 83
        height: 68
        color: dashboard_Utils.vi_yellow
        text: "LAP"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 30
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignBottom
        bottomPadding: 12
        leftPadding: 10
        layer.smooth: true
        anchors.horizontalCenterOffset: -135
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
    }

    Text {
        id: lap_value_text
        width: 83
        height: 68
        color: dashboard_Utils.vi_white
        text: lap_item.lap_num_value.toFixed(0)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 30
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignBottom
        font.family: "Open Sans"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 10
        bottomPadding: 10
        anchors.horizontalCenterOffset: -70
    }
    Rectangle {
        id: border_map_lap
        color: dashboard_Utils.vi_transparent
        radius: 10
        border.color: dashboard_Utils.vi_petrol
        border.width: 6
        anchors.fill: parent
        anchors.leftMargin: 220
        anchors.rightMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1

        Text {
            id: map_lap_text
            color: dashboard_Utils.vi_white
            text: "A/C  " + lap_item.lap_map_value
            anchors.fill: parent
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
            layer.smooth: true
        }
    }

    Dashboard_Utils {
        id: dashboard_Utils
    }
}
