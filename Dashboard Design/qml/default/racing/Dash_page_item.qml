import QtQuick 2.12


import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {

    property int dash_page_value: 0     //0 --> RACE 1,
    //1 --> RACE 2,
    //2 --> QUALI,
    property var dash_page_names: ["RACE 1", "RACE 2", "RACE 3", "RACE MAP", "RACE EV"]

    property double weather_value: 0     //0 --> DRY,
    //1 --> WET
    property string weather_names: dash_page_item.weather_value < 0.2 ? "DRY" : "WET"

    property bool low_beam_value: true
    property bool high_beam_value: true
    property bool esp_on: true
    property bool hill_hold_on: true

    id: dash_page_item
    width: parent.width*3/4/2
    height: parent.height/7

    Text {
        id: dash_page_text
        width: 145
        height: 68
        color: dashboard_Utils.vi_red
        text: dash_page_item.dash_page_names[dash_page_item.dash_page_value]
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 30
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignBottom
        bottomPadding: 10
        leftPadding: 10
        layer.smooth: true
        anchors.horizontalCenterOffset: -110
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
    }

    Text {
        id: weather_text
        width: 85
        height: 68
        color: dashboard_Utils.vi_white
        text: dash_page_item.weather_names
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignBottom
        anchors.verticalCenterOffset: 0
        font.bold: true
        font.family: "Sansation"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        bottomPadding: 10
        anchors.horizontalCenterOffset: 11
    }

    Row {
        id: row
        width: 149
        height: 77
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 1
        anchors.horizontalCenterOffset: 118
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: low_beam_image
            width: 50
            opacity: dash_page_item.low_beam_value
            anchors.verticalCenter: parent.verticalCenter
            source: "images/low_beam.png"
            antialiasing: true
            mipmap: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: high_beam_image
            opacity: dash_page_item.high_beam_value
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            source: "images/high_beam.png"
            mipmap: true
            antialiasing: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: esp_image
            width: 50
            opacity: dash_page_item.esp_on
            anchors.verticalCenter: parent.verticalCenter
            source: "images/esp.png"
            mipmap: true
            antialiasing: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: hill_hold_image
            width: 50
            opacity: dash_page_item.hill_hold_on
            anchors.verticalCenter: parent.verticalCenter
            source: "images/hill_hold.png"
            mipmap: true
            antialiasing: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Dashboard_Utils{
        id: dashboard_Utils
    }



}

/*##^##
Designer {
    D{i:0;height:75.71428571428571;width:384}
}
##^##*/
