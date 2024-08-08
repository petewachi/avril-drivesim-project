import QtQuick 2.12

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {

    property double tire_FL_value: 0
    property double tire_FR_value: 0
    property double tire_RL_value: 0
    property double tire_RR_value: 0


    property double tire_green_value: 40
    property double tire_yellow_value: 60
    property double tire_red_value: 80

    property int precision_value: 1

    property string unit_of_measure_value: "bar"
    property string central_text_value: "TIRE PRESS"


    id: tire_item
    width: parent.width/4
    height: parent.height/7*3
    anchors.verticalCenterOffset: -parent.height/7

    Rectangle {
        id: border_tire
        color: dashboard_Utils.vi_transparent
        radius: 10
        border.color: dashboard_Utils.vi_grey
        border.width: 6
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
    }

    Text {
        id: central_text
        width: parent.width
        height: parent.height/2
        color: dashboard_Utils.vi_yellow
        text: tire_item.central_text_value + " [" + tire_item.unit_of_measure_value + "]"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.horizontalCenter: parent.horizontalCenter
        layer.smooth: true
        font.family: "Sansation"
    }

    Text {
        id: fl_text
        color: tire_item.tire_FL_value > tire_item.tire_red_value ? dashboard_Utils.vi_red :
               tire_item.tire_FL_value > tire_item.tire_yellow_value ? dashboard_Utils.vi_yellow :
               tire_item.tire_FL_value > tire_item.tire_green_value ? dashboard_Utils.vi_green :
                                                                      dashboard_Utils.vi_azure
        text: tire_item.tire_FL_value.toFixed(tire_item.precision_value)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        anchors.verticalCenterOffset: -parent.height/4
        anchors.horizontalCenterOffset: -parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Open Sans"
        layer.smooth: true
        width: parent.width/2
        height:  parent.height/2
    }


    Text {
        id: fr_text
        color: tire_item.tire_FR_value > tire_item.tire_red_value ? dashboard_Utils.vi_red :
               tire_item.tire_FR_value > tire_item.tire_yellow_value ? dashboard_Utils.vi_yellow :
               tire_item.tire_FR_value > tire_item.tire_green_value ? dashboard_Utils.vi_green :
                                                                      dashboard_Utils.vi_azure
        text: tire_item.tire_FR_value.toFixed(tire_item.precision_value)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: -parent.height/4
        anchors.horizontalCenterOffset: parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Open Sans"
        layer.smooth: true
        width: parent.width/2
        height:  parent.height/2
    }


    Text {
        id: rl_text
        color: tire_item.tire_RL_value > tire_item.tire_red_value ? dashboard_Utils.vi_red :
               tire_item.tire_RL_value > tire_item.tire_yellow_value ? dashboard_Utils.vi_yellow :
               tire_item.tire_RL_value > tire_item.tire_green_value ? dashboard_Utils.vi_green :
                                                                      dashboard_Utils.vi_azure
        text: tire_item.tire_RL_value.toFixed(tire_item.precision_value)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: parent.height/4
        anchors.horizontalCenterOffset: -parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Open Sans"
        layer.smooth: true
        width: parent.width/2
        height:  parent.height/2
    }


    Text {
        id: rr_text
        color: tire_item.tire_RR_value > tire_item.tire_red_value ? dashboard_Utils.vi_red :
                                                                    tire_item.tire_RR_value > tire_item.tire_yellow_value ? dashboard_Utils.vi_yellow :
                                                                                                                            tire_item.tire_RR_value > tire_item.tire_green_value ? dashboard_Utils.vi_green :
                                                                                                                                                                                   dashboard_Utils.vi_azure
        text: tire_item.tire_RR_value.toFixed(tire_item.precision_value)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: parent.height/4
        anchors.horizontalCenterOffset: parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Open Sans"
        layer.smooth: true
        width: parent.width/2
        height:  parent.height/2
    }


    Dashboard_Utils{id: dashboard_Utils}




}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66;height:227.1428571428571;width:256}D{i:2}
}
##^##*/
