import QtQuick 2.12
import QtQuick.Extras 1.4

import QtQuick.Studio.Components 1.0
import QtGraphicalEffects 1.0
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"




Item {
    id: rpm_item
    width: 600
    height: 600
    layer.samples: 16
    layer.enabled: true
    layer.smooth: true
    layer.mipmap: isXREnabled ? false : true
    state: "comfort"

    property double rpm_value: 0    //rpm engine
    property double rpm_red_value: 4500            //rpm level at which becomes red
    property double rpm_max_value: 6000            //max rpm


    property double gear_value: 0       //gear selected
    property int gear_min_value: -1       //min gear selected
    property int gear_max_value: 7       //max gear selected

    property bool automatic_shifting: false       //automatic mode
    property bool shifting_mode: false       //automatic shifting mode

    onGear_valueChanged: {
        //update max gear selectable
        if (rpm_item.gear_value > rpm_item.gear_max_value){
            rpm_item.gear_max_value = rpm_item.gear_value
        }
    }
    
    ArcItem {
        id: rpm_arc
        width: 500
        height: 500
        opacity: 0.8
        visible: false
        begin: 225
        strokeWidth: 20
        strokeColor: rpm_item.rpm_value > rpm_item.rpm_red_value ? dashboard_Utils.vi_red : dashboard_Utils.vi_azure
        fillColor: dashboard_Utils.vi_transparent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        antialiasing: true
        end: rpm_arc.begin + dashboard_Utils.saturation(Math.abs(rpm_item.rpm_value)/rpm_item.rpm_max_value*224, 0, 224)
        
        rotation: 90
    }
    Glow {
        id: rpm_arc_glow
        opacity: 0.8
        color: rpm_arc.strokeColor
        anchors.fill: rpm_arc
        radius: 20
        samples: 35
        spread: 0.3
        source: rpm_arc
        fast: true
        rotation: rpm_arc.rotation
        antialiasing: true
        layer.mipmap: true
    }

    Image {
        id: rpm_circle_back
        width: 632
        height: 632
        rotation: -45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "images/background.png"
        antialiasing: true
        mipmap: true
    }

    Item {
        id: rotation_rpm
        width: 200
        height: 200
        rotation: 45 + dashboard_Utils.saturation(Math.abs(rpm_item.rpm_value)/rpm_item.rpm_max_value*224, 0, 224)
        Image {
            id: needle
            width: 600
            source: "images/needle_white.svg"
            sourceSize.width: 600
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }


    Image {
        id: central_round
        width: 400
        height: 400
        source: "images/dial.png"
        mipmap: true
        antialiasing: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: gear_item
        width: 226
        height: 79
        visible: !rpm_item.automatic_shifting
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 56
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: gear_text_minus
            x: -86
            y: 460
            width: 89
            height: 53
            visible: rpm_item.gear_value > rpm_item.gear_min_value
            color: dashboard_Utils.vi_light_grey
            text: dashboard_Utils.gear_to_string(rpm_item.gear_value-1)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 13
            anchors.horizontalCenterOffset: -70
            anchors.horizontalCenter: parent.horizontalCenter
            fontSizeMode: Text.FixedSize
            font.family: "Open Sans"
        }

        Text {
            id: gear_text_current
            x: -93
            y: 454
            width: 89
            height: 53
            color: dashboard_Utils.vi_white
            text: dashboard_Utils.gear_to_string(rpm_item.gear_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fontSizeMode: Text.FixedSize
            font.family: "Open Sans"
        }

        Text {
            id: gear_text_plus
            x: -86
            y: 450
            width: 89
            height: 53
            visible: rpm_item.gear_value < rpm_item.gear_max_value
            color: dashboard_Utils.vi_light_grey
            text: dashboard_Utils.gear_to_string(rpm_item.gear_value+1)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: 13
            anchors.horizontalCenterOffset: 70
            anchors.horizontalCenter: parent.horizontalCenter
            fontSizeMode: Text.FixedSize
            font.family: "Open Sans"
        }
    }

    Item {
        id: gear_item_automatic
        width: 226
        height: 79
        visible: rpm_item.automatic_shifting
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 56
        Text {
            id: gear_text_automatic_minus
            x: -86
            y: 460
            width: 89
            height: 53
            visible: rpm_item.gear_value > rpm_item.gear_min_value
            color: dashboard_Utils.vi_light_grey
            text: rpm_item.gear_value > 0 ? "N" :dashboard_Utils.gear_to_string(rpm_item.gear_value-1)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fontSizeMode: Text.FixedSize
            anchors.verticalCenterOffset: 13
            anchors.horizontalCenterOffset: -70
            font.family: "Open Sans"
        }

        Text {
            id: gear_text_automatic_current
            x: -93
            y: 454
            width: 89
            height: 53
            color: dashboard_Utils.vi_white
            text: rpm_item.gear_value > 0 ? "D"+dashboard_Utils.gear_to_string(rpm_item.gear_value) : dashboard_Utils.gear_to_string(rpm_item.gear_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fontSizeMode: Text.FixedSize
            font.family: "Open Sans"
        }

        Text {
            id: gear_text_automatic_plus
            x: -86
            y: 450
            width: 89
            height: 53
            visible: rpm_item.gear_value < 1
            color: dashboard_Utils.vi_light_grey
            text: rpm_item.gear_value == 0 ? "D" :dashboard_Utils.gear_to_string(rpm_item.gear_value+1)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fontSizeMode: Text.FixedSize
            anchors.verticalCenterOffset: 13
            anchors.horizontalCenterOffset: 70
            font.family: "Open Sans"
        }
    }

    Text {
        id: rpm_x1000
        x: -725
        y: 186
        color: dashboard_Utils.vi_white
        text: "rpm"
        fontSizeMode: Text.FixedSize
        maximumLineCount: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -110
        anchors.horizontalCenterOffset: 1
        font.family: "Sansation"
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 30
    }


    Text {
        id: rpm_text
        x: -749
        y: 230
        width: 224
        height: 68
        color: dashboard_Utils.vi_white
        text: rpm_item.rpm_value.toFixed(0)
        wrapMode: Text.WrapAnywhere
        fontSizeMode: Text.FixedSize
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -42
        font.family: "Open Sans"
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 67
        horizontalAlignment: Text.AlignHCenter
    }
    Dashboard_Utils{id: dashboard_Utils}

    states: [
        State {
            name: "comfort"
            when: !rpm_item.shifting_mode
        },
        State {
            name: "sport"
            when: rpm_item.shifting_mode

            PropertyChanges {
                target: needle
                source: "images/needle_red.svg"
            }

            PropertyChanges {
                target: rpm_circle_back
                source: "images/background_red.png"
            }
        }
    ]
    transitions: [
        Transition {
            reversible: true
            PropertyAnimation { targets: [rpm_item]; from:0.3;to:1;properties: "scale"; duration: 1500; easing.type: Easing.OutCubic}
        }
    ]

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}
}
##^##*/
