import QtQuick 2.12
import QtQuick.Extras 1.4
import "../../../qml/default/default_db"

Item {
    id: traffic_sign_widget
    width: 150
    height: 150
    anchors.verticalCenter: parent.verticalCenter
    property alias traffic_sign_activity: sign_SpeedLimit_image.visible
    property alias traffic_sign_widget_Opacity: sign_SpeedLimit_image.opacity
    property alias sign_SpeedLimit_image: sign_SpeedLimit_image.source
    property double sign_speed: 50
    anchors.horizontalCenterOffset: -270
    anchors.horizontalCenter: parent.horizontalCenter

    onSign_speedChanged: {
        sign_SpeedLimit_image_off.running = true
    }


    Image {
        opacity: 0.75
        NumberAnimation {
            id: sign_SpeedLimit_image_off
            target: sign_SpeedLimit_image
            property: "opacity"
            from: sign_SpeedLimit_image.opacity
            to: 0
            duration: 1000
            easing.type: Easing.InCirc
            alwaysRunToEnd: true
            onFinished: {
                sign_speed_text.text = sign_speed
                sign_SpeedLimit_image_back_on.running = true
            }
        }
        NumberAnimation {
            id: sign_SpeedLimit_image_back_on
            target: sign_SpeedLimit_image
            property: "opacity"
            from: 0
            to: traffic_sign_widget_Opacity
            duration: 1500
            easing.type: Easing.InCirc
            alwaysRunToEnd: true
        }

        id: sign_SpeedLimit_image
        anchors.fill: parent
        source: "images/Sign_SpeedLimit.svg"
        antialiasing: true
        fillMode: Image.PreserveAspectFit

        Text {
            id: sign_speed_text
            width: 100
            height: 100
            text: qsTr("50")
            elide: Text.ElideNone
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 75
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            fontSizeMode: Text.HorizontalFit
            maximumLineCount: 1
            font.bold: true
            font.family: "Open Sans"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Dashboard_Utils{id: dashboard_Utils}
}

/*##^##
Designer {
    D{i:0;height:150;width:150}
}
##^##*/
