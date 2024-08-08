import QtQuick 2.12
import QtQuick.Studio.Components 1.0
import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.14

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"




Item {
    id: lights_item
    width: 1026
    height: 142

    property bool left_indicator: true
    property bool right_indicator: true

    property bool aeb_ready: true
    property bool aeb_on: true

    property bool ldw_on: true
    property bool ldw_ready: true
    property bool ldw_white: true

    property bool lka_on: true
    property bool lka_ready: true
    property bool lka_white: true

    property bool ap_ready: true
    property bool ap_on: true

    property bool abs_on: true
    property bool tcs_on: true

    property bool light_switch: true
    property bool low_beam_on: true
    property bool high_beam_on: true

    property bool esp_on: true
    property bool hill_hold_on: true

    Image {
        id: low_background
        x: 341
        width: 1026
        height: 87
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/upper_section.png"
        anchors.verticalCenterOffset: -6
        anchors.horizontalCenterOffset: 0
        fillMode: Image.PreserveAspectFit
        Row{
            id: lights_row
            width: 920
            height: 90
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                id: left_arrow_item
                width: 90
                height: 60
                opacity: lights_item.left_indicator
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    id: left_arrow_rectangle
                    x: 48
                    y: 16
                    width: 50
                    height: 27
                    visible: false
                    color: dashboard_Utils.vi_green
                    radius: 5
                    border.width: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenterOffset: 0
                }

                Glow {
                    id: left_arrow_rectangle_glow
                    x: 48
                    y: 16
                    color: left_arrow_rectangle.color
                    anchors.fill: left_arrow_rectangle
                    radius: 10
                    samples: 20
                    spread: 0.3
                    source: left_arrow_rectangle
                    anchors.leftMargin: 0
                    fast: true
                    rotation: left_arrow_rectangle.rotation
                    antialiasing: true
                    layer.mipmap: true
                }

                TriangleItem {
                    id: left_arrow_triangle
                    x: -19
                    y: -20
                    visible: false
                    anchors.verticalCenter: left_arrow_rectangle.verticalCenter
                    anchors.horizontalCenter: left_arrow_rectangle.horizontalCenter
                    anchors.horizontalCenterOffset: -36
                    scale: 0.5
                    fillColor: dashboard_Utils.vi_green
                    strokeWidth: -1
                    rotation: -90
                }

                Glow {
                    id: left_arrow_triangle_glow
                    x: -19
                    y: -20
                    scale: left_arrow_triangle_XR.scale
                    color: left_arrow_triangle_XR_path.strokeColor
                    anchors.fill: left_arrow_triangle_XR
                    radius: 20
                    samples: 35
                    spread: 0.3
                    source: left_arrow_triangle_XR
                    fast: true
                    rotation: left_arrow_triangle_XR.rotation
                    antialiasing: true
                    layer.mipmap: true
                }

                Shape {
                    id: left_arrow_triangle_XR
                    width: 100
                    height: 100
                    visible: false
                    anchors.verticalCenter: left_arrow_rectangle.verticalCenter
                    scale: 0.7
                    anchors.horizontalCenter: left_arrow_rectangle.horizontalCenter
                    anchors.horizontalCenterOffset: -25
                    ShapePath {
                        id: left_arrow_triangle_XR_path
                        fillColor: "#00000000"
                        startX: 25
                        startY: 50
                        strokeWidth: 15
                        strokeColor: dashboard_Utils.vi_green
                        strokeStyle: ShapePath.SolidLine
                        joinStyle: ShapePath.RoundJoin
                        PathLine { x: 75; y: 25 }
                        PathLine { x: 75; y: 75 }
                        PathLine { x: 25; y: 50 }
                    }
                }
            }

            Image {
                id: aeb_on_icon
                opacity: lights_item.aeb_ready
                anchors.verticalCenter: parent.verticalCenter
                source: lights_item.aeb_on ? "images/aeb.png" :
                                             "images/aeb_white.png"
                antialiasing: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }
            Item{

                id: ldw_lka
                width: 80
                height: 80
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: ldw_on_icon
                    opacity: lights_item.ldw_white
                    anchors.verticalCenter: parent.verticalCenter
                    source: lights_item.ldw_on ? "images/ldw_icon.png":
                                                 lights_item.ldw_ready ? "images/lka_active_icon.png":
                                                                         "images/ldw_white_icon.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    antialiasing: true
                    mipmap: true
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: lka_on_icon
                    opacity: lights_item.lka_white && !lights_item.ldw_on
                    anchors.verticalCenter: parent.verticalCenter
                    source: lights_item.lka_on ? "images/lka_on_icon.png":
                                                 lights_item.lka_ready ? "images/lka_active_icon.png":
                                                                         "images/ldw_white_icon.png.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    antialiasing: true
                    mipmap: true
                    fillMode: Image.PreserveAspectFit
                }
            }


            Image {
                id: ap_on_icon
                opacity: lights_item.ap_ready || lights_item.ap_on
                anchors.verticalCenter: parent.verticalCenter
                source: lights_item.ap_on ? "images/ap_on_icon.png" :
                                            "images/ap_icon.png"
                antialiasing: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: abs_icon
                opacity: lights_item.abs_on
                anchors.verticalCenter: parent.verticalCenter
                source: "images/abs.png"
                antialiasing: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: tcs_icon
                opacity: lights_item.tcs_on
                anchors.verticalCenter: parent.verticalCenter
                source: "images/tcs.png"
                antialiasing: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: hill_holder_icon
                opacity: lights_item.hill_hold_on
                anchors.verticalCenter: parent.verticalCenter
                source: "images/hill_hold.png"
                mipmap: true
                antialiasing: true
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: esp_icon
                opacity: lights_item.esp_on
                anchors.verticalCenter: parent.verticalCenter
                source: "images/esp.png"
                mipmap: true
                antialiasing: true
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: low_beam_icon
                opacity: lights_item.low_beam_on
                anchors.verticalCenter: parent.verticalCenter
                source: (lights_item.light_switch) ? "images/low_beam_auto.png":
                                                     "images/low_beam.png"
                antialiasing: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: high_beam_icon
                opacity: lights_item.high_beam_on
                anchors.verticalCenter: parent.verticalCenter
                source: (lights_item.light_switch) ? "images/high_beam_auto.png":
                                                     "images/high_beam.png"
                antialiasing: true
                mipmap: true
                fillMode: Image.PreserveAspectFit
            }

            Item {
                id: right_arrow_item
                width: 90
                height: 60
                opacity: lights_item.right_indicator
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
                Rectangle {
                    id: right_arrow_rectangle
                    x: 48
                    y: 16
                    width: 50
                    height: 27
                    visible: false
                    color: dashboard_Utils.vi_green
                    radius: 5
                    border.width: 0
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenterOffset: 0
                }

                Glow {
                    id: right_arrow_rectangle_glow
                    x: 48
                    y: 16
                    color: right_arrow_rectangle.color
                    radius: 10
                    anchors.fill: right_arrow_rectangle
                    source: right_arrow_rectangle
                    layer.mipmap: true
                    rotation: right_arrow_rectangle.rotation
                    spread: 0.3
                    fast: true
                    samples: 20
                    antialiasing: true
                }

                TriangleItem {
                    id: right_arrow_triangle
                    x: -19
                    y: -20
                    visible: false
                    anchors.verticalCenter: right_arrow_rectangle.verticalCenter
                    strokeWidth: -1
                    rotation: -90
                    scale: 0.5
                    fillColor: dashboard_Utils.vi_green
                    anchors.horizontalCenter: right_arrow_rectangle.horizontalCenter
                    anchors.horizontalCenterOffset: -36
                }

                Glow {
                    id: right_arrow_triangle_glow
                    x: -19
                    y: -20
                    color: right_arrow_triangle_XR_path.strokeColor
                    radius: 20
                    anchors.fill: right_arrow_triangle_XR
                    source: right_arrow_triangle_XR
                    layer.mipmap: true
                    rotation: right_arrow_triangle_XR.rotation
                    spread: 0.3
                    scale: right_arrow_triangle_XR.scale
                    fast: true
                    samples: 35
                    antialiasing: true
                }

                Shape {
                    id: right_arrow_triangle_XR
                    width: 100
                    height: 100
                    visible: false
                    anchors.verticalCenter: right_arrow_rectangle.verticalCenter
                    scale: 0.7
                    anchors.horizontalCenter: right_arrow_rectangle.horizontalCenter
                    anchors.horizontalCenterOffset: -25
                    ShapePath {
                        id: right_arrow_triangle_XR_path
                        fillColor: "#00000000"
                        startX: 25
                        startY: 50
                        strokeWidth: 15
                        strokeColor: dashboard_Utils.vi_green
                        strokeStyle: ShapePath.SolidLine
                        joinStyle: ShapePath.RoundJoin
                        PathLine { x: 75; y: 25 }
                        PathLine { x: 75; y: 75 }
                        PathLine { x: 25; y: 50 }
                    }
                }
                anchors.horizontalCenterOffset: 366
            }
        }
    }
    Dashboard_Utils{id: dashboard_Utils}
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:15}D{i:20}D{i:21}
}
##^##*/
