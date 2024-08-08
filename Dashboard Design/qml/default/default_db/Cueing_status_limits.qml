import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {
    id: cueing_status_limits
    visible: true

    property double solver_status: 0                            // vehicle dynamic solver status


    property double cueing_status: 0                            // cueing status
    property double cueing_request: 7                           //"VI_DriveSim.Inputs.Platform.Cueing.REQUEST"
    property double status_operation: 0                         // operation platform status
    property double status_stream: 0                            // stream status coming from plc/pmac
    property double status_hmi: 0                               // hmi status
    property double cueing_status_limit_long_pitch: 0           //"VI_DriveSim.Outputs.Platform.Cueing.CUEING_STATUS_XY"
    property double cueing_status_limit_lat_roll: 0             //"VI_DriveSim.Outputs.Platform.Cueing.CUEING_STATUS_YX"
    property double cueing_status_limit_yaw: 0                  //"VI_DriveSim.Outputs.Platform.Cueing.CUEING_STATUS_ZA"
    property double cueing_status_limit_vert: 0                 //"VI_DriveSim.Outputs.Platform.Cueing.CUEING_STATUS_ZV"


    width: 276
    height: 240

    scale: dashboard_Utils.resize_content(width, height, 276, 240)
    antialiasing: true


    Item {
        id: status_item
        x: 56
        y: 329
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        antialiasing: true
        Rectangle {
            id: platform_text_rectangle
            width: 200
            height: 50
            color: dashboard_Utils.vi_black
            radius: 10
            border.width: 0
            anchors.verticalCenterOffset: -61
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: platform_text
                color: dashboard_Utils.vi_cream
                text: qsTr("PLATFORM")
                font.bold: true
                anchors.verticalCenterOffset: -12
                font.family: "Sansation"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
            }
        }

        Rectangle {
            id: safety_text_rectangle
            visible: dashboard_Utils.update_cueing_safety(cueing_status_limits.cueing_status, cueing_status_limits.solver_status,
                                                          cueing_status_limits.status_operation, cueing_status_limits.status_stream,
                                                          cueing_status_limits.status_hmi, cueing_status_limits.cueing_status_limit_long_pitch,
                                                          cueing_status_limits.cueing_status_limit_lat_roll, cueing_status_limits.cueing_status_limit_yaw,
                                                          cueing_status_limits.cueing_status_limit_vert, cueing_status_limits.cueing_request)
            width: 220
            height: 100
            color: dashboard_Utils.vi_black
            radius: 10
            border.width: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 65
            layer.textureSize.height: 0
            layer.textureSize.width: 0
            layer.textureMirroring: ShaderEffectSource.NoMirroring
            Text {
                id: safety_text
                width: parent.width
                height: parent.height/2
                color: dashboard_Utils.vi_cream
                text: dashboard_Utils.safety_logic_text(cueing_status_limits.cueing_status_limit_long_pitch,cueing_status_limits.cueing_status_limit_lat_roll,
                                                        cueing_status_limits.cueing_status_limit_yaw,       cueing_status_limits.cueing_status_limit_vert)
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                lineHeight: 1
                wrapMode: Text.WordWrap
                anchors.verticalCenterOffset: parent.height/4
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Sansation"
            }
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: status_rectangle
            x: 12
            y: -39
            width: 236
            height: 123
            color: dashboard_Utils.update_cueing_status_color(cueing_status_limits.cueing_status, cueing_status_limits.solver_status,
                                                              cueing_status_limits.status_operation, cueing_status_limits.status_stream,
                                                              cueing_status_limits.status_hmi, cueing_status_limits.cueing_status_limit_long_pitch,
                                                              cueing_status_limits.cueing_status_limit_lat_roll, cueing_status_limits.cueing_status_limit_yaw,
                                                              cueing_status_limits.cueing_status_limit_vert, cueing_status_limits.cueing_request)
            radius: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
        }

        Text {
            id: status_text
            x: 26
            y: 14
            width: 224
            height: 167
            color: dashboard_Utils.vi_black
            text: dashboard_Utils.update_cueing_status_text(cueing_status_limits.cueing_status, cueing_status_limits.solver_status,
                                                            cueing_status_limits.status_operation, cueing_status_limits.status_stream,
                                                            cueing_status_limits.status_hmi, cueing_status_limits.cueing_status_limit_long_pitch,
                                                            cueing_status_limits.cueing_status_limit_lat_roll, cueing_status_limits.cueing_status_limit_yaw,
                                                            cueing_status_limits.cueing_status_limit_vert, cueing_status_limits.cueing_request)
            wrapMode: Text.WordWrap
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 48
            font.family: "Sansation"
            styleColor: dashboard_Utils.vi_white
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            maximumLineCount: 2
        }



    }

Dashboard_Utils{id: dashboard_Utils}

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
