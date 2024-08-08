import QtQuick 2.12
import "../../../qml/default/default_db"

Item {
    id: radio_item
    //in this component you can:
    //  1. FM/DAB switch
    //  2. up/down stations
    //  3. select station from List

    property double radio_type: 1
    property var radio_types: {
        1 : "FM",
        2 : "DAB"
    }
    property bool radio_sound: false

    //this is used to switch between 2 sound
    property int station_number: radio_station_listview.currentIndex % 2
    width: 1080
    height: 1150


    //drag and pass to another root state
    Dragger_item{
        stateOnLeft: "climate"
        stateOnRight: "phone"
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
        id: radio_text
        width: 1080
        height: 200
        color: dashboard_Utils.vi_white
        text: qsTr("RADIO")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
        anchors.verticalCenterOffset: -400
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button_item_mouse {
        id: radio_FM_item_mouse
        width: 200
        height: 200
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        button_icon_value: "images/radio_FM_icon.png"
        anchors.verticalCenterOffset: -150
        anchors.horizontalCenterOffset: -430
        button_background_color_value: value ? dashboard_Utils.vi_azure : dashboard_Utils.vi_transparent
        onReleased: {
            radio_item.radio_type = 1
            radio_DAB_item_mouse.value = (radio_item.radio_type === 2)
            radio_FM_item_mouse.value = (radio_item.radio_type === 1)
        }
        value: radio_item.radio_type === 1
    }

    Button_item_mouse {
        id: radio_DAB_item_mouse
        width: 200
        height: 200
        button_icon_value: "images/radio_DAB_icon.png"
        anchors.horizontalCenterOffset: -430
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 50
        button_background_color_value: value ? dashboard_Utils.vi_azure : dashboard_Utils.vi_transparent
        onReleased: {
            radio_item.radio_type = 2
            radio_DAB_item_mouse.value = (radio_item.radio_type === 2)
            radio_FM_item_mouse.value = (radio_item.radio_type === 1)
        }
        value: radio_item.radio_type === 2
    }


    Image {
        id: radio_on_off
        width: 100
        height: 100
        anchors.verticalCenter: parent.verticalCenter
        source: radio_item.radio_sound ? "images/on_radio_icon.png":
                                         "images/off_radio_icon.png"
        antialiasing: true
        mipmap: true
        anchors.verticalCenterOffset: -400
        anchors.horizontalCenterOffset: -430
        anchors.horizontalCenter: parent.horizontalCenter
        MouseArea{
            id: radio_on_off_mousearea
            anchors.fill: parent
            onReleased: {
                radio_item.radio_sound = !radio_item.radio_sound
            }
        }
    }

    Item {
        id: radio_stations_slider_item
        //get current name and frequency of the list selected
        property double radio_frequency: radio_FM_list_model.get(radio_station_listview.currentIndex).frequency
        property string radio_name: radio_FM_list_model.get(radio_station_listview.currentIndex).name
        x: 234
        width: 775
        height: 480
        anchors.verticalCenter: parent.verticalCenter
        clip: true
        anchors.horizontalCenterOffset: 82
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0

        Rectangle {
            id: rectangle
            radius: 50
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: dashboard_Utils.vi_azure
                }

                GradientStop {
                    position: 1
                    color: dashboard_Utils.vi_black
                }
            }
        }

        Button_item_mouse {
            id: minus_button
            width: 150
            height: 150
            anchors.verticalCenterOffset: 162
            anchors.horizontalCenterOffset: -200
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            button_background_color_value: dashboard_Utils.vi_cream
            rotation: 180
            button_icon_value: "images/play_icon.png"
            button_radius_value: 10000
            onReleased: {
                //decrease number on the list but saturate at 0 an list lenght
                radio_station_listview.currentIndex = dashboard_Utils.saturate(radio_station_listview.currentIndex, -1, 0, radio_station_listview.count-1)
            }
        }

        Button_item_mouse {
            id: plus_button
            width: 150
            height: 150
            button_icon_value: "images/play_icon.png"
            anchors.horizontalCenterOffset: 200
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            button_background_color_value: dashboard_Utils.vi_cream
            anchors.verticalCenterOffset: 162
            button_radius_value: 10000
            onReleased: {
                //increase number on the list but saturate at 0 an list lenght
                radio_station_listview.currentIndex = dashboard_Utils.saturate(radio_station_listview.currentIndex, 1, 0, radio_station_listview.count-1)
            }
        }

        Button_item_mouse {
            id: select_button
            width: 240
            height: 150
            anchors.horizontalCenterOffset: 0
            button_icon_value: "images/select_station_icon.png"
            button_background_color_value: dashboard_Utils.vi_cream
            anchors.verticalCenterOffset: 162
            anchors.verticalCenter: parent.verticalCenter
            button_icon_scale_value: 2
            anchors.horizontalCenter: parent.horizontalCenter
            onReleased: {
                //switch to the selection list state
                radio_item.state = "selection"
            }
        }

        Text {
            id: radio_text1
            width: 676
            height: 144
            color: dashboard_Utils.vi_white
            //show the correct name depending on FM or DAB selection
            text: radio_item.radio_type === 1 ? radio_FM_list_model.get(radio_station_listview.currentIndex).name :
                                                radio_DAB_list_model.get(radio_station_listview.currentIndex).name
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenterOffset: -158
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Sansation"
        }

        Text {
            id: radio_text2
            width: 676
            height: 144
            color: dashboard_Utils.vi_white
            //do not show the frequency for DAB radio
            text: radio_item.radio_type === 1 ? radio_FM_list_model.get(radio_station_listview.currentIndex).frequency.toFixed(1) :
                                                ""
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Sansation"
            anchors.verticalCenterOffset: -86
        }

    }

    Flickable{
        id: radio_stations_scroll
        width: 650
        height: 420
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        enabled: false
        anchors.verticalCenterOffset: -30
        anchors.horizontalCenterOffset: 144
        synchronousDrag: true
        boundsMovement: Flickable.StopAtBounds
        boundsBehavior: Flickable.StopAtBounds
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true


        ListModel{
            id: radio_FM_list_model
            ListElement{
                name: "Rai Radio 2"
                frequency: 88.6
            }
            ListElement{
                name: "Rai Radio 1"
                frequency: 91.5
            }
            ListElement{
                name: "m2o"
                frequency: 100.2
            }
            ListElement{
                name: "Radio 105"
                frequency: 105.0
            }
            ListElement{
                name: "BBC Radio 1"
                frequency: 106.3
            }
            ListElement{
                name: "BBC Radio 2"
                frequency: 107.0
            }
        }
        ListModel{
            id: radio_DAB_list_model
            ListElement{
                name: "Rai Radio 2 DAB"
                frequency: 88.6
            }
            ListElement{
                name: "Rai Radio 1  DAB"
                frequency: 91.5
            }
            ListElement{
                name: "m2o  DAB"
                frequency: 100.2
            }
            ListElement{
                name: "Radio 105  DAB"
                frequency: 105.0
            }
            ListElement{
                name: "BBC Radio 1  DAB"
                frequency: 106.3
            }
            ListElement{
                name: "BBC Radio 2  DAB"
                frequency: 107.0
            }
        }

        ListView{
            id: radio_station_listview
            width: radio_stations_scroll.width
            height: radio_stations_scroll.height
            spacing: 10
            snapMode: ListView.SnapToItem
            synchronousDrag: true
            focus: true
            orientation: Qt.Vertical

            model: radio_item.radio_type === 1 ? radio_FM_list_model : radio_DAB_list_model
            delegate: Rectangle {
                id: radio_station_delegate
                width: 650
                height: 100
                color: radio_station_delegate.ListView.isCurrentItem ? dashboard_Utils.vi_petrol :dashboard_Utils.vi_grey
                radius: 20
                MouseArea {
                            anchors.fill: parent
                            onClicked: radio_station_delegate.ListView.view.currentIndex = model.index
                        }

                Rectangle {
                    id: radio_station_image_container
                    x: -2
                    y: -5
                    width: 89
                    height: 84
                    color: dashboard_Utils.vi_transparent
                    radius: 20
                    border.color: dashboard_Utils.vi_cream
                    border.width: 5
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: -272
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: radio_icon
                        x: 0
                        y: 0
                        anchors.verticalCenter: parent.verticalCenter
                        source: "images/radio_icon.png"
                        scale: 0.2
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Text {
                    id: radio_station_number
                    y: 0
                    width: 165
                    height: 100
                    color: dashboard_Utils.vi_white
                    text: radio_item.radio_type === 1 ? frequency.toFixed(1) : ""
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: radio_station_image_container.right
                    font.pixelSize: 50
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    rightPadding: 15
                    font.family: "Open Sans"
                }

                Text {
                    id: radio_station_name
                    y: 0
                    width: 293
                    height: 100
                    color: dashboard_Utils.vi_white
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: radio_station_number.right
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    bottomPadding: 25
                    font.family: "Sansation"
                }

                Rectangle {
                    id: radio_station_play_image_container
                    visible: radio_station_delegate.ListView.isCurrentItem
                    x: 6
                    y: 0
                    width: 84
                    height: 84
                    color: dashboard_Utils.vi_transparent
                    radius: 42
                    border.color: dashboard_Utils.vi_cream
                    border.width: 5
                    anchors.verticalCenter: parent.verticalCenter
                    Image {
                        id: play_icon
                        x: 0
                        y: 0
                        anchors.verticalCenter: parent.verticalCenter
                        source: "images/play_icon.png"
                        scale: 0.2
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
                    }
                    anchors.horizontalCenterOffset: 272
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenterOffset: 0
                }


            }
        }

    }


    Button_item_mouse {
        id: return_item
        enabled: false
        width: 395
        height: 326
        visible: false
        value: radio_item.radio_type === 1
        button_icon_value: "images/return_icon.png"
        scale: 0.3
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -246
        button_background_color_value: dashboard_Utils.vi_cream
        anchors.verticalCenterOffset: -191
        onReleased: {
            radio_item.state = "base"
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

    states: [
        State {
            name: "base"
        },
        State {
            name: "selection"

            PropertyChanges {
                target: return_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: radio_stations_scroll
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: radio_stations_slider_item
                visible: false
                enabled: false
            }
        }
    ]






}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
