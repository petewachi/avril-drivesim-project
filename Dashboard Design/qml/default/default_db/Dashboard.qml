import QtQuick 2.2
import QtQuick.Window 2.1
import com.vigrade.VIClass 1.0

Item {
    id: root
    visible: true
    width: Window.width
    height: Window.height



    Image {
        id: image
        source: "./images/vi-grade.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter


    }


}
