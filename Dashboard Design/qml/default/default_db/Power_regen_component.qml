import QtQuick 2.12
import QtQuick.Studio.Components 1.0

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"





Item {
    //power and regenerative torque or current
    property double power_value: 500

    //max power and regenerative torque or current to use as reference
    property double power_max_value: 550
    property double regen_max_value: 100

    id: power_regen
    width: 200
    height: 200
    layer.smooth: true
    layer.mipmap: true
    layer.samples: 16
    //layer.enabled: true
    scale: dashboard_Utils.resize_content(width, height, 200,200)



    Rectangle {
        id: outer_circle
        width: 200
        height: 200
        color: dashboard_Utils.vi_black
        radius: 0
        border.color: dashboard_Utils.vi_grey
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: inner_circle
        width: 200*0.8
        height: width
        visible: false
        color: dashboard_Utils.vi_transparent
        radius: width
        border.color: dashboard_Utils.vi_grey
        border.width: width/125/0.8
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    



    Rectangle {
        id: middle_limit
        y: 178
        width: 200-2
        height: 2
        visible: false
        color: dashboard_Utils.vi_transparent
        radius: 0
        border.color: dashboard_Utils.vi_grey
        border.width: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
    }

    Text {
        id: power_text
        x: 20
        y: 60
        width: 200*0.8
        height: parent.height/2
        color: power_regen.power_value >= 0 ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_azure
        text: power_regen.power_value.toFixed(0) + " kW"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 22
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        rightPadding: 30
        font.bold: true
        font.family: "Sansation"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: power_text_item
        width: 200*0.8
        height: 80
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 92
        anchors.horizontalCenterOffset: 67
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: power_text_
            width: 200*0.8
            height: parent.height/2
            color: dashboard_Utils.vi_white
            text: "power"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.bold: true
            anchors.verticalCenterOffset: -parent.height/4
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: regen_text_item
        width: 200*0.8
        height: 200/2*0.8
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 92
        anchors.horizontalCenterOffset: -67
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: regen_text
            width: 200*0.8
            height: parent.height/2
            visible: false
            color: dashboard_Utils.vi_azure
            text: dashboard_Utils.saturation(power_regen.power_value,-1000000 , 0).toFixed(0) + " kW"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 22
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            rightPadding: 30
            font.bold: true
            anchors.verticalCenterOffset: -parent.height/4
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: regen_text_
            width: 200*0.8
            height: parent.height/2
            color: dashboard_Utils.vi_white
            text: "regen"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.bold: true
            anchors.verticalCenterOffset: -parent.height/4
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }



    Dashboard_Utils{id: dashboard_Utils}


    ArcItem {
        id: regen_arc
        width: 170
        height: 210
        anchors.verticalCenter: parent.verticalCenter
        end: power_regen.power_value<0 ? -36 + 2*36*Math.abs(dashboard_Utils.saturation(power_regen.power_value,-power_regen.regen_max_value,power_regen.power_max_value))/power_regen.regen_max_value:-36
        anchors.horizontalCenter: parent.horizontalCenter
        begin: -36
        strokeWidth: 14
        strokeColor: dashboard_Utils.vi_azure
        fillColor: dashboard_Utils.vi_transparent
        antialiasing: true
        transform: Scale{origin.x: regen_arc.width/2; origin.y: regen_arc.height/2; xScale: 1}


    }

    Image {
        id: background_regen
        width: 300
        height: 300
        anchors.verticalCenter: parent.verticalCenter
        source: "images/background_battery_level.png"
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 40
        rotation: 90
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    ArcItem {
        id: power_arc
        width: 170
        height: 210
        anchors.verticalCenter: parent.verticalCenter
        end: power_regen.power_value >=0 ? -36 + 2*36*Math.abs(dashboard_Utils.saturation(power_regen.power_value,-power_regen.regen_max_value,power_regen.power_max_value))/power_regen.power_max_value : -36
        anchors.horizontalCenter: parent.horizontalCenter
        begin: -36
        strokeWidth: 14
        strokeColor: dashboard_Utils.vi_acid_green
        fillColor: dashboard_Utils.vi_transparent
        antialiasing: true
        transform: Scale{origin.x: power_arc.width/2; origin.y: power_arc.height/2; xScale: -1}

    }

    Image {
        id: background_power
        width: 300
        height: 300
        anchors.verticalCenter: parent.verticalCenter
        source: "images/background_battery_level.png"
        rotation: -90
        anchors.verticalCenterOffset: 0
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:2;height:200;width:200}D{i:13}D{i:16}
}
##^##*/
