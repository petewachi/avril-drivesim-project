import QtQuick 2.12
import "../../../qml/default/default_db"

Item {
    id: lights_item
    width: 1080
    height: 1150

    property bool highBeamLeft_value: false
    property bool highBeamRight_value: false
    property bool lowBeamLeft_value: false
    property bool lowBeamRight_value: false

    property string highBeamLeft_rtdb: ""
    property string highBeamRight_rtdb: ""
    property string lowBeamLeft_rtdb: ""
    property string lowBeamRight_rtdb: ""

    property bool lights_switch_value: false
    property string lights_switch_rtdb: ""

    //draggable item to switch root state

    Dragger_item{
        stateOnLeft: "controls"
        stateOnRight: "climate"
    }

//    onLowBeamLeft_valueChanged: {
//        viclass.setChannelValue(lights_item.lowBeamRight_rtdb, lights_item.lowBeamLeft_value)
//    }
//    onHighBeamLeft_valueChanged: {
//        viclass.setChannelValue(lights_item.highBeamRight_rtdb, lights_item.highBeamLeft_value)
//    }


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
        id: lights_text
        width: 1081
        height: 200
        color: dashboard_Utils.vi_white
        text: qsTr("HEADLAMPS")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Sansation"
        anchors.verticalCenterOffset: -400
    }

    Item {
        id: headlamps_item
        width: 1080
        height: 800
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 140
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter


        Button_item_mouse {
            id: low_beams_button
            width: 364
            height: 340
            opacity: !lights_item.lights_switch_value ? 1 : 0.5
            enabled: !lights_item.lights_switch_value ? true : false
            anchors.verticalCenterOffset: -94
            scale: 0.3
            anchors.horizontalCenterOffset: -384
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            button_icon_value: "images/low_beam.png"
            button_background_color_value: lights_item.lowBeamLeft_value ? dashboard_Utils.vi_green : dashboard_Utils.vi_white
            value: lights_item.lowBeamLeft_value
            value_rtdb: lights_item.lowBeamLeft_rtdb
            onReleased: {
                viclass.setChannelValue(lights_item.lowBeamRight_rtdb, !low_beams_button.value)
            }

            Text {
                id: low_beams_activity
                width: 2480
                height: 340
                color: dashboard_Utils.vi_white
                text: qsTr("Low beams")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 150
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 0                
                anchors.horizontalCenterOffset: parent.pressed ? 1727/0.9 :1727
                scale: parent.pressed ? 1/0.9 : 1
                font.family: "Sansation"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Button_item_mouse {
            id: high_beams_button
            width: 364
            height: 340
            opacity: !lights_item.lights_switch_value? 1 : 0.5
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: !lights_item.lights_switch_value? true : false
            anchors.verticalCenterOffset: 34
            button_background_color_value: lights_item.highBeamLeft_value ? dashboard_Utils.vi_green : dashboard_Utils.vi_white
            button_icon_value: "images/high_beam.png"
            anchors.horizontalCenterOffset: -384
            scale: 0.3
            value: lights_item.highBeamLeft_value
            value_rtdb: lights_item.highBeamLeft_rtdb
            onReleased: {
                viclass.setChannelValue(lights_item.highBeamRight_rtdb, !high_beams_button.value)
            }

            Text {
                id: high_beams_activity
                width: 2480
                height: 340
                color: dashboard_Utils.vi_white
                text: qsTr("High Beams")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 150
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Sansation"
                anchors.horizontalCenter: parent.horizontalCenter                
                anchors.horizontalCenterOffset: parent.pressed ? 1727/0.9 :1727
                scale: parent.pressed ? 1/0.9 : 1
                anchors.verticalCenterOffset: 0
            }
        }




        Item {
            id: man_auto_mode
            width: 1080
            height: 200
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -348
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter


            Rectangle {
                id: manual_mode
                width: 200
                height: 83
                color: dashboard_Utils.vi_transparent
                radius: width/20
                border.color: !lights_item.lights_switch_value? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_grey
                border.width: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 17
                anchors.horizontalCenterOffset: -111
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: manual_text
                    color: dashboard_Utils.vi_white
                    text: qsTr("manual")
                    anchors.fill: parent
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Sansation"
                }
                MouseArea{
                    id:manual_mousearea
                    anchors.fill: parent
                    onPressed: {
                        parent.scale = 0.9
                    }
                    onReleased: {
                        parent.scale = 1
                        viclass.setChannelValue(lights_item.lights_switch_rtdb, !lights_item.lights_switch_value)
                    }
                }
            }

            Rectangle {
                id: automatic_mode
                width: 200
                height: 83
                color: dashboard_Utils.vi_transparent
                radius: width/20
                border.color: lights_item.lights_switch_value? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_grey
                border.width: 5
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: automatic_text
                    color: dashboard_Utils.vi_white
                    text: qsTr("automatic")
                    anchors.fill: parent
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Sansation"
                }
                MouseArea{
                    id:automatic_mousearea
                    anchors.fill: parent
                    onPressed: {
                        parent.scale = 0.9
                    }
                    onReleased: {
                        parent.scale = 1
                        viclass.setChannelValue(lights_item.lights_switch_rtdb, !lights_item.lights_switch_value)
                    }
                }
                anchors.horizontalCenterOffset: 111
                anchors.verticalCenterOffset: 17
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

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
    D{i:0;formeditorZoom:0.5;height:1032;width:1080}
}
##^##*/
