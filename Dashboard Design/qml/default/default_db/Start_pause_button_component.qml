import QtQuick 2.12

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"


Item {
    id: start_pause_button
    property double solver_status: 0
    property double reset_req_delay: 0.04     //s after which the request is reset to 0
    scale: dashboard_Utils.resize_content(width, height, 247, 136)
    width: 247
    height: 136
    enabled: start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED ||
             start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED

    MouseArea {
        id: button_mouseArea
        anchors.fill: parent
        pressAndHoldInterval: 400
        property bool restore_points: false
        onReleased: {
            if (start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED &&
                    !button_mouseArea.restore_points){
                console.log("restart request");
                viclass.setChannelValue("VI_DriveSim.Inputs.Control.VICRT_RESTART_REQ", 1);
                reset_restart.restart();
            }


            if (start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED){
                console.log("restore request");
                viclass.setChannelValue("VI_DriveSim.Inputs.Control.VICRT_RESTORE_REQ", 1)
                reset_restore.restart()
            }
            button_mouseArea.restore_points = false;
        }
        onPressAndHold: {
            if (start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED){
                console.log("saved points request");
                button_mouseArea.restore_points = true;
                viclass.setChannelValue("VI_DriveSim.Inputs.Control.VICRT_RESTORE_REQ", 1);
                reset_restore.restart();
            }
        }

        Timer{
            id: reset_restart
            interval: start_pause_button.reset_req_delay*1000
            running: false
            repeat: false
            onTriggered: {
                viclass.setChannelValue("VI_DriveSim.Inputs.Control.VICRT_RESTART_REQ", 0)
            }
        }
        Timer{
            id: reset_restore
            interval: start_pause_button.reset_req_delay*1000
            running: false
            repeat: false
            onTriggered: {
                viclass.setChannelValue("VI_DriveSim.Inputs.Control.VICRT_RESTORE_REQ", 0)
            }
        }
    }

    Rectangle {
        id: button_rectangle
        scale: button_mouseArea.pressed ? 0.9 : 1
        color: dashboard_Utils.vi_grey
        radius: width/20
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: -86*parent.height/136
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.bottomMargin: 8
        opacity: (start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED ||
                  start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED) ? 1 : 0.5

        Text {
            id: text_command
            color: dashboard_Utils.vi_azure
            text: start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED ? "START" :
                                                                                                    "PAUSE"

            anchors.fill: parent
            font.pixelSize: 50 * start_pause_button.scale
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Sansation"
        }
    }

    Rectangle {
        id: button_rectangle_
        color:start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED ?     dashboard_Utils.vi_yellow_2 :
              start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED ?    dashboard_Utils.vi_green :
                                                                                                    dashboard_Utils.vi_red
        radius: width/20
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.top
        anchors.bottomMargin: -44*parent.height/136
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        anchors.topMargin: 8

        Text {
            id: text_solver_status
            text: "solver status: " + (start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED ? "PAUSED" :
                                       start_pause_button.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED ? "STARTED" :
                                                                                                                                                                                                            "STOPPED")
            anchors.fill: parent
            font.pixelSize: 20 * start_pause_button.scale
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
            font.bold: true
        }
    }
    Dashboard_Utils{id: dashboard_Utils}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75;height:136;width:247}
}
##^##*/
