import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

MouseArea{
    //image source of the button
    property alias button_icon_value: button_icon.source
    property alias button_icon_rotation_value: button_icon.rotation
    property alias button_icon_scale_value: button_icon.scale
    //text of the button
    property alias button_textColor: button_text.color
    property alias button_textText: button_text.text
    property alias button_textFontpixelSize: button_text.font.pixelSize
    //radius of rectangle corners
    property alias button_radius_value: button_back.radius
    //color of the border of the rectangle
    //value of the button when needed. boolean
    property bool value: false
    //rtdb name of the value of the button. string
    property string value_rtdb: ""
    //scaling while pressed
    property double scale_pressed: 0.9

    id: button_item_mouse

    width: 350
    height: 350
    property color button_background_color_value: "#ffffff"
    onPressed: {
        button_item_mouse.scale = button_item_mouse.scale * button_item_mouse.scale_pressed
    }
    onReleased: {
        button_item_mouse.scale = button_item_mouse.scale / button_item_mouse.scale_pressed
        if (value_rtdb === ""){
            button_item_mouse.value = !button_item_mouse.value
        }else{
            viclass.setChannelValue(button_item_mouse.value_rtdb, !button_item_mouse.value)
        }
    }

    Rectangle {
        id: button_back
        width: parent.width
        height: parent.height
        scale: dashboard_Utils.resize_content(width,height,300,300)
        color: dashboard_Utils.vi_black
        radius: 30
        border.color: button_item_mouse.button_background_color_value
        border.width: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            antialiasing: true
            mipmap: true
            id: button_icon
            anchors.fill: parent
            source: ""
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            anchors.topMargin: 20
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: button_text
            color: dashboard_Utils.vi_white
            text: ""
            anchors.fill: parent
            font.pixelSize: 100
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
        }
    }
    Dashboard_Utils{id: dashboard_Utils}

}

/*##^##
Designer {
    D{i:0;height:340;width:364}
}
##^##*/
