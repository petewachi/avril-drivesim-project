import QtQuick 2.12
import "../../../qml/default/default_db"


MouseArea{
    //this is syncing the 2 temperature
    property color sync_color_value: dashboard_Utils.vi_azure
    property double temperature_left_value
    property double temperature_right_value
    id: sync
    //enabled only when they are different
    enabled: sync.temperature_left_value !== sync.temperature_right_value
    opacity: (sync.enabled) ? 1 : 0.2
    width: 200
    height: 120
    onPressed: {
        sync.scale = 0.8
    }
    onReleased: {
        sync.scale = 1
    }

    Text {
        id: sync_text
        color: sync.sync_color_value
        text: qsTr("SYNC")
        anchors.fill: parent
        font.pixelSize: 50
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
    }



    Dashboard_Utils{id: dashboard_Utils}

}
