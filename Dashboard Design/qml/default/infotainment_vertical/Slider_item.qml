import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"


Item {
    id: slider_item
    //touchable slider
    width: 920
    height: 160
    //current value
    property double value: 0
    //min and max saturation
    property var min_max: [0,10]        // min, max
    property double step: 1        // step

    Rectangle {
        id: intensity_slider_background
        width: 524
        height: 23
        color: dashboard_Utils.vi_black
        radius: 40
        border.color: dashboard_Utils.vi_cream
        border.width: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: slider_pointer
            x: 157
            width: 60
            height: 60
            color: dashboard_Utils.vi_azure
            radius: 45.5
            border.color: dashboard_Utils.vi_grey
            border.width: 10
            anchors.verticalCenter: parent.verticalCenter
            //move the pointer depending on value. value can be changed externally or by touching and dragging it
            anchors.horizontalCenterOffset:-parent.width/2 +
                                           parent.width*(slider_item.value - slider_item.min_max[0])/
                                           (slider_item.min_max[1] -slider_item.min_max[0])
            anchors.horizontalCenter: parent.horizontalCenter

        }

        MouseArea{
            id: slider_mouse
            anchors.fill: parent
            anchors.rightMargin: -20
            anchors.leftMargin: -20
            anchors.bottomMargin: -20
            anchors.topMargin: -20
            scale: 1
            drag.target: slider_pointer
            drag.axis: Drag.XAxis

            onMouseXChanged: {
                //change value depending on the dragging. fuinding also the nearest depending on the decided step
                slider_item.value = dashboard_Utils.nearest((slider_mouse.mouseX)*
                                                            (slider_item.min_max[1]-slider_item.min_max[0])
                                                            /(parent.width),
                                                            slider_item.min_max[0],
                                                            slider_item.min_max[1],
                                                            slider_item.step);
            }
        }



    }
    Dashboard_Utils{id: dashboard_Utils}


}
