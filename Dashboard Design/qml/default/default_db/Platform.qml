import QtQuick 2.12

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"

Item {
    id: platform_DiM
    width: 600
    height: 600

    property double pos_lat_LP: 0              //m
    property double pos_long_LP: 0             //m
    property double pos_yaw_LP: 0              //rad

    property double pos_lat_DiMc: 0              //m
    property double pos_long_DiMc: 0             //m
    property double pos_yaw_DiMc: 0              //rad

    property double pos_lat: !platform_DiM.dimC ?               platform_DiM.pos_lat_LP:        //for sag DiM take _LP        //m
                              platform_DiM.data_check_mode ?    platform_DiM.pos_lat_LP:        //for DiMc: if in datacheck --> _LP
                                                                platform_DiM.pos_lat_DiMc       //          if normal drive --> _DiMc
    property double pos_long: !platform_DiM.dimC ?               platform_DiM.pos_long_LP:        //for sag DiM take _LP        //m
                               platform_DiM.data_check_mode ?    platform_DiM.pos_long_LP:        //for DiMc: if in datacheck --> _LP
                                                                 platform_DiM.pos_long_DiMc       //          if normal drive --> _DiMc
    property double pos_yaw: !platform_DiM.dimC ?               platform_DiM.pos_yaw_LP:        //for sag DiM take _LP        //rad
                              platform_DiM.data_check_mode ?    platform_DiM.pos_yaw_LP:        //for DiMc: if in datacheck --> _LP
                                                                platform_DiM.pos_yaw_DiMc       //          if normal drive --> _DiMc

    property double dim_simulator: 400      //cm
    property bool dimC: true                //bool
    property bool data_check_mode: false    //forces pos_LP when using datacheck on dimC

    property double solver_status: 0        //crt solver status
    property double cueing_status: 0      //cueing status

    property bool platform_sound_notice: false      //if sound is enabled
    property double platform_sound_notice_level: 0

    property double pos_yellow: dashboard_Utils.pos_long_max * 0.85        //m
    property double pos_red: dashboard_Utils.pos_long_max * 0.9          //m

    property double yaw_yellow: dashboard_Utils.pos_yaw_max * 0.65         //rad
    property double yaw_red: dashboard_Utils.pos_yaw_max * 0.85           //rad

    property double range: dashboard_Utils.eu_dist_from_zero(platform_DiM.pos_long,platform_DiM.pos_lat)

    property bool driveSim_activity: false
    property bool platform_tracking_mode: true          //enable the tracking of the platform
    property double lap_num: 0      //lap num used to reset tracing

    onData_check_modeChanged: {
        data_check_trigger.visible = true
        data_check_timer.restart()
    }


    Image {
        property double image_size: 600         //baseframe width or height
        property double platform_border: 6      //platform border white
        property double lower_stage_width: platform_DiM.dimC ? 210 : 325        //distinguish the shape depending on dimc dim sag
        property double pos_internal_max: (baseframe.image_size/2-baseframe.platform_border) - (baseframe.lower_stage_width/2)*frame.scale
                                        //half width oh the image - border   -half of the lower stage with scaled (this depends on the size of sim)

        id: baseframe
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/DiM_baseframe.png"
        mipmap: true
        fillMode: Image.PreserveAspectFit

        Platform_tracking{
            id: platform_tracking
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            solver_status: platform_DiM.solver_status
            cueing_status: platform_DiM.cueing_status
            pos_lat: platform_DiM.pos_lat   / dashboard_Utils.pos_lat_max
            pos_long: platform_DiM.pos_long  / dashboard_Utils.pos_long_max
            lap_num: platform_DiM.lap_num
            dimC: platform_DiM.dimC
            platform_tracking_mode: platform_DiM.platform_tracking_mode
            pos_yellow: platform_DiM.pos_yellow
            pos_red: platform_DiM.pos_red
            driveSim_activity: platform_DiM.driveSim_activity
        }

        Image {
            id: frame
            width: parent.width
            height: parent.height
            mipmap: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset:   -platform_DiM.pos_long  / dashboard_Utils.pos_long_max  * baseframe.pos_internal_max
            anchors.horizontalCenterOffset: -platform_DiM.pos_lat   / dashboard_Utils.pos_lat_max   * baseframe.pos_internal_max
            rotation: -dashboard_Utils.rad2deg(platform_DiM.pos_yaw)
            source: !platform_DiM.platform_sound_notice ?  (platform_DiM.range > platform_DiM.pos_red ?  "images/disk_dim_red.png":                                         //normal conditions
                                                            platform_DiM.range > platform_DiM.pos_yellow ?   "images/disk_dim_yellow.png":"images/disk_dim_green.png") :
                                                           (platform_DiM.platform_sound_notice_level > 3 ? "images/disk_dim_red.png":                                       //activate yellow/red when sound is coming
                                                            platform_DiM.platform_sound_notice_level > 0 ? "images/disk_dim_yellow.png":"images/disk_dim_green.png")
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: auto
            width: frame.width
            height: frame.height
            anchors.verticalCenter: frame.verticalCenter
            anchors.horizontalCenter: frame.horizontalCenter
            rotation: frame.rotation
            scale: frame.scale
            source: Math.abs(platform_DiM.pos_yaw) > platform_DiM.yaw_red       ?   "images/car_dim_red.png" :
                    Math.abs(platform_DiM.pos_yaw) > platform_DiM.yaw_yellow    ?   "images/car_dim_yellow.png" :
                                                                                  "images/car_dim_green.png"
            mipmap: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: data_check_trigger
        width: 555
        height: 320
        visible: false
        color: dashboard_Utils.vi_yellow_2
        radius: width/20
        border.width: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: data_check_text
            color: dashboard_Utils.vi_black
            text: platform_DiM.data_check_mode ? qsTr("DATA CHECK ENABLED") :qsTr("DATA CHECK DISABLED")
            anchors.fill: parent
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.bold: true
            font.family: "Sansation"
        }
        Timer{
            id: data_check_timer
            running: false
            repeat: false
            interval: 4000
            onTriggered: {
                data_check_trigger.visible = false
            }
        }
    }

    Rectangle {
        id: data_check_visual
        width: 60
        height: 60
        visible: platform_DiM.data_check_mode
        color: dashboard_Utils.vi_black
        radius: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 262
        anchors.horizontalCenterOffset: -262
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: data_check_visual_text
            color: dashboard_Utils.vi_white
            text: qsTr("D")
            anchors.fill: parent
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
        }
    }

    Rectangle {
        id: positional_visual
        width: 60
        height: 60
        visible: platform_DiM.platform_sound_notice
        color: dashboard_Utils.vi_black
        radius: 15
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: positional_visual_text
            color: dashboard_Utils.vi_white
            text: qsTr("P")
            anchors.fill: parent
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 262
        anchors.verticalCenterOffset: 262
    }

    Rectangle {
        id: tracking_visual
        x: 2
        y: 2
        width: 60
        height: 60
        visible: platform_DiM.platform_tracking_mode
        color: dashboard_Utils.vi_black
        radius: 15
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -262
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -262
        Text {
            color: dashboard_Utils.vi_white
            text: qsTr("T")
            anchors.fill: parent
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Sansation"
        }
    }

    Dashboard_Utils{
        id: dashboard_Utils
        pos_long_max:   platform_DiM.dim_simulator / 100 / 2
        pos_lat_max:    platform_DiM.dim_simulator / 100 / 2
        pos_yaw_max:    platform_DiM.dimC ? 1 : 0.6

    }



    states: [
        State {
            name: "DiM_C"
            when: platform_DiM.dimC

            PropertyChanges {
                target: frame
                source: !platform_DiM.platform_sound_notice ?  (platform_DiM.range > platform_DiM.pos_red ?  "images/disk_dim_red.png":                                         //normal conditions
                                                                platform_DiM.range > platform_DiM.pos_yellow ?   "images/disk_dim_yellow.png":"images/disk_dim_green.png") :
                                                               (platform_DiM.platform_sound_notice_level > 3 ? "images/disk_dim_red.png":                                       //activate yellow/red when sound is coming
                                                                platform_DiM.platform_sound_notice_level > 0 ? "images/disk_dim_yellow.png":"images/disk_dim_green.png")
                scale: (400+166.5) / (platform_DiM.dim_simulator+166.5)
                      //available space + width of the lower frame   / (current sim available space + width of the lower frame)
            }
            PropertyChanges {
                target: platform_tracking
                scale: 1+((baseframe.pos_internal_max - 189)/189)
                      //1 + (current max internal position to limit - refrence 400 internal position to limit)/refrence 400 internal position to limit
            }
        },
        State {
            name: "DiM_Sag"
            when: !platform_DiM.dimC

            PropertyChanges {
                target: frame
                source: !platform_DiM.platform_sound_notice ?  (platform_DiM.range > platform_DiM.pos_red ?  "images/tria_dim_red.png":                                         //normal conditions
                                                                platform_DiM.range > platform_DiM.pos_yellow ?   "images/tria_dim_yellow.png":"images/tria_dim_green.png") :
                                                               (platform_DiM.platform_sound_notice_level > 3 ? "images/tria_dim_red.png":                                       //activate yellow/red when sound is coming
                                                                platform_DiM.platform_sound_notice_level > 0 ? "images/tria_dim_yellow.png":"images/tria_dim_green.png")
                scale: (150+171.5) / (platform_DiM.dim_simulator+171.5)
                //available space + width of the lower frame   / (current sim available space + width of the lower frame)
            }
            PropertyChanges {
                target: platform_tracking
                scale: 1+((baseframe.pos_internal_max - 131.5)/131.5)
                      //1 + (current max internal position to limit - refrence 150 internal position to limit)/refrence 150 internal position to limit
            }
        }
    ]
    //debugging

    Timer{
        property bool debug: false
        id: pos_debug
        running: pos_debug.debug
        repeat: true
        interval: 60
        onTriggered: {
            platform_DiM.solver_status = dashboard_Utils.vICRT_SOLVER_STATUS_STARTED
            platform_DiM.cueing_status = dashboard_Utils.cUEING_STATUS_STARTED

            platform_DiM.pos_long = platform_DiM.pos_long + 0.1*Math.random()
            if (Math.abs(platform_DiM.pos_long) > dashboard_Utils.pos_long_max) platform_DiM.pos_long = -dashboard_Utils.pos_long_max

            platform_DiM.pos_lat = platform_DiM.pos_lat + 0.2*Math.random()
            if (Math.abs(platform_DiM.pos_lat) > dashboard_Utils.pos_lat_max) platform_DiM.pos_lat = -dashboard_Utils.pos_lat_max

            platform_DiM.pos_yaw = platform_DiM.pos_yaw + 0.05*Math.random()
            if (Math.abs(platform_DiM.pos_yaw) > dashboard_Utils.pos_yaw_max) platform_DiM.pos_yaw = -platform_DiM.pos_yaw
        }
    }

    Timer{
        id: lap_increase
        running: pos_debug.debug
        repeat: true
        triggeredOnStart: false
        interval: 10*1000
        onTriggered: {
            platform_DiM.lap_num = platform_DiM.lap_num + 1
        }
    }



}







