import QtQuick 2.12
import "../../../qml/default/default_db"


Item {
    id: venting_item
    //active only when in manual A/C

    width: 1080
    height: 200
    property double venting_value: 0

    Slider_item {
        id: slider_item
        x: 202
        y: 308
        width: 676
        height: 160
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        value: venting_item.venting_value
        onValueChanged: venting_item.venting_value = value
    }
    MouseArea{
        id: minus_mouse

        width: 200
        height: 200
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: -400
        anchors.horizontalCenter: parent.horizontalCenter
        onPressed: {
            minus_mouse.scale = minus_mouse.scale*0.9
        }
        onReleased: {
            minus_mouse.scale = minus_mouse.scale/0.9
            //when released, it changes the value of the slider (i.e. venting value) to decrease it by one step
            slider_item.value = dashboard_Utils.nearest(venting_item.venting_value - slider_item.step, slider_item.min_max[0], slider_item.min_max[1], slider_item.step)
        }

        Image {
            id: minus_vent_icon
            x: 0
            y: 0
            width: 200
            height: 200
            anchors.fill: parent
            source: "images/minus_vent_icon.png"
            fillMode: Image.PreserveAspectFit

        }
    }

    MouseArea{
        id: plus_mouse

        width: 200
        height: 200
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 400
        anchors.horizontalCenter: parent.horizontalCenter
        onPressed: {
            plus_mouse.scale = plus_mouse.scale*0.9
        }
        onReleased: {
            plus_mouse.scale = plus_mouse.scale/0.9
            //when released, it changes the value of the slider (i.e. venting value) to increase it by one step
            slider_item.value = dashboard_Utils.nearest(venting_item.venting_value + slider_item.step, slider_item.min_max[0], slider_item.min_max[1], slider_item.step)
        }

        Image {
            id: plus_vent_icon
            x: 0
            y: 0
            width: 200
            height: 200
            anchors.fill: parent
            source: "images/plus_vent_icon.png"
            fillMode: Image.PreserveAspectFit

        }
    }
    Dashboard_Utils{id: dashboard_Utils}
}
