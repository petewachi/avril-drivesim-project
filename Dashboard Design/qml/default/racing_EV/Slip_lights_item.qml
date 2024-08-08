import QtQuick 2.12
import QtGraphicalEffects 1.12

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

Item {
    id: slip_lights_item
    width: 38
    height: 200
    property double slip_front_value: 50
    property double slip_rear_value: 50
    property double slip_limit_value: 10
    Image {
        id: slip_rear
        x: 0
        y: 0
        width: 38
        height: 37
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: slip_lights_item.slip_rear_value > slip_lights_item.slip_limit_value ? "images/point_magenta.png" :
                                                                                            "images/point_base.png"
        anchors.verticalCenterOffset: 20
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: slip_front
        x: 3
        y: -5
        width: 38
        height: 37
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: slip_lights_item.slip_front_value > slip_lights_item.slip_limit_value ? "images/point_magenta.png" :
                                                                                            "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -20
    }

    Rectangle {
        id: slip_front_rect
        width: 60
        height: 10
        color: slip_lights_item.slip_front_value > slip_lights_item.slip_limit_value ? dashboard_Utils.vi_fucsia : dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        rotation: 90
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: dashboard_Utils.vi_fucsia
                cornerRadius: parent.radius + glowRadius
            }
        anchors.verticalCenterOffset: -37
    }

    Rectangle {
        id: slip_rear_rect
        width: 60
        height: 10
        color: slip_lights_item.slip_rear_value > slip_lights_item.slip_limit_value ? dashboard_Utils.vi_fucsia :  dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: dashboard_Utils.vi_fucsia
                cornerRadius: parent.radius + glowRadius
            }
        anchors.verticalCenterOffset: 37
        rotation: 90
    }

Dashboard_Utils{id: dashboard_Utils}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/
