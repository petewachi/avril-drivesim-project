import QtQuick 2.12
import "../../../qml/default/default_db"


Item {
    id: temperature_item


    property double temperature_value: 20
    property double temperature_step: 0.5
    width: 460
    height: 120

    Item {
        id: temp_text_item
        anchors.fill: parent
        anchors.leftMargin: parent.width/4
        anchors.rightMargin: parent.width/4

        Text {
            id: temp_text
            color: dashboard_Utils.vi_white
            text: dashboard_Utils.num_unsign_to_string_precision(temperature_item.temperature_value, 1)
            anchors.fill: parent
            font.pixelSize: 50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.family: "Open Sans"
        }
    }

    MouseArea {
        id: minus_temp_text_item
        anchors.fill: parent
        anchors.rightMargin: parent.width/2*1.5
        onReleased: {
            temperature_item.temperature_value = temperature_item.temperature_value - temperature_item.temperature_step
        }

        Text {
            id: minus_temp_text
            color: dashboard_Utils.vi_white
            text: "-"
            anchors.fill: parent
            font.pixelSize: 100
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            bottomPadding: 10
            font.family: "Open Sans"
        }
    }

    MouseArea {
        id: plus_temp_text_item
        anchors.fill: parent
        anchors.leftMargin: parent.width/2*1.5
        onReleased: {
            temperature_item.temperature_value = temperature_item.temperature_value + temperature_item.temperature_step
        }

        Text {
            id: plus_temp_text
            color: dashboard_Utils.vi_white
            text: "+"
            anchors.fill: parent
            font.pixelSize: 100
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            bottomPadding: 10
            font.family: "Open Sans"
        }
    }

    Dashboard_Utils{id: dashboard_Utils}
}
