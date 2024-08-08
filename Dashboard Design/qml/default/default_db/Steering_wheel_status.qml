import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"


Item {
    id: steering_wheel
    visible: true
    width: 267
    height: 194

    // the channel to connect is "VI_DriveSim.Inputs.ECAT.SteeringWheel.DriveStatus"
    property double steering_wheel_status: 0
    // steering wheel fault definition
    property double steering_wheel_fault: 0
    //programstatus
    property double steering_wheel_programStatus: 0
    // status solver definition
    property double solver_status: 0

    Item {
        id: steering_wheel_item_inside
        anchors.fill: parent

        Rectangle {
            id: steering_wheel_text_rectangle
            width: 200
            height: 50
            color: dashboard_Utils.vi_black
            radius: 10
            border.width: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: 0
            Text {
                id: steering_wheel_text
                color: dashboard_Utils.vi_cream
                text: qsTr("STEERING  WHEEL")
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Sansation"
                anchors.verticalCenterOffset: -12
                verticalAlignment: Text.AlignVCenter
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: -60
        }

        Rectangle {
            id: status_rectangle
            x: 12
            y: -39
            width: 236
            height: 123
            color: dashboard_Utils.update_drive_status_color(steering_wheel.steering_wheel_status, steering_wheel.steering_wheel_fault,
                                                             steering_wheel.steering_wheel_programStatus, steering_wheel.solver_status)
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: status_text
            x: 26
            y: 14
            width: 224
            height: 167
            color: dashboard_Utils.vi_black
            text: dashboard_Utils.update_drive_status_text(steering_wheel.steering_wheel_status, steering_wheel.steering_wheel_fault,
                                                           steering_wheel.steering_wheel_programStatus, steering_wheel.solver_status)
            font.pixelSize: 48
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Sansation"
            verticalAlignment: Text.AlignVCenter
            styleColor: dashboard_Utils.vi_white
            maximumLineCount: 2
        }

    }

        Dashboard_Utils{id: dashboard_Utils}

}




/*##^##
Designer {
    D{i:0;formeditorZoom:2}D{i:2;anchors_height:200;anchors_width:200}
}
##^##*/
