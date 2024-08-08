import QtQuick 2.12



Item {

    property double lap_time_value: 0
    property double lap_last_time_value: 0
    property double lap_last_time_crt_value: 0
    property double lap_best_time_value: 0
    property double lap_num_value: 0
    property int internal_last_best_computation: 0          //calculation typ of last and best time.
                                                            //0: dashboard calculation
                                                            //1: carrealtime calculation from VI_CarRealTime.Outputs.path_sensor.total_lap_time
                                                            //2: external source
    property double reset_lap_value: 0

    property alias laptime_backgroundColor: laptime_background.color
    property alias best_laptime_text: best_laptime_text_.text

    width: 400
    height: 200

    id: laptime_item
    Rectangle {
        id: laptime_background
        width: 400
        height: 200
        color: dashboard_Utils.vi_transparent
        radius: width/20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: current_laptime_text_
        y: 36
        width: 400
        height: 65
        color: dashboard_Utils.vi_white
        text: dashboard_Utils.lap_current_fcn(laptime_item.lap_time_value)
        elide: Text.ElideLeft
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 55
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenterOffset: 0
        rightPadding: 10
        anchors.verticalCenterOffset: -57
        font.family: "Open Sans"
        layer.smooth: true
    }

    Text {
        id: last_laptime_text
        x: 0
        width: 55
        height: 32
        color: dashboard_Utils.vi_light_grey
        text: "last"
        anchors.verticalCenter: last_laptime_text_.verticalCenter
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: -1
        font.family: "Sansation"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -157
    }

    Text {
        id: last_laptime_text_
        y: 102
        width: 300
        height: 65
        color: dashboard_Utils.vi_light_grey
        text: laptime_item.internal_last_best_computation === 0 ? dashboard_Utils.lap_last_fcn(laptime_item.lap_time_value,laptime_item.lap_num_value) :
              laptime_item.internal_last_best_computation === 1 ? dashboard_Utils.lap_current_fcn(laptime_item.lap_last_time_crt_value):
                                                                  dashboard_Utils.lap_current_fcn(laptime_item.lap_last_time_value)
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 50
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: -1
        anchors.horizontalCenterOffset: 50
        anchors.horizontalCenter: parent.horizontalCenter
        rightPadding: 10
        anchors.topMargin: 68
        font.family: "Open Sans"
        layer.smooth: true

    }

    Text {
        id: best_laptime_text
        width: 55
        height: 32
        color: dashboard_Utils.vi_fucsia
        text: "best"
        anchors.verticalCenter: best_laptime_text_.verticalCenter
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: -1
        font.family: "Sansation"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -156
    }

    Text {
        id: best_laptime_text_
        y: 147
        width: 300
        height: 65
        color: dashboard_Utils.vi_fucsia
        text: laptime_item.internal_last_best_computation === 0 ? dashboard_Utils.lap_best_fcn(laptime_item.lap_time_value,laptime_item.lap_num_value) :
              laptime_item.internal_last_best_computation === 1 ? dashboard_Utils.lap_best_crt_fcn(laptime_item.lap_last_time_crt_value):
                                                                  dashboard_Utils.lap_current_fcn(laptime_item.lap_best_time_value)

        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 50
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenterOffset: 50
        anchors.horizontalCenter: parent.horizontalCenter
        rightPadding: 10
        anchors.verticalCenterOffset: 56
        font.family: "Open Sans"
        layer.smooth: true
        anchors.topMargin: 135
    }

    Text {
        id: lapnum_text
        x: 0
        width: 55
        height: 32
        color: dashboard_Utils.vi_light_grey
        text: "LAP"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: -88
        layer.smooth: true
        anchors.horizontalCenterOffset: -156
        font.family: "Sansation"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: lapnum_text_
        x: 0
        width: 89
        height: 42
        color: dashboard_Utils.vi_white
        text: laptime_item.lap_num_value.toFixed(0)
        anchors.verticalCenter: current_laptime_text_.verticalCenter
        font.pixelSize: 55
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: 0
        layer.smooth: true
        anchors.horizontalCenterOffset: -156
        font.family: "Open Sans"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        id: reset_best_lap_mousearea
        anchors.fill: parent
        onReleased: {
            dashboard_Utils.lap_best = 0;
            dashboard_Utils.lap_best_crt = 0;
            console.log("reset the best lap")
        }
    }

    onReset_lap_valueChanged: {
        if (reset_lap_value !== 0){
            dashboard_Utils.lap_best = 0;
            dashboard_Utils.lap_best_crt = 0;
            console.log("reset the best lap")
        }
    }



    Dashboard_Utils{
        id: dashboard_Utils
    }






}

/*##^##
Designer {
    D{i:0;formeditorZoom:2;height:200;width:420}
}
##^##*/
