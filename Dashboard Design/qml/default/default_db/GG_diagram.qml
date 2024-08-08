import QtQuick 2.12
import QtCharts 2.15
import "../../../qml/default/default_db"

Item {

    property double longitudinal: 0
    property double lateral: 0
    property double max_g: 1.5
    property double solver_status: 0        //crt solver status
    property double gg_trace_time: 3        //trace persistent time
    property bool split_g: true
    //0 --> max_g  1 --> max_g_internal
    property alias gg_circleColor: gg_circle.color
    property alias gg_circleWidth: gg_circle.width
    property alias gg_backgroundColor: gg_background.color

    property alias gg_trace_Color: scatter_gg_series.color

    id: gg_item
    width: 350
    height: 350
    scale: dashboard_Utils.resize_content(width, height, 350, 350)
    Rectangle {
        id: gg_background
        width: 350
        height: 350
        color: dashboard_Utils.vi_transparent
        radius: width/20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Rectangle {
        id: vertical_target
        width: 2
        height: 252
        anchors.verticalCenter: parent.verticalCenter
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop {
                position: 0
                color: dashboard_Utils.vi_transparent
            }

            GradientStop {
                position: 0.3
                color: dashboard_Utils.vi_light_grey
            }

            GradientStop {
                position: 0.7
                color: dashboard_Utils.vi_light_grey
            }

            GradientStop {
                position: 1
                color: dashboard_Utils.vi_transparent
            }


        }
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: gg_circles
            x: -126
            y: -1
            anchors.verticalCenter: parent.verticalCenter
            source: "images/gg_target.svg"
            antialiasing: true
            mipmap: true
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: horizontal_target
        width: 2
        height: 252
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        rotation: 90
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop {
                position: 0
                color: dashboard_Utils.vi_transparent
            }

            GradientStop {
                position: 0.3
                color: dashboard_Utils.vi_light_grey
            }

            GradientStop {
                position: 0.7
                color: dashboard_Utils.vi_light_grey
            }

            GradientStop {
                position: 1
                color: dashboard_Utils.vi_transparent
            }
        }
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ChartView {
        width: 270
        height: 287
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -8
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
        title: "Scatters"
        titleColor: dashboard_Utils.vi_transparent
        backgroundColor: dashboard_Utils.vi_transparent
        plotAreaColor: dashboard_Utils.vi_transparent
        legend.visible: false
        antialiasing: true
        dropShadowEnabled: false
        LineSeries {
            id: scatter_gg_series
            pointLabelsClipping: false
            color: dashboard_Utils.vi_red
            width: 5
            capStyle: Qt.RoundCap

////            calibration points
//                        borderColor: dashboard_Utils.vi_transparent
//                        markerShape: ScatterSeries.MarkerShapeCircle
//                        markerSize: 10
//                        XYPoint { x: gg_item.max_g; y: 0 }
//                        XYPoint { x: -gg_item.max_g; y: 0 }
//                        XYPoint { x: 0; y: gg_item.max_g }
//                        XYPoint { x: 0; y: -gg_item.max_g }
//                        XYPoint { x: 0; y: 0 }

            axisY: ValueAxis{
                id: y_axis_values
                visible: false
                min: -gg_item.max_g*1.1
                max: gg_item.max_g*1.1
                labelsVisible: false
            }
            axisX: ValueAxis{
                id: x_axis_values
                visible: false
                min: -gg_item.max_g*1.1
                max: gg_item.max_g*1.1
                labelsVisible: false
            }
        }
        Timer{
            id: append_points
            running: (gg_item.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED)    //plot only during test started
            repeat: true
            interval: 1/20*1000
            onTriggered: {
                //add the new point
                scatter_gg_series.append(-gg_item.lateral,-gg_item.longitudinal);
                //remove first point if the number exceed the time defined
                if (scatter_gg_series.count*(append_points.interval/1000) > gg_item.gg_trace_time){
                    scatter_gg_series.remove(0)
                }
            }
        }
    }
    Rectangle {
        id: gg_circle
        width: 15
        height: width
        color: dashboard_Utils.vi_white
        radius: width
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 94*dashboard_Utils.saturation(gg_item.longitudinal,-gg_item.max_g*1.1,gg_item.max_g*1.1)/(gg_item.max_g)
        anchors.horizontalCenterOffset: -94*dashboard_Utils.saturation(gg_item.lateral,-gg_item.max_g*1.1,gg_item.max_g*1.1)/(gg_item.max_g)
    }

    Text {
        id: gg_text_abs
        width: 155
        height: 94
        color: dashboard_Utils.vi_white
        text: (Math.sqrt(Math.pow(gg_item.lateral,2)+Math.pow(gg_item.longitudinal,2))).toFixed(2)
        elide: Text.ElideRight
        visible: !gg_item.split_g
        font.pixelSize: 45
        horizontalAlignment: Text.AlignRight
        wrapMode: Text.NoWrap
        anchors.horizontalCenter: parent.horizontalCenter
        maximumLineCount: 1
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Open Sans"
        anchors.horizontalCenterOffset: 90
        anchors.verticalCenterOffset: -106
    }

    Text {
        id: gg_long_text
        width: 128
        height: 47
        color: dashboard_Utils.vi_white
        text: Math.abs(gg_item.longitudinal).toFixed(2)
        visible: gg_item.split_g
        font.family: "Open Sans"
        font.pixelSize: 30
        anchors.verticalCenterOffset: -136
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignRight
        fontSizeMode: Text.FixedSize
        wrapMode: Text.WrapAnywhere
        maximumLineCount: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -26
    }

    Text {
        id: gg_lat_text
        width: 128
        height: 47
        color: dashboard_Utils.vi_white
        text: Math.abs(gg_item.lateral).toFixed(2)
        visible: gg_item.split_g
        font.family: "Open Sans"
        font.pixelSize: 30
        anchors.verticalCenterOffset: -18
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        fontSizeMode: Text.FixedSize
        horizontalAlignment: Text.AlignRight
        wrapMode: Text.WrapAnywhere
        maximumLineCount: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 103
    }

    Dashboard_Utils{id: dashboard_Utils}



}

/*##^##
Designer {
    D{i:0;formeditorZoom:8;height:350;width:350}
}
##^##*/
