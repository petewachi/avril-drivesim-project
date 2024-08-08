import QtQuick 2.12
import "../../../qml/default/default_db"

Item {
    id: adas_item
    width: 1080
    height: 1150

    property bool acc_activity_value: false
    property bool ldw_activity_value: false
    property bool lka_activity_value: false
    property bool ap_activity_value: false
    property bool aeb_activity_value: false

    property string acc_activity_rtdb: ""
    property string ldw_activity_rtdb: ""
    property string lka_activity_rtdb: ""
    property string ap_activity_rtdb: ""
    property string aeb_activity_rtdb: ""

    //adas mode
    property double adas_mode_value: 1
    property string adas_mode_rtdb: ""


    //draggable item to switch root state

    Dragger_item{
        stateOnLeft: "home"
        stateOnRight: "controls"
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
        id: adas_text
        width: 1081
        height: 200
        color: dashboard_Utils.vi_white
        text: qsTr("ADAS activity")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
        anchors.verticalCenterOffset: -400
        anchors.horizontalCenter: parent.horizontalCenter
    }

    //button that gets the dashboard to home state
    Item {
        id: adas_act_item
        width: 1080
        height: 800
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 140
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter


        Button_item_mouse {
            id: acc_activity_button
            width: 364
            height: 340
            scale: 0.3
            anchors.verticalCenterOffset: -parent.height*0.8/5*2
            anchors.horizontalCenterOffset: -384
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            button_icon_value: "images/speed-ACC.png"
            button_background_color_value: value ? dashboard_Utils.vi_green : dashboard_Utils.vi_white
            value: adas_item.acc_activity_value
            value_rtdb: adas_item.acc_activity_rtdb

            Text {
                id: acc_activity
                width: 2480
                height: 340
                color: dashboard_Utils.vi_white
                text: qsTr("ACC (Adaptive Cruise Control)")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 150
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenterOffset: parent.pressed ? 1727/0.9 :1727
                scale: parent.pressed ? 1/0.9 : 1
                anchors.verticalCenterOffset: 0
                font.family: "Sansation"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Button_item_mouse {
            id: ldw_activity_button
            width: 364
            height: 340
            button_background_color_value: value ? dashboard_Utils.vi_green : dashboard_Utils.vi_white
            button_icon_value: "images/ldw_icon.png"
            anchors.horizontalCenterOffset: -384
            anchors.verticalCenterOffset: -parent.height*0.8/5
            anchors.verticalCenter: parent.verticalCenter
            button_icon_scale_value: 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            scale: 0.3
            value: adas_item.ldw_activity_value
            value_rtdb: adas_item.ldw_activity_rtdb

            Text {
                id: ldw_activity
                width: 2480
                height: 340
                color: dashboard_Utils.vi_white
                text: qsTr("LDW (Lane Departure Warning)")
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



        Button_item_mouse {
            id: lka_activity_button
            width: 364
            height: 340
            button_background_color_value: value ? dashboard_Utils.vi_green : dashboard_Utils.vi_white
            button_icon_value: "images/lka_on_icon.png"
            anchors.horizontalCenterOffset: -384
            anchors.verticalCenterOffset: parent.height*0.8/5*0
            anchors.verticalCenter: parent.verticalCenter
            button_icon_scale_value: 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            scale: 0.3
            value: adas_item.lka_activity_value
            value_rtdb: adas_item.lka_activity_rtdb

            Text {
                id: lka_activity
                width: 2480
                height: 340
                color: dashboard_Utils.vi_white
                text: qsTr("LKA (Lane Keeping Assist)")
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

        Button_item_mouse {
            id: ap_activity_button
            width: 364
            height: 340
            button_background_color_value: value ? dashboard_Utils.vi_green : dashboard_Utils.vi_white
            anchors.horizontalCenterOffset: -384
            button_icon_value: "images/ap_icon.png"
            anchors.verticalCenterOffset: parent.height*0.8/5*1
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            scale: 0.3
            value: adas_item.ap_activity_value
            value_rtdb: adas_item.ap_activity_rtdb

            Text {
                id: ap_activity
                width: 2480
                height: 340
                color: dashboard_Utils.vi_white
                text: qsTr("Auto - Pilot")
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


        Button_item_mouse {
            id: aeb_activity_button
            width: 364
            height: 340
            button_background_color_value: value ? dashboard_Utils.vi_green : dashboard_Utils.vi_white
            button_icon_value: "images/aeb_white.png"
            anchors.horizontalCenterOffset: -384
            anchors.verticalCenterOffset: parent.height*0.8/5*2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            scale: 0.3
            value: adas_item.aeb_activity_value
            value_rtdb: adas_item.aeb_activity_rtdb

            Text {
                id: aeb_activity
                width: 2480
                height: 340
                color: dashboard_Utils.vi_white
                text: qsTr("AEB (Automatic Emergency Brake)")
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
            id: com_sport_mode
            width: 1080
            height: 200
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -404
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter

//            Text {
//                id: mode_text
//                width: 189
//                height: 112
//                color: "#007db0"
//                text: qsTr("mode")
//                anchors.verticalCenter: parent.verticalCenter
//                font.pixelSize: 50
//                horizontalAlignment: Text.AlignHCenter
//                verticalAlignment: Text.AlignVCenter
//                anchors.verticalCenterOffset: -59
//                anchors.horizontalCenterOffset: 0
//                font.family: "Sansation"
//                anchors.horizontalCenter: parent.horizontalCenter
//            }

            Rectangle {
                id: comfort_mode
                width: 200
                height: 83
                color: dashboard_Utils.vi_transparent
                radius: width/20
                border.color: adas_item.adas_mode_value === 1 ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_grey
                border.width: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 17
                anchors.horizontalCenterOffset: -111
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: comfort_text
                    color: dashboard_Utils.vi_white
                    text: qsTr("comfort")
                    anchors.fill: parent
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Sansation"
                }
                MouseArea{
                    id:comfort_mousearea
                    anchors.fill: parent
                    onPressed: {
                        parent.scale = 0.9
                    }
                    onReleased: {
                        parent.scale = 1
                        viclass.setChannelValue(adas_item.adas_mode_rtdb, 1)
                    }
                }
            }

            Rectangle {
                id: sport_mode
                width: 200
                height: 83
                color: dashboard_Utils.vi_transparent
                radius: width/20
                border.color: adas_item.adas_mode_value === 2 ? dashboard_Utils.vi_acid_green : dashboard_Utils.vi_grey
                border.width: 5
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: sport_text
                    color: dashboard_Utils.vi_white
                    text: qsTr("aggressive")
                    anchors.fill: parent
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Sansation"
                }
                MouseArea{
                    id:sport_mousearea
                    anchors.fill: parent
                    onPressed: {
                        parent.scale = 0.9
                    }
                    onReleased: {
                        parent.scale = 1
                        viclass.setChannelValue(adas_item.adas_mode_rtdb, 2)
                    }
                }
                anchors.horizontalCenterOffset: 111
                anchors.verticalCenterOffset: 17
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

    }

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
