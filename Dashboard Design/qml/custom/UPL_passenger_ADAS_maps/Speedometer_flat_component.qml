import QtQuick 2.12

import QtQuick.Studio.Components 1.0
import QtGraphicalEffects 1.0
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"




Item {
    id: speed_item

    property double speed_value: 0          //vehicle speed km/h
    property double max_speed_value: 280    //max vehicle speed
    property bool mph_value: false          //if switching to mile per hour

    property int shifting_mode: 0    //0: comfort mode, 1: sport mode

    property double fuel_consumption: 0    //fuel consumption in l/100km

    property double acc_target_speed: 0    //acc target speed
    property bool acc_ready: false    //acc ready
    property bool acc_on: false    //acc on

    property alias acc_visibility: acc_item.visible
    property alias fuel_consumption_visibility: fuel_consumption_widget.visible
    property double solver_status: 0


    layer.samples: 16
    layer.enabled: true
    width: 600
    height: 300
    layer.smooth: true
    layer.mipmap: isXREnabled ? false : true
    state: "comfort"

    Glow {
        id: kph_arc_glow
        color: kph_arc.strokeColor
        anchors.fill: kph_arc
        radius: 20
        samples: 35
        spread: 0.3
        source: kph_arc
        layer.mipmap: true
        fast: true
        rotation: kph_arc.rotation
        antialiasing: true
    }

   
    Image {
        id: background_image
        width: parent.width-20
        height: parent.height-20
        opacity: 0.8
        source: "images/upper_section.png"
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        mipmap: true
        antialiasing: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }


    Text {
        id: kph_text
        color: dashboard_Utils.vi_white
        text: speed_item.mph_value ? "mph" : "km/h"
        fontSizeMode: Text.FixedSize
        maximumLineCount: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -95
        font.family: "Sansation"
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 34
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: kph_number
        width: 250
        height: 121
        color: dashboard_Utils.vi_white
        text: Math.abs(dashboard_Utils.update_speed(speed_item.speed_value, speed_item.mph_value)).toFixed(0)
        wrapMode: Text.WrapAnywhere
        anchors.horizontalCenterOffset: 0
        font.pixelSize: 100
        anchors.verticalCenterOffset: 0
        fontSizeMode: Text.FixedSize
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        maximumLineCount: 1
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Open Sans"
        horizontalAlignment: Text.AlignHCenter
    }


    Item {
        id: acc_item
        width: 255
        height: 61
        anchors.verticalCenter: background_image.bottom
        anchors.verticalCenterOffset: -parent.height/8
        anchors.horizontalCenterOffset: -111
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: acc_set_icon
            width: 39
            height: 39
            anchors.horizontalCenterOffset: -64
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: speed_item.acc_on ? "images/speed-ACC_on.png":
                    speed_item.acc_ready ? "images/speed-ACC.png":
                                           "images/speed-ACC_ko.png"
            anchors.verticalCenterOffset: -6
            mipmap: true
            antialiasing: true
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: acc_set_speed
            width: 120
            height: 48
            color: dashboard_Utils.vi_white
            text: speed_item.acc_target_speed === 0 ? "---" :
                  dashboard_Utils.saturation(dashboard_Utils.update_speed(speed_item.acc_target_speed,speed_item.mph_value),0,speed_item.max_speed_value).toFixed(0)
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenterOffset: 26
            lineHeight: 1
            anchors.verticalCenterOffset: -4
            anchors.horizontalCenter: parent.horizontalCenter
            maximumLineCount: 1
            font.pixelSize: 35
            font.family: "Sansation"
            horizontalAlignment: Text.AlignHCenter
        }
    }


    Fuel_consumption_widget {
        id: fuel_consumption_widget
        width: 200
        height: 73
        anchors.verticalCenter: background_image.bottom
        anchors.verticalCenterOffset: -parent.height/8
        anchors.horizontalCenterOffset: 129
        anchors.horizontalCenter: parent.horizontalCenter
        fuel_consumption_value: speed_item.fuel_consumption
        solver_status: speed_item.solver_status
    }

    Dashboard_Utils{id: dashboard_Utils}
    states: [
        State {
            name: "comfort"
            when: !speed_item.shifting_mode
        },
        State {
            name: "sport"
            when: speed_item.shifting_mode

        }
    ]
    transitions: [
        Transition {
            reversible: true
            PropertyAnimation { targets: [speed_item]; from:0.3;to:1;properties: "scale"; duration: 1500; easing.type: Easing.OutCubic}
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:662;width:600}D{i:12;transitionDuration:2000}
}
##^##*/
