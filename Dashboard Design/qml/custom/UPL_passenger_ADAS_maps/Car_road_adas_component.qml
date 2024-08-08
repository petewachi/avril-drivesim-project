import QtQuick 2.12
import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"




Item {
    id: cars_road
    width: 878
    height: 434

    property bool radar_green_visible_acc: true
    property bool front_car_visible_acc: false
    property int acc_levels: 3

    property bool radar_red_visible_aeb: false
    property bool radar_green_visible_aeb: false
    property bool front_car_visible_aeb: false

    property bool radar_green_visible_tja: false
    property bool front_car_visible_tja: false

    property bool ldw_ready: true
    property bool ldw_on_left: true
    property bool ldw_on_right: true

    property bool lka_ready: true
    property bool lka_on_left: true
    property bool lka_on_right: true

    property bool bsd_on_left: true
    property bool bsd_on_right: true

    onFront_car_visible_accChanged: {
        car2_animation.restart()
    }

    Image {
        id: road
        x: 278
        y: 29
        width: 1018
        height: 405
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/road.png"
        fillMode: Image.PreserveAspectFit
        mipmap: true
    }

    Image {
        id: radar_green
        x: 366
        y: -9
        width: 634
        height: 435
        anchors.verticalCenter: parent.verticalCenter
        visible: (cars_road.radar_green_visible_acc || cars_road.radar_green_visible_aeb)
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        source: cars_road.acc_levels === 4 ? "images/radar_4.png":
                cars_road.acc_levels === 3 ? "images/radar_3.png":
                cars_road.acc_levels === 2 ? "images/radar_2.png":
                cars_road.acc_levels === 1 ? "images/radar_1.png":
                                             "images/radar_3.png"
        fillMode: Image.PreserveAspectFit
        mipmap: true
    }

    Image {
        id: radar_red
        x: 366
        y: -9
        width: 643
        height: 435
        anchors.verticalCenter: parent.verticalCenter
        visible: cars_road.radar_red_visible_aeb
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/radar_red_3.png"
        fillMode: Image.PreserveAspectFit
        mipmap: true
    }

    Image {
        id: car1
        x: 289
        y: 21
        width: 301
        height: 519
        visible: false
        anchors.verticalCenterOffset: 64
        anchors.horizontalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        source: "images/SedanCar_Chassis.png"
        fillMode: Image.Tile
        mipmap: true
    }

    Image {
        id: newcar
        x: 289
        y: 21
        width: 301
        height: 300
        anchors.verticalCenterOffset: 113
        anchors.horizontalCenterOffset: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        //source: "images/SedanCar_Chassis.png"
        //fillMode: Image.Tile
        source: "images/car.png"
        scale: 1.5
        fillMode: Image.Pad

        mipmap: true
    }
    Image {
        id: car2
        x: 365
        y: 21
        width: 103
        height: 101
        anchors.verticalCenterOffset: -157
        anchors.verticalCenter: parent.verticalCenter
        visible: true
        anchors.horizontalCenterOffset: 9
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/hyundai.png"
        fillMode: Image.PreserveAspectFit
        mipmap: true
        PropertyAnimation {
            id: car2_animation;
            target: car2;
            property: "opacity";
            to: !cars_road.front_car_visible_acc
            duration: 100
        }
    }

    Image {
        id: bsd_left
        opacity: 0
        anchors.verticalCenterOffset: 100
        anchors.horizontalCenterOffset: -140
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        rotation: 10
        fillMode: Image.PreserveAspectFit
        source: "images/bsd_minimal.png"
        mipmap: true
        NumberAnimation {
            id: animation_bsd_left_on
            target: bsd_left
            property: "opacity"
            from: bsd_left.opacity
            to: 1
            duration: 1000
            running: cars_road.bsd_on_left
            easing.type: Easing.InCirc
        }
        NumberAnimation {
            id: animation_bsd_left_off
            target: bsd_left
            property: "opacity"
            from: bsd_left.opacity
            to: 0
            duration: 1000
            running: !cars_road.bsd_on_left
            easing.type: Easing.InCirc
        }
    }

    Image {
        id: bsd_right
        opacity: 0
        verticalAlignment: Image.AlignBottom
        horizontalAlignment: Image.AlignRight
        anchors.horizontalCenterOffset: 140
        anchors.verticalCenterOffset: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        mirror: true
        source: "images/bsd_minimal.png"
        fillMode: Image.Tile
        rotation: -10
        mipmap: true
        NumberAnimation {
            id: animation_bsd_right_on
            target: bsd_right
            property: "opacity"
            from: bsd_right.opacity
            to: 1
            duration: 1000
            running: cars_road.bsd_on_right
            easing.type: Easing.InCirc
        }
        NumberAnimation {
            id: animation_bsd_right_off
            target: bsd_right
            property: "opacity"
            from: bsd_right.opacity
            to: 0
            duration: 1000
            running: !cars_road.bsd_on_right
            easing.type: Easing.InCirc
        }
    }

    Image {
        id: green_lanes
        width: 826
        height: 376
        visible: cars_road.ldw_ready || cars_road.lka_ready
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "images/green_lines.png"
        mipmap: true
    }

    Image {
        id: left_lane_over
        width: 862
        height: 376
        visible: cars_road.ldw_on_left || cars_road.lka_on_left
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "images/left_red_line.png"
        mipmap: true
    }

    Image {
        id: right_lane_over
        width: 758
        height: 376
        visible: cars_road.ldw_on_right || cars_road.lka_on_right
        anchors.horizontalCenterOffset: 9
        mirror: true
        source: "images/left_red_line.png"
        mipmap: true
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Dashboard_Utils{id: dashboard_Utils}

}

/*##^##
Designer {
    D{i:0;height:434;width:878}
}
##^##*/
