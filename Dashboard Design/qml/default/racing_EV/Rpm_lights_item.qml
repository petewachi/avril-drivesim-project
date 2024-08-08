import QtQuick 2.12
import QtGraphicalEffects 1.0

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"


Item {
    id: rpm_lights_item
    property double rpm_value: 9500

    property double rpm_green1_value: 7000        //first rpm green light
    property double rpm_green2_value: 7500        //second rpm green light
    property double rpm_yellow1_value: 8000        //rpm yellow light
    property double rpm_yellow2_value: 8500        //second rpm yellow light
    property double rpm_red_value: 9000           //rpm red light
    property double rpm_limit_value: 9100           //rpm max light

    property bool lights_mode: false
    state: "border_center"

    Timer{
        id: down_visibility
        property bool lights_blink: true
        running: rpm_lights_item.rpm_value > rpm_lights_item.rpm_limit_value
        repeat: true
        interval: (1/8)*2*1000
        onTriggered: {
            down_visibility.lights_blink = false
            restore_visibility.restart()
        }
    }
    Timer{
        id: restore_visibility
        running: false
        repeat: false
        interval: (1/8)*1000
        onTriggered: {
            down_visibility.lights_blink = true
        }
    }

    Image {
        id: rpm_lights_green_1
        x: 0
        y: 0
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green1_value ? "images/point_green.png":
                                                                               "images/point_base.png"
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: rpm_lights_green_2
        x: -6
        y: -2
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green1_value ? "images/point_green.png":
                                                                               "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*9
    }

    Image {
        id: rpm_lights_green_3
        x: -1
        y: 1
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green2_value ? "images/point_green.png":
                                                                               "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9
    }


    Image {
        id: rpm_lights_green_4
        x: 5
        y: 2
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green2_value ? "images/point_green.png":
                                                                               "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*8
    }


    Image {
        id: rpm_lights_yellow_1
        x: 6
        y: -4
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow1_value ? "images/point_yellow.png":
                                                                                "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*2
    }

    Image {
        id: rpm_lights_yellow_2
        x: -1
        y: -11
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow1_value ? "images/point_yellow.png":
                                                                                "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*7
    }

    Image {
        id: rpm_lights_yellow_3
        x: 0
        y: -10
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow2_value ? "images/point_yellow.png":
                                                                                "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*3
    }

    Image {
        id: rpm_lights_yellow_4
        x: -7
        y: -17
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow2_value ? "images/point_yellow.png":
                                                                                "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*6
    }

    Image {
        id: rpm_lights_red_1
        x: 0
        y: -10
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_red_value ? "images/point_red.png":
                                                                            "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*4
    }

    Image {
        id: rpm_lights_red_2
        x: -4
        y: -7
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_red_value ? "images/point_red.png":
                                                                            "images/point_base.png"
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*5
    }

    Rectangle {
        id: rect_light_1
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green1_value && down_visibility.lights_blink ? dashboard_Utils.vi_green :
                                                                              dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: -360
        anchors.horizontalCenter: parent.horizontalCenter
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_2
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green2_value && down_visibility.lights_blink ? dashboard_Utils.vi_green :
                                                                              dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -280
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_3
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow1_value && down_visibility.lights_blink ? dashboard_Utils.vi_yellow :
                                                                              dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -200
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_4
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow2_value && down_visibility.lights_blink ? dashboard_Utils.vi_yellow :
                                                                               dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_5
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_red_value && down_visibility.lights_blink ? dashboard_Utils.vi_red :
                                                                               dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_6
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_red_value && down_visibility.lights_blink ? dashboard_Utils.vi_red :
                                                                           dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_7
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow2_value && down_visibility.lights_blink ? dashboard_Utils.vi_yellow :
                                                                               dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_8
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow1_value && down_visibility.lights_blink ? dashboard_Utils.vi_yellow :
                                                                               dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 200
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_9
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green2_value && down_visibility.lights_blink ? dashboard_Utils.vi_green :
                                                                              dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 280
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }

    Rectangle {
        id: rect_light_10
        width: 60
        height: 10
        color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green1_value && down_visibility.lights_blink ? dashboard_Utils.vi_green :
                                                                              dashboard_Utils.vi_black
        radius: 3
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 360
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        RectangularGlow {
                visible: parent.color !== dashboard_Utils.vi_black
                anchors.fill: parent
                glowRadius: 10
                spread: 0.2
                color: parent.color
                cornerRadius: parent.radius + glowRadius
            }
    }
    states: [
        State {
            name: "left_right"
            when: rpm_lights_item.lights_mode

            PropertyChanges {
                target: rpm_lights_green_1
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*0
                source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green1_value ? "images/point_green.png":
                                                                                       "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_green_2
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9
                source: rpm_lights_item.rpm_value >(( rpm_lights_item.rpm_green1_value + rpm_lights_item.rpm_green2_value)/2) ?   "images/point_green.png":
                                                                                                                                "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_green_3
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*2
                anchors.verticalCenterOffset: 0
                source: rpm_lights_item.rpm_value >rpm_lights_item.rpm_green2_value ? "images/point_green.png":
                                                                                      "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_green_4
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*3
                anchors.verticalCenterOffset: 0
                source: rpm_lights_item.rpm_value >(( rpm_lights_item.rpm_green2_value + rpm_lights_item.rpm_yellow1_value)/2) ?   "images/point_green.png":
                                                                                                                                 "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_yellow_1
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*4
                anchors.verticalCenterOffset: 0
                source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow1_value ?   "images/point_yellow.png":
                                                                                        "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_yellow_2
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*5
                anchors.verticalCenterOffset: 0
                source: rpm_lights_item.rpm_value >(( rpm_lights_item.rpm_yellow1_value + rpm_lights_item.rpm_yellow2_value)/2) ?   "images/point_yellow.png":
                                                                                                                                  "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_yellow_3
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*6
                anchors.verticalCenterOffset: 0
                source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow2_value ?   "images/point_yellow.png":
                                                                                        "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_yellow_4
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*7
                anchors.verticalCenterOffset: 0
                source: rpm_lights_item.rpm_value >(( rpm_lights_item.rpm_yellow2_value + rpm_lights_item.rpm_red_value)/2) ?   "images/point_yellow.png":
                                                                                                                              "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_red_1
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*8
                anchors.verticalCenterOffset: 0
                source: rpm_lights_item.rpm_value >rpm_lights_item.rpm_red_value ?   "images/point_red.png":
                                                                                   "images/point_base.png"
            }

            PropertyChanges {
                target: rpm_lights_red_2
                anchors.horizontalCenterOffset: -parent.width/3.5 + parent.width/3.5*2/9*9
                source: rpm_lights_item.rpm_value > rpm_lights_item.rpm_limit_value ?   "images/point_red.png":
                                                                                      "images/point_base.png"
            }

            PropertyChanges {
                target: rect_light_1
                color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green1_value && down_visibility.lights_blink ? dashboard_Utils.vi_green :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_2
                color: rpm_lights_item.rpm_value > (( rpm_lights_item.rpm_green1_value + rpm_lights_item.rpm_green2_value)/2) && down_visibility.lights_blink ? dashboard_Utils.vi_green :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_3
                color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_green2_value && down_visibility.lights_blink ? dashboard_Utils.vi_green :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_4
                color: rpm_lights_item.rpm_value > (( rpm_lights_item.rpm_green2_value + rpm_lights_item.rpm_yellow1_value)/2) && down_visibility.lights_blink ? dashboard_Utils.vi_green :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_5
                color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow1_value && down_visibility.lights_blink ? dashboard_Utils.vi_yellow :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_6
                color: rpm_lights_item.rpm_value > (( rpm_lights_item.rpm_yellow1_value + rpm_lights_item.rpm_yellow2_value)/2) && down_visibility.lights_blink ? dashboard_Utils.vi_yellow :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_7
                color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_yellow2_value && down_visibility.lights_blink ? dashboard_Utils.vi_yellow :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_8
                color: rpm_lights_item.rpm_value > (( rpm_lights_item.rpm_yellow2_value + rpm_lights_item.rpm_red_value)/2) && down_visibility.lights_blink ? dashboard_Utils.vi_yellow :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_9
                color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_red_value && down_visibility.lights_blink ? dashboard_Utils.vi_red :
                                                                                                                      dashboard_Utils.vi_black
            }

            PropertyChanges {
                target: rect_light_10
                color: rpm_lights_item.rpm_value > rpm_lights_item.rpm_limit_value && down_visibility.lights_blink ? dashboard_Utils.vi_red :
                                                                                                                      dashboard_Utils.vi_black
            }
        },
        State {
            name: "border_center"
            when: !rpm_lights_item.lights_mode
        }
    ]
Dashboard_Utils{id: dashboard_Utils}

}

/*##^##
Designer {
    D{i:0;height:50;width:1024}
}
##^##*/
