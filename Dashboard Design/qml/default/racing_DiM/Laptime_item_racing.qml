import QtQuick 2.12


import "../../../qml/default/default_db"


Item {

    property double lap_time_value: 0
    property double lap_last_time_value: 0
    property double lap_num_value: 0
    property double diff_time_value: 0

    property double path_s: 0

    property var current_lap_time_path: ([])
    property var last_lap_time_path: ([])
    property var best_lap_time_path: ([])
    property string text_lap_best: best_laptime_text_.text
    property double internal_diff: 0


    onText_lap_bestChanged: {
        console.log("start best")
        laptime_item.best_lap_time_path = laptime_item.last_lap_time_path
        console.log("done best")
    }

    onPath_sChanged: {
        laptime_item.current_lap_time_path.push(
                    {path_s: laptime_item.path_s, time: laptime_item.lap_time_value})
        for (var item in best_lap_time_path){
            if (laptime_item.path_s > best_lap_time_path[item].path_s){
                laptime_item.internal_diff = best_lap_time_path[item].time -laptime_item.lap_time_value
                break
            }
        }
    }
    onLap_num_valueChanged: {
        laptime_item.last_lap_time_path = laptime_item.last_lap_time_path.slice(0,0)
        laptime_item.last_lap_time_path = laptime_item.current_lap_time_path
        laptime_item.current_lap_time_path = laptime_item.current_lap_time_path.slice(0,0)
        console.log("reset")
    }

    Component.onDestruction: {
        console.log(laptime_item.current_lap_time_path[current_lap_time_path.length-1].time)
        console.log(laptime_item.last_lap_time_path[last_lap_time_path.length-1].time)
        console.log(laptime_item.best_lap_time_path[best_lap_time_path.length-1].time)
    }

    id: laptime_item
    width: parent.width*3/4/2
    height: parent.height/7*3
    anchors.verticalCenterOffset: -parent.height/7
    Rectangle {
        id: border_laptime
        color: dashboard_Utils.vi_transparent
        radius: 10
        border.color: dashboard_Utils.vi_grey
        border.width: 6
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
    }

    Text {
        id: current_laptime_text
        x: 0
        width: 161
        height: 37
        color: dashboard_Utils.vi_yellow
        text: "Lap Time"
        anchors.top: parent.top
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.topMargin: 10
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        layer.smooth: true
        leftPadding: 10
        bottomPadding: 10
    }

    Text {
        id: current_laptime_text_
        x: 0
        width: 239
        height: 37
        color: dashboard_Utils.vi_white
        text: dashboard_Utils.lap_current_fcn(laptime_item.lap_time_value)
        anchors.top: current_laptime_text.bottom
        font.pixelSize: 35
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Open Sans"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 10
        bottomPadding: 10
        anchors.horizontalCenterOffset: 0
    }

    Text {
        id: last_laptime_text
        x: 0
        width: 161
        height: 37
        color: dashboard_Utils.vi_yellow
        text: "Last Lap"
        anchors.top: parent.top
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 10
        bottomPadding: 10
        anchors.topMargin: 79
        anchors.horizontalCenterOffset: 83
    }

    Text {
        id: last_laptime_text_
        x: 0
        width: 239
        height: 37
        color: dashboard_Utils.vi_cream
        text: dashboard_Utils.lap_current_fcn(laptime_item.lap_last_time_value)
        anchors.top: current_laptime_text.bottom
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.topMargin: 68
        font.family: "Open Sans"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 10
        bottomPadding: 10
        anchors.horizontalCenterOffset: 83

    }

    Text {
        id: best_laptime_text
        x: 0
        width: 161
        height: 37
        color: dashboard_Utils.vi_yellow
        text: "Best Lap"
        anchors.top: parent.top
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 10
        anchors.topMargin: 145
        bottomPadding: 10
        anchors.horizontalCenterOffset: 83
    }

    Text {
        id: best_laptime_text_
        x: 0
        width: 239
        height: 37
        color: dashboard_Utils.vi_fucsia
        text: dashboard_Utils.lap_best_crt_fcn(laptime_item.lap_last_time_value)
        anchors.top: current_laptime_text.bottom
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Open Sans"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 10
        bottomPadding: 10
        anchors.topMargin: 135
        anchors.horizontalCenterOffset: 83
    }

    Text {
        id: diff_laptime_text
        x: 0
        width: 161
        height: 37
        color: dashboard_Utils.vi_yellow
        text: "Time Diff"
        anchors.top: parent.top
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 10
        anchors.topMargin: 90
        bottomPadding: 10
        anchors.horizontalCenterOffset: -84
    }

    Text {
        id: diff_laptime_text_
        x: 0
        width: 155
        height: 54
        color: laptime_item.diff_time_value>0 ?
                   dashboard_Utils.vi_red :         //positive
                   dashboard_Utils.vi_green         //negative
        text: laptime_item.diff_time_value>=0 ?
                  "+" + laptime_item.diff_time_value.toFixed(3) :
                  laptime_item.diff_time_value.toFixed(3)
        elide: Text.ElideRight
        anchors.top: current_laptime_text.bottom
        font.pixelSize: 40
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        font.family: "Open Sans"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 10
        bottomPadding: 10
        anchors.topMargin: 75
        anchors.horizontalCenterOffset: -101
    }

Dashboard_Utils{
    id: dashboard_Utils
    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_R) {
            dashboard_Utils.lap_best = 0;
            dashboard_Utils.lap_best_crt = 0;
            console.log("reset the best lap")
        }
    }

}

}

/*##^##
Designer {
    D{i:0;height:227.1428571428571;width:384}
}
##^##*/
