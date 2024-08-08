import QtQuick 2.12
import QtQuick.Extras 1.4

import QtQuick.Studio.Components 1.0
import QtGraphicalEffects 1.0
import "../../../qml/default/default_db"


Item {
    id: battery_item
    width: 600
    height: 600
    layer.samples: 16
    layer.enabled: true
    layer.smooth: true
    layer.mipmap: isXREnabled ? false : true


    property double power_value: 0                      //power or current
    property double power_max_value: 500                   //max power kW
    property double power_red_value: battery_item.power_max_value*0.5    //red power


    property double battery_soc_value: 100            //battery soc [%]
    property double battery_soc_yellow_value: 20    //battery soc value for yellow[%]
    property double battery_soc_red_value: 5        //battery soc value for red[%]


    Canvas{
        id: canvas
        function drawTextAlongArc(context, str, centerX, centerY, radius, angle)
        {
            context.save();
            context.translate(centerX, centerY);
            context.rotate(-1 * angle / 2);
            context.rotate(-1 * (angle / str.length) / 2);
            for (var n = 0; n < str.length; n++) {
                context.rotate(angle / str.length);
                context.save();
                context.translate(0, -1 * radius);
                var char1 = str[n];
                context.fillText(char1, 0, 0);
                context.restore();
            }
            context.restore();
        }
        anchors.fill: parent
        rotation: -45/2
        onPaint: {
            var ctx = getContext("2d");
            ctx.font='20pt Sansation'
            ctx.textAlign = "center";
            var centerX = width / 2;
            var centerY = height/2; //height - 30;
            var angle   = Math.PI*1.25 ; // radians
            var radius  = 190;
            ctx.fillStyle=dashboard_Utils.vi_light_grey
            drawTextAlongArc(ctx, "REGEN     ECO       POWER  ", centerX, centerY, radius, angle);

        }
    }

    ArcItem {
        id: battery_arc
        width: 500
        height: 500
        opacity: 0.8
        visible: false
        begin: battery_item.power_value >= 0 ? 269 : battery_arc.end + dashboard_Utils.saturation(
                                                   (battery_item.power_value)/(battery_item.power_max_value*45/180)*45,
                                                   -45,
                                                   0)
        strokeWidth: 20
        strokeColor:battery_item.power_value >= (battery_item.power_red_value) ? dashboard_Utils.vi_red :
                                                                                 battery_item.power_value >= 0 ? dashboard_Utils.vi_green:
                                                                                                                 dashboard_Utils.vi_azure
        fillColor: dashboard_Utils.vi_transparent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        antialiasing: true
        end: battery_item.power_value >= 0 ?battery_arc.begin + dashboard_Utils.saturation(
                                                 (battery_item.power_value)/battery_item.power_max_value*180,
                                                 -45,
                                                 180) : 269
        rotation: 90
    }
    Glow {
        id: battery_arc_glow
        opacity: 0.8
        color: battery_arc.strokeColor
        anchors.fill: battery_arc
        radius: 20
        samples: 35
        spread: 0.3
        source: battery_arc
        fast: true
        rotation: battery_arc.rotation
        antialiasing: true
    }


    Rectangle {
        id: flat_start
        width: 140
        height: 3
        color: dashboard_Utils.vi_grey
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 5
        anchors.horizontalCenterOffset: -196
        anchors.horizontalCenter: parent.horizontalCenter
    }


    Image {
        id: torque_circle_back
        width: 632
        height: 632
        rotation: -45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "images/background.png"
        antialiasing: true
        mipmap: true
    }

    Image {
        id: torque_red
        width: 632
        height: 632
        anchors.verticalCenter: parent.verticalCenter
        source: "images/background_power_level.png"
        rotation: -47 - (battery_item.power_max_value - battery_item.power_red_value)/battery_item.power_max_value*179
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        mipmap: true
        antialiasing: true
    }

    ArcItem {
        id: battery_soc_arc
        x: 45
        y: 45
        width: 510
        height: width
        anchors.verticalCenter: parent.verticalCenter
        layer.smooth: true
        layer.effect: battery_soc_arc
        layer.samples: 16
        layer.enabled: true
        end: -90 + 29
        begin: end - dashboard_Utils.saturation((29*2 * battery_item.battery_soc_value/100),0,29*2)
        strokeWidth: 20
        strokeColor: battery_item.battery_soc_value< battery_item.battery_soc_red_value ? dashboard_Utils.vi_red:
                                                                                          battery_item.battery_soc_value< battery_item.battery_soc_yellow_value ? dashboard_Utils.vi_yellow:
                                                                                                                                                                  dashboard_Utils.vi_green
        anchors.horizontalCenter: parent.horizontalCenter
        fillColor: dashboard_Utils.vi_transparent
        antialiasing: true
        layer.mipmap: isXREnabled ? false : true
    }

    Image {
        id: battery_level_circle_back
        width: 632
        height: 632
        anchors.verticalCenter: parent.verticalCenter
        source: "images/background_battery_level.png"
        fillMode: Image.PreserveAspectFit
        mipmap: true
        anchors.horizontalCenter: parent.horizontalCenter
        antialiasing: true


        Image {
            id: needle_soc
            width: 630
            height: 630
            rotation: (+29 -dashboard_Utils.saturation(battery_item.battery_soc_value,0,100)/100*(29*2))
            anchors.verticalCenter: parent.verticalCenter
            source: "images/needle_white_soc.svg"
            sourceSize.width: 600
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }
    }

    Item {
        id: rotation_rpm
        width: 200
        height: 200
        rotation: 89 + dashboard_Utils.saturation(
                      (battery_item.power_value)/battery_item.power_max_value*180,
                      -45,
                      180)
        Image {
            id: needle
            width: 600
            source: "images/needle_white.svg"
            sourceSize.width: 600
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: central_round
        width: 400
        height: 400
        source: "images/dial.png"
        mipmap: true
        antialiasing: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit

        Item {
            id: motor_text
            width: parent.width*0.8
            height: 150
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -71
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter


            Text {
                id: motor_text_
                x: 30
                y: 22
                width: 259
                height: 73
                color: dashboard_Utils.vi_white
                text: "power"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: -parent.height/4
                anchors.horizontalCenterOffset: 0
                fontSizeMode: Text.FixedSize
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Sansation"
                maximumLineCount: 1
            }
            Text {
                id: motor_value_text
                x: 30
                y: 79
                width: 259
                height: 73
                color: battery_item.power_value > (battery_item.power_red_value) ? dashboard_Utils.vi_red :
                                                                                   battery_item.power_value >= 0 ? dashboard_Utils.vi_green:
                                                                                                                   dashboard_Utils.vi_azure
                text: Math.abs(battery_item.power_value).toFixed(0) + " kW"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.verticalCenterOffset: parent.height/4
                fontSizeMode: Text.FixedSize
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Sansation"
            }
        }

        Item {
            id: battery_soc_text
            width: parent.width*0.8
            height: 150
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 71
            Text {
                id: battery_soc_text_
                x: 30
                y: 22
                width: 259
                height: 73
                color: dashboard_Utils.vi_white
                text: "battery"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 35
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 49
                font.family: "Sansation"
                fontSizeMode: Text.FixedSize
                anchors.horizontalCenter: parent.horizontalCenter
                maximumLineCount: 1
                anchors.horizontalCenterOffset: 1
            }

            Text {
                id: battery_soc_value_text
                x: 30
                y: 79
                width: 259
                height: 73
                color: battery_item.battery_soc_value< battery_item.battery_soc_red_value ? dashboard_Utils.vi_red:
                                                                                            battery_item.battery_soc_value< battery_item.battery_soc_yellow_value ? dashboard_Utils.vi_yellow:
                                                                                                                                                                    dashboard_Utils.vi_white
                text: battery_item.battery_soc_value.toFixed(0) + " %"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: -30
                font.family: "Sansation"
                fontSizeMode: Text.FixedSize
                anchors.horizontalCenter: parent.horizontalCenter
            }
            anchors.horizontalCenterOffset: 0
        }


    }








    Dashboard_Utils{id: dashboard_Utils}








}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.1;height:600;width:600}
}
##^##*/
