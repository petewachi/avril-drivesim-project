import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

Item {
    id: driveSim_connection_item

    //shows connected/disconnected from DriveSim
    property bool driveSim_connected: false
    //popup seconds when recieiving a signal of start/stop of the test
    property double conected_popup_seconds: 1

    //properties of the rectange
    property alias driveSim_connection_rectRadius: driveSim_connection_rect.radius
    property int driveSim_connection_rectBorderwidth: 0
    property color driveSim_connection_rectBordercolor: dashboard_Utils.vi_black
    property alias driveSim_connection_rectColor: driveSim_connection_rect.color

    scale: dashboard_Utils.resize_content(width, height, 340, 110)
    width: 340
    height: 110
    Rectangle {
        id: driveSim_connection_rect
        width: parent.width
        height: parent.height
        color: dashboard_Utils.vi_grey
        radius: height/4
        border.color: driveSim_connection_item.driveSim_connection_rectBordercolor
        border.width: driveSim_connection_item.driveSim_connection_rectBorderwidth
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: driveSim_connection_text
            color: driveSim_connection_item.driveSim_connected ? dashboard_Utils.vi_cream : dashboard_Utils.vi_red
            text: driveSim_connection_item.driveSim_connected ? "connected" : "disconnected"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 50 * driveSim_connection_item.scale
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
            maximumLineCount: 1
            width: parent.width
            height: parent.height
        }
    }
    Rectangle {
        id: driveSim_started
        visible: false
        width: parent.width - driveSim_connection_rect.border.width
        height: parent.height - driveSim_connection_rect.border.width
        color: dashboard_Utils.vi_green
        radius: driveSim_connection_rect.radius
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: driveSim_started_text
            width: parent.width
            height: parent.height
            color: dashboard_Utils.vi_black
            text: "STARTED"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 70
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Sansation"
            maximumLineCount: 1
        }
    }
    Rectangle {
        id: driveSim_stopped
        visible: false
        width: parent.width - driveSim_connection_rect.border.width
        height: parent.height - driveSim_connection_rect.border.width
        color: dashboard_Utils.vi_red
        radius: driveSim_connection_rect.radius
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: driveSim_stopped_text
            width: parent.width
            height: parent.height
            color: dashboard_Utils.vi_black
            text: "STOPPED"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 70
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Sansation"
            maximumLineCount: 1
        }
    }


    Timer{
        id: popup_start_stop_test
        running: false
        repeat: false
        //interval is in milliseconds
        interval: driveSim_connection_item.conected_popup_seconds*1000
        triggeredOnStart: true
        onTriggered: {
            //invert visibility 2 times to display the popup
            if(driveSim_connection_item.driveSim_connected){
                if (driveSim_stopped.visible) driveSim_stopped.visible = false;
                driveSim_started.visible = !driveSim_started.visible
            }else{
                if (driveSim_started.visible) driveSim_started.visible = false;
                driveSim_stopped.visible = !driveSim_stopped.visible
            }
        }
    }

    onDriveSim_connectedChanged: {
        //activate the timer for the popup
        popup_start_stop_test.restart()
    }

    Dashboard_Utils{id: dashboard_Utils}

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75;height:76;width:370}
}
##^##*/
