import QtQuick 2.12
import "../../../qml/default/default_db"

Item {
    id: phone_item
    //number to show on the dial
    property string number_composed: ""
    //name that can match number in the phonebook
    property string name_composed: ""

    property var phonebook: [
        {number: 2812853849, name: "Andreas"},
        {number: 6018619571, name: "Peter"},
        {number: 4695003909, name: "Azzurra"},
        {number: 4084754037, name: "Rossella"},
        {number: 6312847540, name: "Giuseppe"},
        {number: 4067778339, name: "Tom"},
        {number: 7727667420, name: "Christina"},
        {number: 6076871997, name: "Taylor"}
    ]

    width: 1080
    height: 1150
    visible: true
    enabled: true


    Dragger_item{
        stateOnLeft: "radio"
        stateOnRight: "simple_navigator"
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
        id: phone_text
        width: 1081
        height: 200
        color: dashboard_Utils.vi_white
        text: qsTr("PHONE")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 100
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Sansation"
        anchors.verticalCenterOffset: -400
        anchors.horizontalCenter: parent.horizontalCenter
    }


    Item {
        id: phone_keyboard_item
        antialiasing: true
        width: 668
        height: 696
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            id: text_number_item
            width: 668
            height: 128
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -284
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: text_number
                width: 475
                height: 112
                color: dashboard_Utils.vi_cream
                text: phone_item.number_composed
                elide: Text.ElideLeft
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 60
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Open Sans"
            }

            Image {
                //this is used to erase the last digit from the number composed
                id: delete_icon
                x: 168
                y: 0
                width: 118
                height: 112
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                source: "images/delete_icon.png"
                fillMode: Image.PreserveAspectFit
                MouseArea{
                    id: delete_number_mousearea
                    anchors.fill: parent
                    onReleased: phone_item.number_composed = phone_item.number_composed.slice(0, -1)
                }
            }
        }

        Item {
            id: keys_item
            width: 560
            height: 712
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 116
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            //for each of the key tha tis pressend, a number digit is added to the number_composed variable to show on dial

            Key_mouse_area {
                id: key_mouse_1
                number_key: 1
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -248
                anchors.horizontalCenterOffset: -170
                anchors.horizontalCenter: parent.horizontalCenter
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_2
                number_key: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: 0
                anchors.verticalCenterOffset: -248
                anchors.horizontalCenter: parent.horizontalCenter
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_3
                number_key: 3
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: 170
                anchors.verticalCenterOffset: -248
                anchors.horizontalCenter: parent.horizontalCenter
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_4
                number_key: 4
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -78
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -170
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_5
                number_key: 5
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: 0
                anchors.verticalCenterOffset: -78
                anchors.horizontalCenter: parent.horizontalCenter
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_6
                number_key: 6
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -78
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 170
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_7
                number_key: 7
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 92
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -170
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_8
                number_key: 8
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: 0
                anchors.verticalCenterOffset: 92
                anchors.horizontalCenter: parent.horizontalCenter
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_9
                number_key: 9
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 92
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 170
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }

            Key_mouse_area {
                id: key_mouse_0
                number_key: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: 0
                anchors.verticalCenterOffset: 258
                anchors.horizontalCenter: parent.horizontalCenter
                onReleased: {
                    phone_item.number_composed = phone_item.number_composed.concat(number_key)
                }
            }
        }
    }

    Item {
        id: call_drop_item
        antialiasing: true
        width: 200
        height: 520
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 10
        anchors.horizontalCenterOffset: -384
        anchors.horizontalCenter: parent.horizontalCenter

        Call_mousearea {
            id: call_mousearea
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            onReleased: {
                //this function is used to find the name corresponding to a numbe rin the phonebook

                //function to heck if a number is present in the phonebook
                var isNameFound = (fcn) => fcn.number === parseInt(phone_item.number_composed);
                //if the number is found, put in name_composed the correct name. if not leave it void
                if (phone_item.phonebook.findIndex(isNameFound) !== -1){
                    phone_item.name_composed = (phonebook_list_model.get(radio_station_listview.currentIndex)).name
                }else{
                    phone_item.name_composed = ""
                }
                //switch to calling state
                phone_item.state = "calling"
            }

            Rectangle {
                //this rectangle is used only during incoming call state to steer the user to press this button
                id: incoming_popping_circle_2
                visible: phone_item.state === "incoming"
                width: 108
                height: width
                color: dashboard_Utils.vi_transparent
                radius: width/2
                border.color: dashboard_Utils.vi_azure
                border.width: 3
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Timer{
                    id: timer_incoming_call_2
                    running: incoming_popping_circle_2.visible
                    repeat: true
                    interval: 70
                    onTriggered: incoming_popping_circle_2.width = dashboard_Utils.loop_values(incoming_popping_circle_2.width, 1, 108, 120)
                }
            }

        }

        Call_mousearea {
            id: drop_mousearea
            anchors.verticalCenter: parent.verticalCenter
            enabled: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 100
            name: "DROP"
            visible: false
            icon_rotation: 135
            call_color: dashboard_Utils.vi_red
            //drop always to phone home state when drop is called
            onReleased: phone_item.state = "home"
        }

        Call_mousearea {
            id: phonebook_mousearea
            name: ""
            width: 184
            height: 134
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            call_iconScale: 1.5
            call_iconSource: "images/phonebook_icon.png"
            enabled: true
            call_color: dashboard_Utils.vi_petrol
            anchors.verticalCenterOffset: 300
            anchors.horizontalCenter: parent.horizontalCenter
            //switch to phone phonebook state
            onReleased: phone_item.state = "phonebook"
        }

    }

    Item {
        id: calling_item
        antialiasing: true
        width: 668
        height: 696
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        enabled: false
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: text1
            width: 499
            height: 160
            color: dashboard_Utils.vi_white
            text: qsTr("Calling ...")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 70
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
            anchors.verticalCenterOffset: -174
            anchors.horizontalCenter: parent.horizontalCenter
        }

        AnimatedImage {
            id: voice_icon
            x: 0
            y: 0
            width: 498
            height: 257
            anchors.verticalCenter: parent.verticalCenter
            source: "images/voice_icon.gif"
            anchors.verticalCenterOffset: 306
            anchors.horizontalCenter: parent.horizontalCenter
            speed: 0.5
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: human_icon
            x: 0
            y: 0
            width: 124
            height: 124
            anchors.verticalCenter: parent.verticalCenter
            source: "images/human_icon.svg"
            asynchronous: true
            mipmap: true
            anchors.verticalCenterOffset: 165
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: text_calling
            width: 499
            height: 160
            color: dashboard_Utils.vi_fucsia
            //name + number during the call are shown
            text: phone_item.name_composed + " " + phone_item.number_composed
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 70
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenterOffset: 0
            anchors.verticalCenterOffset: 20
            font.family: "Sansation"
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    Item {
        id: incoming_item
        width: 668
        height: 696
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        enabled: false
        antialiasing: true
        Text {
            //this is the progressive number of the incoming call in the phonebook. it can be changed up to phonebook.lenght
            property int selected_incoming: 6
            id: text_incoming_call
            width: 499
            height: 264
            color: dashboard_Utils.vi_white
            text: "Incoming call from " + phone_item.phonebook[text_incoming_call.selected_incoming].name + " " + phone_item.phonebook[text_incoming_call.selected_incoming].number
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 70
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            anchors.verticalCenterOffset: -174
            font.family: "Sansation"
            anchors.horizontalCenter: parent.horizontalCenter
            onVisibleChanged: {
                //set number and name compoed when this is visible
                if (this.visible){
                    phone_item.number_composed = phone_item.phonebook[selected_incoming].number
                    phone_item.name_composed = phone_item.phonebook[selected_incoming].name
                }
            }

        }

        Image {
            id: human_icon1
            x: 0
            y: 0
            width: 124
            height: 124
            anchors.verticalCenter: parent.verticalCenter
            source: "images/human_icon.svg"
            mipmap: true
            antialiasing: true
            anchors.verticalCenterOffset: 100
            anchors.horizontalCenterOffset: 0
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: incoming_popping_circle
                width: 108
                height: width
                color: dashboard_Utils.vi_transparent
                radius: width/2
                border.color: dashboard_Utils.vi_fucsia
                border.width: 3
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Timer{
                    id: timer_incoming_call
                    running: phone_item.state === "incoming"
                    repeat: true
                    interval: 20
                    onTriggered: incoming_popping_circle.width = dashboard_Utils.loop_values(incoming_popping_circle.width, 3, 108, 250)
                }
            }
        }
        anchors.horizontalCenter: parent.horizontalCenter
    }


    Flickable{
        id: phonebook_scroll
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
            id: phonebook_list_model
            // 1. Initialize the list model by appending one by one phonebook elements
            Component.onCompleted: {
                for (var i = 0; i < phone_item.phonebook.length ; i++){
                    phonebook_list_model.append({name:      phone_item.phonebook[i].name ,
                                                 number:    phone_item.phonebook[i].number})
                }
            }
        }

        ListView{
            id: radio_station_listview
            width: phonebook_scroll.width
            height: phonebook_scroll.height
            spacing: 10
            snapMode: ListView.SnapToItem
            synchronousDrag: true
            focus: true
            orientation: Qt.Vertical

            model: phonebook_list_model
            delegate: Rectangle {
                id: phonebook_delegate
                width: 650
                height: 180
                //petrol color while isCurrent or clicked
                color: phonebook_delegate.ListView.isCurrentItem ? dashboard_Utils.vi_petrol :dashboard_Utils.vi_grey
                radius: 20
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        //when clicked, set the current index to the one we are selecting
                        phonebook_delegate.ListView.view.currentIndex = model.index
                        //update the number_composed with the selected one
                        phone_item.number_composed = (phonebook_list_model.get(radio_station_listview.currentIndex)).number
                        //check the corresponding name in the phonebook to the name_composed
                        var isNameFound = (fcn) => fcn.name === phone_item.phonebook[radio_station_listview.currentIndex].name;
                        //if found, set it or leave it void
                        if (phone_item.phonebook.findIndex(isNameFound) !== -1){
                            phone_item.name_composed = (phonebook_list_model.get(radio_station_listview.currentIndex)).name
                        }else{
                            phone_item.name_composed = ""
                        }
                        console.log("number: " + phone_item.number_composed)
                        console.log("name: " + phone_item.name_composed)
                    }
                }

                Rectangle {
                    id: phonebook_image_container
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
                        id: phonebook_icon
                        anchors.fill: parent
                        source: "images/human_icon.svg"
                        mipmap: true
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Text {
                    id: phonebook_number
                    y: 0
                    width: 513
                    height: 100
                    color: dashboard_Utils.vi_white
                    text: number.toFixed(0)
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenterOffset: 50
                    anchors.horizontalCenterOffset: 52
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Open Sans"
                }

                Text {
                    id: phonebook_name
                    y: 0
                    width: 512
                    height: 72
                    color: dashboard_Utils.vi_white
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 50
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenterOffset: -56
                    anchors.horizontalCenterOffset: 52
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Sansation"
                }

                Rectangle {
                    id: phonebook_play_image_container
                    //selection icon is visible only when this is the current item
                    visible: phonebook_delegate.ListView.isCurrentItem
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
                        id: selected_icon
                        x: 0
                        y: 0
                        anchors.verticalCenter: parent.verticalCenter
                        source: "images/selected_icon.png"
                        scale: 0.2
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
                        mipmap: true
                        antialiasing: true
                    }
                    anchors.horizontalCenterOffset: 272
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenterOffset: 0
                }


            }
        }

    }


    Button_item_mouse {
        id: return_phonebook_item
        enabled: false
        width: 395
        height: 326
        visible: false
        button_icon_value: "images/return_icon.png"
        scale: 0.3
        anchors.horizontalCenterOffset: -246
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        button_background_color_value: dashboard_Utils.vi_cream
        anchors.verticalCenterOffset: -191
        onReleased: {
            phone_item.state = "home"
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
            name: "home"

            PropertyChanges {
                target: drop_mousearea
                visible: false
                enabled: false
            }

            PropertyChanges {
                target: phone_keyboard_item
                visible: true
                enabled: true
            }
        },
        State {
            name: "phonebook"

            PropertyChanges {
                target: drop_mousearea
                visible: false
                enabled: false
            }

            PropertyChanges {
                target: phone_keyboard_item
                visible: false
                enabled: false
            }

            PropertyChanges {
                target: phonebook_scroll
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: return_phonebook_item
                visible: true
                enabled: true
            }



            PropertyChanges {
                target: phonebook_mousearea
                visible: false
                enabled: false
            }
        },
        State {
            name: "calling"

            PropertyChanges {
                target: call_mousearea
                visible: false
                enabled: false
            }

            PropertyChanges {
                target: phone_keyboard_item
                visible: false
                enabled: false
            }

            PropertyChanges {
                target: calling_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: voice_icon
                visible: true
            }

            PropertyChanges {
                target: human_icon
                anchors.verticalCenterOffset: 306
                anchors.horizontalCenterOffset: 187
            }

            PropertyChanges {
                target: drop_mousearea
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: phonebook_mousearea
                visible: false
                enabled: false
            }
        },
        State {
            name: "incoming"

            PropertyChanges {
                target: phone_keyboard_item
                visible: false
                enabled: false
            }

            PropertyChanges {
                name: "DECLINE"
                target: drop_mousearea
                visible: true
                enabled: true
            }

            PropertyChanges {
                name: "ACCEPT"
                target: call_mousearea
            }

            PropertyChanges {
                target: incoming_item
                visible: true
                enabled: true
            }

            PropertyChanges {
                target: phonebook_mousearea
                visible: false
                enabled: false
            }
        }
    ]
    transitions: [
        //opacity transitions
        Transition {
            from: "home"; to: "calling"; reversible: false
            PropertyAnimation { target: calling_item; properties: "opacity"; from: 0; to: 1; duration: 1000; easing: Easing.InOutQuad }
        },
        Transition {
            from: "home"; to: "phonebook"; reversible: false
            PropertyAnimation { target: phonebook_scroll; properties: "opacity"; from: 0; to: 1; duration: 500; easing: Easing.InOutQuad }
            PropertyAnimation { target: return_phonebook_item; properties: "opacity"; from: 0; to: 1; duration: 500; easing: Easing.InOutQuad }
        },
        Transition {
            from: "phonebook"; to: "calling"; reversible: false
            PropertyAnimation { target: calling_item; properties: "opacity"; from: 0; to: 1; duration: 2000; easing: Easing.InOutQuad }
        },
        Transition {
            from: "incoming"; to: "calling"; reversible: false
            PropertyAnimation { target: calling_item; properties: "opacity"; from: 0; to: 1; duration: 1000; easing: Easing.InOutQuad }
        },
        Transition {
            from: "calling"; to: "home"; reversible: false
            PropertyAnimation { target: phone_keyboard_item; properties: "opacity"; from: 0; to: 1; duration: 1000; easing: Easing.InOutQuad }
        },
        Transition {
            from: "incoming"; to: "home"; reversible: false
            PropertyAnimation { target: phone_keyboard_item; properties: "opacity"; from: 0; to: 1; duration: 1000; easing: Easing.InOutQuad }
        },
        Transition {
            from: ""; to: "home"; reversible: false
            PropertyAnimation { target: phone_keyboard_item; properties: "opacity"; from: 0; to: 1; duration: 1000; easing: Easing.InOutQuad }
        },
        Transition {
            from: ""; to: "incoming"; reversible: false
            PropertyAnimation { target: incoming_item; properties: "opacity"; from: 0; to: 1; duration: 1000; easing: Easing.InOutQuad }
        }
    ]
    state: "home"



}




