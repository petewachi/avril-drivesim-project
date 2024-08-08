import QtQuick 2.12

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {

    property bool control_value: false

    property string control_name_value: "ABS"


    id: controls_item
    width: 100
    height: 100

    Rectangle {
        id: border_controls
        color: controls_item.control_value ? dashboard_Utils.vi_yellow:
                                             dashboard_Utils.vi_black
        radius: 10
        border.color: dashboard_Utils.vi_transparent
        border.width: 6
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
    }


    Text {
        id: text_
        color: dashboard_Utils.vi_grey
        text: controls_item.control_name_value
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 35
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        layer.smooth: true
        width: parent.width
        height:  parent.height
    }




    Dashboard_Utils{id: dashboard_Utils}




}

/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/
