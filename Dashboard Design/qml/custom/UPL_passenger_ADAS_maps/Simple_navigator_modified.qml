import QtQuick 2.12
import "../../../qml/default/default_db"
import QtLocation 5.14
import QtPositioning 5.14

Item {
    id: simple_navigator_modified
    width: 1080
    height: 1150
    scale: 2
    property double latitude: 42.2991485595703
    property double longitude: -83.6989288330078
    property string csv_logged_gps: "../../../qml/default/default_db/files/"
    property var track_logged: ([])

    property string ws_ip: "127.0.0.1"
    property string ws_port: "8080"
    property string ws_error: ""

    property double solver_status: 0

    property bool disable_home_button: false

    Timer {
        id: trigger_refreash_map
        property double latitude: simple_navigator_modified.latitude
        property double longitude: simple_navigator_modified.longitude
        running: simple_navigator_modified.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED
                 && (trigger_refreash_map.latitude !== simple_navigator_modified.latitude
                     || trigger_refreash_map.longitude !== simple_navigator_modified.longitude)
        repeat: false
        triggeredOnStart: false
        interval: 1 * 1000
        onTriggered: {
            var temp=0;
            if((simple_navigator_modified.latitude - trigger_refreash_map.latitude) > 0){
                temp = dashboard_Utils.rad2deg(
                            Math.atan((simple_navigator_modified.longitude - trigger_refreash_map.longitude)
                                      / (simple_navigator_modified.latitude - trigger_refreash_map.latitude)))
            }else{
                temp = 180+dashboard_Utils.rad2deg(
                            Math.atan((simple_navigator_modified.longitude - trigger_refreash_map.longitude)
                                      / (simple_navigator_modified.latitude - trigger_refreash_map.latitude)))
            }

            if (Math.abs(mapview.bearing - temp) > 10){
                mapview.bearing = temp
            }
            trigger_refreash_map.latitude = simple_navigator_modified.latitude
            trigger_refreash_map.longitude = simple_navigator_modified.longitude
            mapview.center = QtPositioning.coordinate(
                        simple_navigator_modified.latitude, simple_navigator_modified.longitude)
        }
    }

    Component.onCompleted: {
        timer_load_rcc.start()
        //ask the first http reqeust in async mode
        simple_navigator_modified.get_scenario_request();
        //set the start of the timer for the timeout
        timer_get_scenario_request.counter = Date.now();
    }

    Timer{
        id: timer_get_scenario_request
        property double counter: 0
        running: false
        repeat: true
        triggeredOnStart: false
        interval: 100
        onTriggered:{
            //text1.text=mapview.bearing
            var timeout = 5; //seconds
            //check that the timeout is not expired yet. if expired, stop the trigger and exit without loading the gps trace
            if ((Date.now() - timer_get_scenario_request.counter) > timeout*1000){
                this.stop()
                console.log("NOT Found something on Worldsim http server after timeout")
            }
            //load the gps trace if inside the timeout
            if (simple_navigator_modified.scenario_request.readyState === 4 &&
                    (Date.now() - timer_get_scenario_request.counter) < timeout*1000){
                simple_navigator_modified.load_scenario()
                this.stop()
                console.log("Found something on Worldsim http server")
            }
        }
    }
    property var scenario_request

    function get_scenario_request () {
        //get the worldsim http json
        simple_navigator_modified.scenario_request = dashboard_Utils.openFileasync(
                    "http://".concat(simple_navigator_modified.ws_ip, ":",
                                     simple_navigator_modified.ws_port,
                                     "/worldsim/scenario/"))
        timer_get_scenario_request.start()
    }

    function load_scenario(){
        var ws_scenario_file = simple_navigator_modified.scenario_request.responseText
        var ws_environment = "mcity"
        //if this json is not void
        if (ws_scenario_file !== "") {
            //parse the text into a json
            var ws_scenario_json = JSON.parse(ws_scenario_file)
            if (ws_scenario_json["errorMessage"] !== undefined) {
                //there is an error message into the http server. Usually due to scenario not yet loaded
                simple_navigator_modified.ws_error = ws_scenario_json["errorMessage"]
            } else if (ws_scenario_json["environment"]["place"]["ref"] !== undefined) {
                //this is the nominal working condition, worldsim with scenario loaded
                ws_environment = ws_scenario_json["environment"]["place"]["ref"]
            } else {
                //invalid scenairo file
                simple_navigator_modified.ws_error = "Invalid scenario file!"
            }
        } else {
            //worldsim is not yet started
            simple_navigator_modified.ws_error = "WorldSim not started at: "
                    + simple_navigator_modified.ws_ip + ":" + simple_navigator_modified.ws_port
        }

        simple_navigator_modified.csv_logged_gps = simple_navigator_modified.csv_logged_gps.concat(
                    ws_environment, ".csv")

        if (simple_navigator_modified.ws_error !== "") {
            console.log("Loaded the default " + ws_environment
                        + " track because of failure of contacting VI-WorldSim")
            console.log(simple_navigator_modified.ws_error)
        } else {
            console.log("Loading the " + ws_environment + " track ")
        }

        //loading text into a full string
        var allText = dashboard_Utils.openFile(simple_navigator_modified.csv_logged_gps)
        console.log(simple_navigator_modified.csv_logged_gps)
        //split the string by line
        var array_all_lines = allText.split("\n")
        //get the header of the csv (first)
        var header = array_all_lines[0].split(",")
        var index_latitude = -1
        var index_longitude = -1
        //get the index of the column for path s and lap time
        for (var i in header) {
            if (header[i].search(/Latitude/i) !== -1) {
                index_latitude = i
            }
            if (header[i].search(/Longitude/i) !== -1) {
                index_longitude = i
            }
        }
        if (index_latitude === -1 || index_longitude === -1) {
            //if no csv is selected, just initialize
            console.log("no valid csv")
            simple_navigator_modified.track_logged.push({
                                                   "latitude": 0,
                                                   "longitude": 0
                                               })
        } else {
            // making a first loop to check geometrical stuff like height and width
            for (i = 2; i < array_all_lines.length - 1; i = i + 1) {
                //split each line using semi column separator
                var line = array_all_lines[i].split(",")
                //setting in best lap array both path s and lap time
                simple_navigator_modified.track_logged.push({
                                                       "latitude": parseFloat(
                                                                       line[index_latitude]),
                                                       "longitude": parseFloat(
                                                                        line[index_longitude])
                                                   })
            }
        }

        line_map.path = simple_navigator_modified.track_logged
        trigger_refreash_map.latitude
                = simple_navigator_modified.track_logged[simple_navigator_modified.track_logged.length - 1].latitude
        trigger_refreash_map.longitude
                = simple_navigator_modified.track_logged[simple_navigator_modified.track_logged.length - 1].longitude

    }

    Plugin {
        id: mapPlugin
        name: "osm"

        PluginParameter {
            id: offline_plugin_dir
            name: "osm.mapping.offline.directory"
            //            value : ":/tiles/"
        }
        PluginParameter {
            name: "osm.mapping.providersrepository.address"
            value: "http://maps-redirect.qt.io/osm/5.8/street"
        }
    }
    Timer{
        id: timer_load_rcc
        running: false
        repeat: false
        triggeredOnStart: false
        interval: 1000
        onTriggered:{
            offline_plugin_dir.value = ":/tiles/"
        }
    }

    Map {
        id: mapview

        anchors.fill: parent
        maximumZoomLevel: 2000
        plugin: mapPlugin
        bearing: 0
        center: QtPositioning.coordinate(0, 0)
        zoomLevel: 20
        tilt: 45
        copyrightsVisible: true
        fieldOfView: 45
        opacity: simple_navigator_modified.solver_status
                 !== dashboard_Utils.vICRT_SOLVER_STATUS_STARTED ? 0.4 : 1
        gesture.enabled: true
        gesture.acceptedGestures: MapGestureArea.PinchGesture | MapGestureArea.PanGesture

        property variant markers
        property variant mapItems
        property int markerCounter: 0 // counter for total amount of markers. Resets to 0 when number of markers = 0
        property int currentMarker
        property int lastX: -1
        property int lastY: -1
        property int pressX: -1
        property int pressY: -1
        property int jitterThreshold: 30

        // map object ------
        MapPolyline {
            id: line_map
            opacity: 0.5
            layer.samples: 4
            layer.smooth: true
            layer.mipmap: true
            layer.enabled: true
            antialiasing: true
            line.width: 10
            line.color: dashboard_Utils.vi_azure
        }

        MapQuickItem {
            id: marker_back
            anchorPoint.x: image.width / 2
            anchorPoint.y: image.height / 2
            coordinate: QtPositioning.coordinate(simple_navigator_modified.latitude,
                                                 simple_navigator_modified.longitude)
            sourceItem: Image {
                id: image_back
                source: "../../../qml/default/default_db/images/navi_ego_back.png"
            }
            Timer {
                id: timer_mavigator
                property double increment: 0.01
                running: simple_navigator_modified.solver_status
                         === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED
                repeat: true
                interval: 400
                onTriggered: {
                    marker_back.scale = marker_back.scale + timer_mavigator.increment
                    if (marker_back.scale > 1.2) {
                        timer_mavigator.increment = -0.01
                    } else if (marker_back.scale < 1.0) {
                        timer_mavigator.increment = +0.01
                    }
                }
            }
        }
        MapQuickItem {
            id: marker
            anchorPoint.x: image.width / 2
            anchorPoint.y: image.height / 2
            coordinate: QtPositioning.coordinate(simple_navigator_modified.latitude,
                                                 simple_navigator_modified.longitude)
            sourceItem: Image {
                id: image
                source: "../../../qml/default/default_db/images/navi_ego.png"
            }
        }

        // ---------------------------------
        Image {
            id: background_map
            source: "../../../qml/default/default_db/images/simple_navigator_back.png"
            anchors.fill: parent
        }
    }

    AnimatedImage {
        id: waiting_gps
        anchors.verticalCenter: parent.verticalCenter
        source: "../../../qml/default/default_db/images/waiting_gps.gif"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        visible: simple_navigator_modified.solver_status !== dashboard_Utils.vICRT_SOLVER_STATUS_STARTED
    }

    Button_item_mouse {
        id: exit_to_home
        width: 150
        height: 150
        visible: !simple_navigator_modified.disable_home_button
        button_icon_value: "../../../qml/default/default_db/images/home_icon.png"
        button_background_color_value: dashboard_Utils.vi_red
        anchors.verticalCenterOffset: 500
        button_icon_scale_value: 2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onReleased: {
            root.state = "home"
        }
    }
    Dashboard_Utils {
        id: dashboard_Utils
    }



}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/

