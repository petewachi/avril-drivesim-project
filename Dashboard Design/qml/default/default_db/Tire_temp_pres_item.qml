import QtQuick 2.12


Item {

    property double tire_temp_FL_value: 85               //front left
    property double tire_temp_FR_value: 85               //front right
    property double tire_temp_RL_value: 85               //rear left
    property double tire_temp_RR_value: 85               //rear right

    property double tire_temp_low_value: 65               //low temp value
    property double tire_temp_high_value: 100               //high temp value

    property int tire_temp_precision_value: 1               //temperature precision

    property double tire_pres_FL_value: 1.5               //front left
    property double tire_pres_FR_value: 1.5               //front right
    property double tire_pres_RL_value: 1.5               //rear left
    property double tire_pres_RR_value: 1.5               //rear right

    property double tire_pres_low_value: 1.3               //low pressure value
    property double tire_pres_high_value: 2               //high pressure value

    property int tire_pres_precision_value: 1               //pressure precision

    property alias rectangleColor: rectangle.color

    id: tire_temp_pres_item
    width: 800
    height: 270
    Rectangle {
        id: rectangle
        color: dashboard_Utils.vi_transparent
        radius: width/20
        anchors.fill: parent
    }

    Item {
        id: tire_temp_item
        width: parent.width/2
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -parent.width/4
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: tire_temp_text
            color: dashboard_Utils.vi_white
            text: "TEMP"
            anchors.fill: parent
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
        }

        Text {
            id: tire_temp_fl_value
            width: parent.width/2
            height: parent.height/2
            color: dashboard_Utils.three_way_color(tire_temp_pres_item.tire_temp_FL_value,
                                                   tire_temp_pres_item.tire_temp_low_value,
                                                   tire_temp_pres_item.tire_temp_high_value)
            text: dashboard_Utils.num_unsign_to_string_precision(tire_temp_pres_item.tire_temp_FL_value,
                                                                 tire_temp_pres_item.tire_temp_precision_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: -parent.height/4
            anchors.horizontalCenterOffset: -parent.width/4
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Open Sans"
        }

        Text {
            id: tire_temp_fr_value
            width: parent.width/2
            height: parent.height/2
            color: dashboard_Utils.three_way_color(tire_temp_pres_item.tire_temp_FR_value,
                                                   tire_temp_pres_item.tire_temp_low_value,
                                                   tire_temp_pres_item.tire_temp_high_value)
            text: dashboard_Utils.num_unsign_to_string_precision(tire_temp_pres_item.tire_temp_FR_value,
                                                                 tire_temp_pres_item.tire_temp_precision_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Open Sans"
            anchors.verticalCenterOffset: -parent.height/4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: parent.width/4
        }

        Text {
            id: tire_temp_rl_value
            width: parent.width/2
            height: parent.height/2
            color: dashboard_Utils.three_way_color(tire_temp_pres_item.tire_temp_RL_value,
                                                   tire_temp_pres_item.tire_temp_low_value,
                                                   tire_temp_pres_item.tire_temp_high_value)
            text: dashboard_Utils.num_unsign_to_string_precision(tire_temp_pres_item.tire_temp_RL_value,
                                                                 tire_temp_pres_item.tire_temp_precision_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Open Sans"
            anchors.verticalCenterOffset: parent.height/4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -parent.width/4
        }

        Text {
            id: tire_temp_rr_value
            width: parent.width/2
            height: parent.height/2
            color: dashboard_Utils.three_way_color(tire_temp_pres_item.tire_temp_RR_value,
                                                   tire_temp_pres_item.tire_temp_low_value,
                                                   tire_temp_pres_item.tire_temp_high_value)
            text: dashboard_Utils.num_unsign_to_string_precision(tire_temp_pres_item.tire_temp_RR_value,
                                                                 tire_temp_pres_item.tire_temp_precision_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Open Sans"
            anchors.verticalCenterOffset: parent.height/4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: parent.width/4
        }
    }



    Item {
        id: tire_pres_item
        width: parent.width/2
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: tire_pres_text
            color: dashboard_Utils.vi_white
            text: "PRES"
            anchors.fill: parent
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
        }

        Text {
            id: tire_pres_fl_value
            width: parent.width/2
            height: parent.height/2
            color: dashboard_Utils.three_way_color(tire_temp_pres_item.tire_pres_FL_value,
                                                   tire_temp_pres_item.tire_pres_low_value,
                                                   tire_temp_pres_item.tire_pres_high_value)
            text: dashboard_Utils.num_unsign_to_string_precision(tire_temp_pres_item.tire_pres_FL_value,
                                                                 tire_temp_pres_item.tire_pres_precision_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Open Sans"
            anchors.verticalCenterOffset: -parent.height/4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -parent.width/4
        }

        Text {
            id: tire_pres_fr_value
            width: parent.width/2
            height: parent.height/2
            color: dashboard_Utils.three_way_color(tire_temp_pres_item.tire_pres_FR_value,
                                                   tire_temp_pres_item.tire_pres_low_value,
                                                   tire_temp_pres_item.tire_pres_high_value)
            text: dashboard_Utils.num_unsign_to_string_precision(tire_temp_pres_item.tire_pres_FR_value,
                                                                 tire_temp_pres_item.tire_pres_precision_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Open Sans"
            anchors.verticalCenterOffset: -parent.height/4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: parent.width/4
        }

        Text {
            id: tire_pres_rl_value
            width: parent.width/2
            height: parent.height/2
            color: dashboard_Utils.three_way_color(tire_temp_pres_item.tire_pres_RL_value,
                                                   tire_temp_pres_item.tire_pres_low_value,
                                                   tire_temp_pres_item.tire_pres_high_value)
            text: dashboard_Utils.num_unsign_to_string_precision(tire_temp_pres_item.tire_pres_RL_value,
                                                                 tire_temp_pres_item.tire_pres_precision_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Open Sans"
            anchors.verticalCenterOffset: parent.height/4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -parent.width/4
        }

        Text {
            id: tire_pres_rr_value
            width: parent.width/2
            height: parent.height/2
            color: dashboard_Utils.three_way_color(tire_temp_pres_item.tire_pres_RR_value,
                                                   tire_temp_pres_item.tire_pres_low_value,
                                                   tire_temp_pres_item.tire_pres_high_value)
            text: dashboard_Utils.num_unsign_to_string_precision(tire_temp_pres_item.tire_pres_RR_value,
                                                                 tire_temp_pres_item.tire_pres_precision_value)
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Open Sans"
            anchors.verticalCenterOffset: parent.height/4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: parent.width/4
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: parent.width/4
    }

    Dashboard_Utils{id: dashboard_Utils}


}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
