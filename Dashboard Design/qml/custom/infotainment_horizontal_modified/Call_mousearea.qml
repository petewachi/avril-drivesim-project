import QtQuick 2.12
import "../../../qml/default/default_db"


MouseArea{
    id: call_mousearea
    width: 100
    height: width

    //this button can be used in circle with a text on the bottom of it.
    //while pressed it fills with call_color
    property alias name: text_call.text
    property alias icon_rotation: call_icon.rotation
    property color call_color: dashboard_Utils.vi_azure
    property alias call_iconScale: call_icon.scale
    property alias call_iconSource: call_icon.source

    onPressed: rectangle_call.color = call_mousearea.call_color
    onReleased: rectangle_call.color = dashboard_Utils.vi_transparent

    Rectangle {
        id: rectangle_call
        color: dashboard_Utils.vi_transparent
        radius: width/2
        border.color: dashboard_Utils.vi_white
        border.width: 5
        anchors.fill: parent

        Image {
            id: call_icon
            anchors.fill: parent
            source: "images/call_icon.png"
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            fillMode: Image.PreserveAspectFit
        }
    }

    Text {
        id: text_call
        height: 58
        color: dashboard_Utils.vi_white
        text: qsTr("CALL")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
    }
    Dashboard_Utils{id: dashboard_Utils}

}

/*##^##
Designer {
    D{i:0;height:134;width:184}
}
##^##*/
