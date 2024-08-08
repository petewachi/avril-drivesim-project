import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"



Item {
    property double soc_value: 75
    property double soc_red_value: 10
    property double soc_yellow_value: 20
    property alias soc_text_Visible: soc_text_.visible
    width: 780
    height: 40
    id: battery_item

    Rectangle {
        id: battery_background
        color: dashboard_Utils.vi_grey
        anchors.fill: parent
    }

    Rectangle {
        id: battery_level
        color: (battery_item.soc_value < battery_item.soc_red_value)    ?   dashboard_Utils.vi_red      :
               (battery_item.soc_value < battery_item.soc_yellow_value) ?   dashboard_Utils.vi_yellow   :
                                                                            dashboard_Utils.vi_green
        anchors.fill: parent
        anchors.topMargin: 2
        anchors.rightMargin: (parent.width-2)*(100 - battery_item.soc_value)/100
        anchors.bottomMargin: 2
        anchors.leftMargin: 2
    }
    Text {
        id: soc_text_
        text: "   " + dashboard_Utils.saturation(battery_item.soc_value.toFixed(0),0,100)  + " %"
        anchors.fill: parent
        font.pixelSize: 30
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        font.family: "Open Sans"
    }

    Dashboard_Utils{id: dashboard_Utils}

}


/*##^##
Designer {
    D{i:0;height:42;width:641}
}
##^##*/
