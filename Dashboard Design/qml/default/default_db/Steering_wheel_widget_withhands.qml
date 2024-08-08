import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {
    id: steering_wheel
    width: 250
    height: 150
    antialiasing: false

    property double solver_status: 0                //solver status
    property double str_wheel_Rotation: 0           //steering wheel rotation from crt
    property bool str_wheel_forced_Visible: false   //forcing visible always
    property bool hands_on_alert: true

    property alias text_angleVisible: text_angle.visible                //text visibility
    property alias text_angleAnchorsverticalCenterOffset: text_angle.anchors.verticalCenterOffset //text position
    property alias text_angleAnchorshorizontalCenterOffset: text_angle.anchors.horizontalCenterOffset //text position

    Image {
        id: str_wheel_image
        x: 0
        y: 0
        visible: true
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: text_angle.visible ? -50 : 0
        scale: 0.2
        // rotation is in degrees
        rotation: -dashboard_Utils.rad2deg(steering_wheel.str_wheel_Rotation)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: dashboard_Utils.update_str_wheel_image(steering_wheel.str_wheel_Rotation, steering_wheel.solver_status)
        antialiasing: true
        mipmap: true
    }

    Image {
        id: red_indication_negative
        width: 600
        height: 600
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: "images/SteeringWheel_red_negative.png"
        antialiasing: true
        mipmap: true
        scale: 0.2
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: red_indication_positive
        width: 600
        height: 600
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        source: "images/SteeringWheel_red_positive.png"
        mipmap: true
        scale: 0.2
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: text_angle
        color: dashboard_Utils.vi_light_grey
        visible: false
        text: (-dashboard_Utils.rad2deg(steering_wheel.str_wheel_Rotation)).toFixed(1)
        maximumLineCount: 10
        anchors.horizontalCenterOffset: 115
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        font.family: "Open Sans"
        anchors.horizontalCenter: str_wheel_image.horizontalCenter
        anchors.verticalCenter: str_wheel_image.verticalCenter
        font.pixelSize: 35
    }


    /*Image {
        id: hands
        //x: 61
        //y: 51

        width: 489
        height: 187
        source: "images/Hands.png"
        //rotation: 0
        fillMode: Image.PreserveAspectFit
        //visible: dashboard_Utils.update_visibility_on_solver_status(steering_wheel.solver_status, steering_wheel.hands_on_alert)
        visible: steering_wheel.hands_on_alert
        anchors.verticalCenter: str_wheel_image.verticalCenter
        scale: 0.25
        // rotation is in degrees
        rotation: -dashboard_Utils.rad2deg(steering_wheel.str_wheel_Rotation)
        anchors.horizontalCenter: str_wheel_image.horizontalCenter
        antialiasing: true
        mipmap: true
        SequentialAnimation on OpacityAnimator {
            running: true
            loops: Animation.Infinite
            PropertyAnimation {id: animationOne; target: hands; alwaysRunToEnd: true; property: "opacity"; loops: 1; running: false; to:1; duration: 500; onStopped: animationTwo.start()}
            PropertyAnimation {id: animationTwo; target: hands; alwaysRunToEnd: true; property: "opacity"; running: false; to:0.2; duration: 300}
        }
    }*/

    Dashboard_Utils{id: dashboard_Utils}




}

/*##^##
Designer {
    D{i:0;formeditorZoom:4;height:150;width:150}
}
##^##*/
