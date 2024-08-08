import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

MouseArea {
    id: checkbox_v2

    property bool checked_prop
    property bool always_white: false
    width: 100
    height: 95

    Image {
        id: check
        x: 0
        y: 0
        source: "images/check_off.png"
        fillMode: Image.PreserveAspectFit

        NumberAnimation {
            id: switch_off
            target: checkbox_item1
            property: "x"
            duration: 300
            easing.type: Easing.InQuad
            alwaysRunToEnd: true
            running: !checked_prop
            onStarted: {
                if (!always_white){
                    check.source = "images/check_off.png"
                }
            }
            from: 48
            to: 8
        }

        NumberAnimation {
            id: switch_on
            target: checkbox_item1
            property: "x"
            duration: 300
            easing.type: Easing.InQuad
            alwaysRunToEnd: true
            running: checked_prop
            onStarted: {
                check.source = "images/check_on.png"
            }
            from: 8
            to: 48
        }

    }




    acceptedButtons: Qt.AllButtons
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter


    Dashboard_Utils{id: dashboard_Utils}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/
