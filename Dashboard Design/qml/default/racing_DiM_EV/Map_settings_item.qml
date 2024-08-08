import QtQuick 2.12

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {

    property double map_1_value: 0
    property double map_2_value: 0
    property double map_3_value: 0
    property double map_4_value: 0

    property string map_1_name_value: "MAP"
    property string map_2_name_value: "TH"
    property string map_3_name_value: "SW"
    property string map_4_name_value: "MODE"


    id: map_settings_item
    width: 300
    height: 300

    Rectangle {
        id: border_map
        color: dashboard_Utils.vi_transparent
        radius: 10
        border.color: dashboard_Utils.vi_grey
        border.width: 0
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
    }


    Text {
        id: fl_text
        color: dashboard_Utils.vi_white
        text: map_settings_item.map_1_name_value + " - " + map_settings_item.map_1_value.toFixed(0)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.verticalCenterOffset: -parent.height/4
        anchors.horizontalCenterOffset: -parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        layer.smooth: true
        width: parent.width/2
        height:  parent.height/2
    }

    Text {
        id: fr_text
        color: dashboard_Utils.vi_white
        text: map_settings_item.map_2_name_value + " - " + map_settings_item.map_2_value.toFixed(0)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.verticalCenterOffset: -parent.height/4
        anchors.horizontalCenterOffset: parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        layer.smooth: true
        width: parent.width/2
        height:  parent.height/2
    }

    Text {
        id: rl_text
        color: dashboard_Utils.vi_white
        text: map_settings_item.map_3_name_value + " - " + map_settings_item.map_3_value.toFixed(0)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.verticalCenterOffset: parent.height/4
        anchors.horizontalCenterOffset: -parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        layer.smooth: true
        width: parent.width/2
        height:  parent.height/2
    }

    Text {
        id: rr_text
        color: dashboard_Utils.vi_white
        text: map_settings_item.map_4_name_value + " - " + map_settings_item.map_4_value.toFixed(0)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.verticalCenterOffset: parent.height/4
        anchors.horizontalCenterOffset: parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        layer.smooth: true
        width: parent.width/2
        height:  parent.height/2
    }




    Dashboard_Utils{id: dashboard_Utils}




}

/*##^##
Designer {
    D{i:0;formeditorZoom:2;height:227.1428571428571;width:256}
}
##^##*/
