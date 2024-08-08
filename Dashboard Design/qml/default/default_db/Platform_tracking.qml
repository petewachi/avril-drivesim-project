import QtQuick 2.15
import QtCharts 2.15
import QtGraphicalEffects 1.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

Item {
    id: platform_tracking
    width: 600
    height: 600

    property bool platform_tracking_mode: true          //enable the tracking of the platform
    property bool driveSim_activity: false
    property double solver_status: 0
    property double cueing_status: 0
    property bool dimC: true                //bool
    property double platform_trace_time: 10*60                      //max trace persistent time in seconds (10 minutes * 60)
    property alias platform_trace_width: scatter_line_series.width  //max trace persistent time in seconds (10 minutes * 60)

    property double pos_lat: 0      //values [0-1]
    property double pos_long: 0     //values [0-1]

    property double lap_num: 0     //lap num used to reset the platform trace

    property double pos_yellow: 0
    property double pos_red: 0

    enabled: platform_tracking.platform_tracking_mode
    visible: platform_tracking.platform_tracking_mode

    Image {

        id: baseframe_trace
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/platform_dimc_item_trace.png"
        fillMode: Image.PreserveAspectFit

        ChartView {
            id: chartView
            width: 477
            height: 477
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            titleColor: dashboard_Utils.vi_transparent
            backgroundColor: dashboard_Utils.vi_transparent
            plotAreaColor: dashboard_Utils.vi_transparent
            legend.visible: false
            title: ""
            antialiasing: true
            backgroundRoundness: 0

            LineSeries {
                id: scatter_line_series
                useOpenGL: false
                color: dashboard_Utils.vi_light_grey
                pointLabelsClipping: false

                capStyle: Qt.RoundCap
                width: 3

                //                borderColor: dashboard_Utils.vi_transparent
                //                markerSize: 10
                //                markerShape: ScatterSeries.MarkerShapeCircle
                //                XYPoint { x: 1; y: 0 }
                //                XYPoint { x: -1; y: 0 }
                //                XYPoint { x: 0; y: 1 }
                //                XYPoint { x: 0; y: -1 }
                //                XYPoint { x: 0; y: 0 }

                axisX: ValueAxis{
                    id: x_axis_values
                    min: -1*1.1
                    max: 1*1.1
                    visible: false
                }
                axisY: ValueAxis{
                    id: y_axis_values
                    min: -1*1.1
                    max: 1*1.1
                    visible: false
                }
            }
        }
    }

    Timer{
        id: append_points
        running: (platform_tracking.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED ||    //plot only during pause and test started
                  platform_tracking.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED)  &&
                 (platform_tracking.cueing_status === dashboard_Utils.cUEING_STATUS_STARTED     ||    //plot only when platform is moving
                  platform_tracking.cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_DOWN     ||
                  platform_tracking.cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_UP) &&
                 (platform_tracking.platform_tracking_mode)
        repeat: true
        interval: 1/20*1000
        onTriggered: {
            //add the new point
            scatter_line_series.append(-platform_tracking.pos_lat, platform_tracking.pos_long);
            //remove first point if the number exceed the time defined
            if (scatter_line_series.count*(append_points.interval/1000) > platform_tracking.platform_trace_time){
                scatter_line_series.remove(0)
            }
        }
    }
    onLap_numChanged: {
        //reset the platform trace when lap num is changed
        scatter_line_series.clear()
        console.log("New lap, clearing the trace")
    }
    onPlatform_tracking_modeChanged: {
        //reset the platform trace when T switch off the tracking mode
        if (!platform_tracking.platform_tracking_mode) scatter_line_series.clear()
        console.log("Switching off tracking mode, clearing the trace")
    }
    onDriveSim_activityChanged: {
        //reset the platform trace when drivesim test is restarted
        if (platform_tracking.driveSim_activity) scatter_line_series.clear()
        console.log("Restarting a new drivesim test, clearing the trace")
    }

    Dashboard_Utils{id:dashboard_Utils}

    states: [
        State {
            name: "DiM_C"
            when: platform_tracking.dimC

            PropertyChanges {
                target: baseframe_trace
                source: "images/platform_dimc_item_trace.png"
            }
            PropertyChanges {
                target: chartView
                //these are created using dimc 400 reference internal border
                width: 477
                height: 477
            }
        },
        State {
            name: "DiM_Sag"
            when: !platform_tracking.dimC

            PropertyChanges {
                target: baseframe_trace
                source: "images/platform_sag_item_trace.png"
            }
            PropertyChanges {
                target: chartView
                width: 346
                height: 346
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:3;invisible:true}
}
##^##*/
