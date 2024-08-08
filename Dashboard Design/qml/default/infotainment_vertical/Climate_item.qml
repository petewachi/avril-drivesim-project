import QtQuick 2.12
import "../../../qml/default/default_db"

Item {
    id: climate_item
    width: 1080
    height: 1150

    //this component has different
    property double temperature_left: 20
    property double temperature_right: 20

    //draggable item to switch root state
    Dragger_item{
        stateOnLeft: "controls"
        stateOnRight: "radio"
    }


    Rectangle {
        id: adas_background
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: dashboard_Utils.vi_transparent
            }
            GradientStop {
                position: 0.001
                color: dashboard_Utils.vi_black
            }
            GradientStop {
                position: 0.85
                color: dashboard_Utils.vi_black
            }
            GradientStop {
                position: 1
                color: dashboard_Utils.vi_transparent
            }
            orientation: Gradient.Horizontal
        }
    }

    Text {
        id: climate_text
        width: 1081
        height: 200
        color: dashboard_Utils.vi_white
        text: qsTr("CLIMATE")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
        anchors.verticalCenterOffset: -400
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Temperature_item {
        id: temperature_left_item
        width: 340
        height: 120
        anchors.verticalCenterOffset: -250
        anchors.horizontalCenterOffset: -300
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        temperature_value: climate_item.temperature_left
        onTemperature_valueChanged: {
            //set actual teperature value + the reference on the sync
            climate_item.temperature_left = temperature_value
            sync.temperature_left_value = climate_item.temperature_left
        }
    }
    Sync {
        id: sync
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -250
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 0
        temperature_left_value: climate_item.temperature_left
        temperature_right_value: climate_item.temperature_right
        onReleased: {
            //set the passenger right temp to the left value
            temperature_right_item.temperature_value = climate_item.temperature_left
        }
    }


    Temperature_item {
        id: temperature_right_item
        width: 340
        anchors.verticalCenterOffset: -250
        anchors.horizontalCenterOffset: 300
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        temperature_value: climate_item.temperature_right
        onTemperature_valueChanged: {
            //set actual teperature value + the reference on the sync
            climate_item.temperature_right = temperature_value
            sync.temperature_right_value = climate_item.temperature_right
        }
    }


    Venting_item {
        id: venting_item
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        //disable venting manual when automatic is active
        enabled: !auto_ac_item_mouse.value
        opacity: auto_ac_item_mouse.value ? 0.6 : 1
    }

    //buttons for A/C, recycle and position of venting
    Button_item_mouse {
        id: auto_ac_item_mouse
        width: 364
        height: 340
        button_background_color_value: auto_ac_item_mouse.value ? dashboard_Utils.vi_azure : dashboard_Utils.vi_transparent
        button_icon_value: "images/auto_ac_icon.png"
        anchors.verticalCenterOffset: 226
        anchors.horizontalCenterOffset: -300
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        scale: 0.3
    }

    Button_item_mouse {
        id: vent_up_item_mouse
        enabled: !auto_ac_item_mouse.value
        opacity: auto_ac_item_mouse.value ? 0.6 : 1
        width: 364
        height: 340
        button_icon_value: "images/vent_up_icon.png"
        scale: 0.3
        anchors.horizontalCenterOffset: -150
        anchors.verticalCenterOffset: 226
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        button_background_color_value: vent_up_item_mouse.value ? dashboard_Utils.vi_azure : dashboard_Utils.vi_transparent
    }

    Button_item_mouse {
        id: vent_down_item_mouse
        enabled: !auto_ac_item_mouse.value
        opacity: auto_ac_item_mouse.value ? 0.6 : 1
        width: 364
        height: 340
        button_icon_value: "images/vent_down_icon.png"
        anchors.horizontalCenterOffset: 0
        scale: 0.3
        anchors.verticalCenterOffset: 226
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        button_background_color_value: vent_down_item_mouse.value ? dashboard_Utils.vi_azure : dashboard_Utils.vi_transparent
    }

    Button_item_mouse {
        id: windshield_item_mouse
        enabled: !auto_ac_item_mouse.value
        opacity: auto_ac_item_mouse.value ? 0.6 : 1
        width: 364
        height: 340
        button_icon_value: "images/windshield_icon.png"
        anchors.horizontalCenterOffset: 150
        scale: 0.3
        button_background_color_value: windshield_item_mouse.value ? dashboard_Utils.vi_azure : dashboard_Utils.vi_transparent
        anchors.verticalCenterOffset: 226
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
    }

    Button_item_mouse {
        id: recycle_item_mouse
        width: 364
        height: 340
        button_icon_value: "images/recycle_icon.png"
        scale: 0.3
        anchors.horizontalCenterOffset: 300
        button_background_color_value: recycle_item_mouse.value ? dashboard_Utils.vi_azure : dashboard_Utils.vi_transparent
        anchors.verticalCenterOffset: 226
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
    }

    //button that gets the dashboard to home state
    Button_item_mouse {
        id: exit_to_home
        width: 150
        height: 150
        button_icon_value: "images/home_icon.png"
        button_background_color_value: dashboard_Utils.vi_red
        anchors.verticalCenterOffset: 500
        anchors.verticalCenter: parent.verticalCenter
        button_icon_scale_value: 2
        anchors.horizontalCenter: parent.horizontalCenter
        onReleased: {
            root.state = "home"
        }
    }
    Dashboard_Utils{id: dashboard_Utils}


}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.33;height:1032;width:1080}
}
##^##*/
