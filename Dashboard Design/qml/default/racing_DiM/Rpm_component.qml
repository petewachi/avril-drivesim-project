import QtQuick 2.12


import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

Item {

    property double rpm: 0
    property bool rpm_unit_visibility: false
    id: rpm_item
    x: 0
    y: 0
    width: parent.width/4
    height: parent.height/7
    Rectangle {
        id: border_rpm
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
        id: text_rpm
        width: 132
        height: 68
        color: dashboard_Utils.vi_white
        text: rpm_item.rpm.toFixed(0)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 50
        horizontalAlignment: Text.AlignRight
        layer.smooth: true
        anchors.horizontalCenterOffset: -24
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Open Sans"
    }

    Text {
        id: text_rpm_unit
        visible: rpm_item.rpm_unit_visibility
        width: 84
        height: 38
        color: dashboard_Utils.vi_yellow
        text: "rpm"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: 12
        anchors.horizontalCenterOffset: 90
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        layer.smooth: true
    }

    Dashboard_Utils {
        id: dashboard_Utils
    }
}

/*##^##
Designer {
    D{i:0;height:75.71428571428571;width:256}
}
##^##*/
