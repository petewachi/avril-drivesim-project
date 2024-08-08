import QtQuick 2.12




Item {
    // vehicle side slip angle
    property double vehicle_side_slip_value: 0

    //tires logitudinal slips
    property double fl_slip_value: 0
    property double fr_slip_value: 0
    property double rl_slip_value: 0
    property double rr_slip_value: 0
    property double slip_limit_value: 12

    //tires toe angles
    property double fl_toe_value: 0
    property double fr_toe_value: 0
    property double rl_toe_value: 0
    property double rr_toe_value: 0

    //tires normal forces
    property double fl_normal_force_value: 1
    property double fr_normal_force_value: 1
    property double rl_normal_force_value: 1
    property double rr_normal_force_value: 1

    id: slip_item
    width: 192
    height: 221

    scale: dashboard_Utils.resize_content(width, height, 192, 221)


    Image {
        id: chassis_image
        width: 96
        height: 164
        opacity: 0.8
        anchors.verticalCenter: parent.verticalCenter
        source: "images/RaceCar_RT_ges_chassis v1.png"
        rotation: dashboard_Utils.rad2deg(slip_item.vehicle_side_slip_value)
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        mipmap: true

        Image {
            id: tire_fl
            width: 58
            height: 88
            anchors.verticalCenter: parent.verticalCenter
            source: "images/tire.png"
            rotation: dashboard_Utils.rad2deg(slip_item.fl_toe_value)
            visible: slip_item.fl_normal_force_value !== 0
            anchors.verticalCenterOffset: -44
            anchors.horizontalCenterOffset: -27
            anchors.horizontalCenter: parent.horizontalCenter
            antialiasing: true
            mipmap: true
            fillMode: Image.PreserveAspectFit

            Image {
                id: tire_fl_red
                x: 0
                y: 0
                width: 58
                height: 88
                opacity: Math.abs(slip_item.fl_slip_value)/ slip_item.slip_limit_value
                anchors.verticalCenter: parent.verticalCenter
                source: "images/tire_red.png"
                mipmap: true
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true
            }
        }

        Image {
            id: tire_fr
            width: 58
            height: 88
            rotation: -dashboard_Utils.rad2deg(slip_item.fr_toe_value)
            visible: slip_item.fr_normal_force_value !== 0
            anchors.verticalCenter: parent.verticalCenter
            source: "images/tire.png"
            anchors.verticalCenterOffset: -44
            mipmap: true
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenterOffset: 28
            anchors.horizontalCenter: parent.horizontalCenter
            antialiasing: true

            Image {
                id: tire_fr_red
                x: -28
                y: 44
                width: 58
                height: 88
                opacity: Math.abs(slip_item.fr_slip_value)/ slip_item.slip_limit_value
                anchors.verticalCenter: parent.verticalCenter
                source: "images/tire_red.png"
                mipmap: true
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true
            }
        }

        Image {
            id: tire_rl
            width: 58
            height: 88
            rotation: dashboard_Utils.rad2deg(slip_item.rl_toe_value)
            visible: slip_item.rl_normal_force_value !== 0
            anchors.verticalCenter: parent.verticalCenter
            source: "images/tire.png"
            anchors.verticalCenterOffset: 49
            mipmap: true
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenterOffset: -27
            anchors.horizontalCenter: parent.horizontalCenter
            antialiasing: true

            Image {
                id: tire_rl_red
                x: 27
                y: -49
                width: 58
                height: 88
                opacity: Math.abs(slip_item.rl_slip_value)/ slip_item.slip_limit_value
                anchors.verticalCenter: parent.verticalCenter
                source: "images/tire_red.png"
                mipmap: true
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true
            }
        }

        Image {
            id: tire_rr
            width: 58
            height: 88
            rotation: -dashboard_Utils.rad2deg(slip_item.rr_toe_value)
            visible: slip_item.rr_normal_force_value !== 0
            anchors.verticalCenter: parent.verticalCenter
            source: "images/tire.png"
            anchors.verticalCenterOffset: 49
            mipmap: true
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenterOffset: 28
            anchors.horizontalCenter: parent.horizontalCenter
            antialiasing: true

            Image {
                id: tire_rr_red
                x: -55
                y: 0
                width: 58
                height: 88
                opacity: Math.abs(slip_item.rr_slip_value)/ slip_item.slip_limit_value
                anchors.verticalCenter: parent.verticalCenter
                source: "images/tire_red.png"
                mipmap: true
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                antialiasing: true
            }
        }
    }

    Dashboard_Utils{id: dashboard_Utils}
}

/*##^##
Designer {
    D{i:0;height:221;width:192}
}
##^##*/
