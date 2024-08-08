import QtQuick 2.12



Item {
    id: increment_component
    property double value: 1
    property double value_increment: 0.1
    property double value_min: 0.1
    property double value_max: 5
    property string value_name: "front"
    property string value_RTDB: ""
    width: 200
    height: 564
    scale: dashboard_Utils.resize_content(width, height, 200, 564)
    Rectangle {
        id: rectangle_plus
        width: 104
        height: 94
        color: dashboard_Utils.vi_transparent
        radius: width/20
        border.color: dashboard_Utils.vi_white
        border.width: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -170
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: plus_text
            width: 105
            height: 96
            color: dashboard_Utils.vi_cream
            text: "+"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 70
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Open Sans"
        }
        MouseArea{
            id: plus_mouseArea
            anchors.fill: parent
            onPressed: {
                parent.scale = 0.9
            }
            onReleased: {
                parent.scale = 1
                viclass.setChannelValue(increment_component.value_RTDB,
                                        dashboard_Utils.saturate(increment_component.value, increment_component.value_increment,
                                                                 increment_component.value_min,increment_component.value_max))
            }
        }
    }

    Rectangle {
        id: rectangle_value
        width: 150
        height: 94
        color: dashboard_Utils.vi_transparent
        radius: width/20
        border.color: dashboard_Utils.vi_white
        border.width: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: value_text
            width: 105
            height: 96
            color: dashboard_Utils.vi_cream
            text: increment_component.value.toFixed(2)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 55
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Open Sans"
        }
    }


    Text {
        id: label_text
        width: 160
        height: 96
        color: dashboard_Utils.vi_cream
        text: increment_component.value_name
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 34
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenterOffset: 0
        font.italic: true
        anchors.verticalCenterOffset: 85
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: false
        font.family: "Open Sans"
    }

    Rectangle {
        id: rectangle_minus
        width: 104
        height: 94
        color: dashboard_Utils.vi_transparent
        radius: width/20
        border.color: dashboard_Utils.vi_white
        border.width: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 0
        Text {
            id: minus_text
            width: 105
            height: 96
            color: dashboard_Utils.vi_cream
            text: "-"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 70
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Open Sans"
        }

        MouseArea {
            id: minus_mouseArea
            anchors.fill: parent
            onPressed: {
                parent.scale = 0.9
            }
            onReleased: {
                parent.scale = 1
                viclass.setChannelValue(increment_component.value_RTDB,
                                        dashboard_Utils.saturate(increment_component.value, -increment_component.value_increment,
                                                                 increment_component.value_min,increment_component.value_max))
            }
        }
        anchors.verticalCenterOffset: 170
    }

    Dashboard_Utils{id: dashboard_Utils}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
