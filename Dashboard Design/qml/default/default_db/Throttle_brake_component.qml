import QtQuick 2.12
import QtQuick.Studio.Components 1.0

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"





Item {
    property double throttle_value: 100
    property double brake_value: 0
    id: throttle_brake
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
        radius: 200
        border.color: dashboard_Utils.vi_grey
        border.width: 200/125
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: inner_circle
        width: 200*0.8
        height: width
        color: dashboard_Utils.vi_transparent
        radius: width
        border.color: dashboard_Utils.vi_grey
        border.width: width/125/0.8
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ArcItem {
        id: throttle_arc
        width: 200-outer_circle.border.width*5
        height: 200-outer_circle.border.width*5
        anchors.verticalCenter: parent.verticalCenter
        begin: 180 - 180*dashboard_Utils.saturation(throttle_brake.throttle_value,0,100)/100
        strokeWidth: 14
        anchors.horizontalCenter: parent.horizontalCenter
        end: 180
        strokeColor: dashboard_Utils.vi_green
        fillColor: dashboard_Utils.vi_transparent
        antialiasing: true
        transform: Scale{origin.x: throttle_arc.width/2; origin.y: throttle_arc.height/2; xScale: -1}
    }

    ArcItem {
        id: brake_arc
        width: 200-outer_circle.border.width*5
        height: 200-outer_circle.border.width*5
        anchors.verticalCenter: parent.verticalCenter
        begin: -180
        strokeWidth: 14
        anchors.horizontalCenter: parent.horizontalCenter
        end: -180 + 180*dashboard_Utils.saturation(throttle_brake.brake_value,0,100)/100
        strokeColor: dashboard_Utils.vi_red
        fillColor: dashboard_Utils.vi_transparent
        antialiasing: true
        transform: Scale{origin.x: brake_arc.width/2; origin.y: brake_arc.height/2; xScale: -1}
    }



    Rectangle {
        id: middle_limit
        y: 178
        width: 200-2
        height: 2
        color: dashboard_Utils.vi_transparent
        radius: 0
        border.color: dashboard_Utils.vi_grey
        border.width: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
    }

    Item {
        id: throttle_text_item
        width: 200*0.8
        height: 200/2*0.8
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -200/4*0.8
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: throttle_text
            width: 200*0.8
            height: 200/2*0.8
            color: dashboard_Utils.vi_green
            text: throttle_brake.throttle_value.toFixed(0) + "%       THROTTLE "
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.bold: true
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: brake_text_item
        width: 200*0.8
        height: 200/2*0.8
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: brake_text
            width: 200*0.8
            height: 200/2*0.8
            color: dashboard_Utils.vi_red
            text: "BRAKE                   " + throttle_brake.brake_value.toFixed(0) +"%"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.bold: true
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 200/4*0.8
    }



    Dashboard_Utils{id: dashboard_Utils}

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75;height:200;width:200}
}
##^##*/
