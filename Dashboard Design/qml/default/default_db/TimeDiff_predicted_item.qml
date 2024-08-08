import QtQuick 2.12



Item {    
    width: 400
    height: 120

    id: diff_predicted_time_item

    property alias diff_predicted_time_backgroundColor: diff_predicted_time_background.color

    property int lap_diff_type: 0  //calculation type of diff and predicted time.
    property double lap_time_value: 0
    property double lap_num: 0
    property double lap_num_memory: 0
    property double lap_best_time_value: 0
    property double lap_diff_value: 0
    property string best_laptime_text: "0 : 00 . 000"


    property double path_s: 0
    property double solver_status: 0

    property double reset_diff_value: 0

    property var current_complete_lap: ([])
    property var best_complete_lap: ([])

    property string csv_file: ""
    property string csv_lap_time_string_header: "Vicrt_Lap_Time"        // csv drivesim: "VI_DriveSim.Outputs.Vicrt.Lap.Time"
    // csv winTAX: "Vicrt_Lap_Time"
    property string csv_path_s_string_header: "path_sensor_path_s"      // csv drivesim: "VI_CarRealTime.Outputs.driving_machine_monitor.path_s"
    // csv winTAX: "path_sensor_path_s"

    onSolver_statusChanged: {
        if (diff_predicted_time_item.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STOPPED){
            diff_predicted_time_item.current_complete_lap = diff_predicted_time_item.current_complete_lap.slice(0,1)
        }
    }



    Component.onCompleted: {
        if (diff_predicted_time_item.csv_file === ""){
            //if no csv is selected, just initialize
            console.log("resetting best lap array")
            diff_predicted_time_item.best_complete_lap.push({path_s: 0, time: 0})
        }else{
            //if csv is selected, load it into the best lap
            //requesting the csv file and loading into memory
            console.log("start loading csv file for diff time")
            var rawFile = new XMLHttpRequest();
            console.log("cheching state of the text = " + rawFile.readyState) //checking state
            rawFile.open("GET", diff_predicted_time_item.csv_file, false);
            rawFile.send(null);
            console.log("DONE cheching state of the text = " + rawFile.readyState)
            //loading text into a full string
            var allText = rawFile.responseText;
            //split the string by line
            var array_all_lines = allText.split("\n")
            var separator_semicolumn = ";";
            var separator_comma = ",";
            //get the header of the csv (first)
            var header = array_all_lines[0].split(separator_semicolumn);
            var index_path_s = -1;
            var index_lap_time = -1;
            //get the index of the column for path s and lap time
            for (var i in header){
                if (header[i] === diff_predicted_time_item.csv_path_s_string_header){
                    index_path_s = i
                }
                if (header[i] === diff_predicted_time_item.csv_lap_time_string_header){
                    index_lap_time = i
                }
            }
            if (index_path_s === -1 || index_lap_time === -1){
                //if no csv is selected, just initialize
                console.log("resetting best lap array -- no valid csv")
                diff_predicted_time_item.best_complete_lap.push({path_s: 0, time: 0})
            }else{
                // making a first loop to check geometrical stuff like height and width
                for (i = 2; i < array_all_lines.length-1; i = i + 1) {
                    //split each line using semi column separator
                    var line = array_all_lines[i].split(separator_semicolumn);
                    //setting in best lap array both path s and lap time
                    diff_predicted_time_item.best_complete_lap.push({path_s: parseFloat(line[index_path_s]), time: parseFloat(line[index_lap_time])})
                }
            }
        }
        console.log("finish loading csv file for diff time")

        //initialize current complete lap
        diff_predicted_time_item.current_complete_lap.push({path_s: 0, time: 0})
    }

    Timer{
        id: timer_
        property double best_laptime_number: dashboard_Utils.lap_string_to_num(diff_predicted_time_item.best_laptime_text)
        //running only when running
        running: diff_predicted_time_item.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED &&
                 diff_predicted_time_item.lap_diff_type === 0
        repeat: true
        interval: (1/5)*1000
        onTriggered: {

            //delete current if we go back one lap with restore
            if (diff_predicted_time_item.lap_num_memory > diff_predicted_time_item.lap_num){
                diff_predicted_time_item.current_complete_lap = diff_predicted_time_item.current_complete_lap.slice(0,1)
            }

            //check if the actual path s is less than the last one of the current array. this indicates a restore point
            //so that it is needed a deletion of points up to the restored one
            //since this timer is triggered only in start, multiple restore points are managed
            if (diff_predicted_time_item.path_s > 50 &&
                    diff_predicted_time_item.path_s < diff_predicted_time_item.current_complete_lap[diff_predicted_time_item.current_complete_lap.length-1].path_s &&
                    diff_predicted_time_item.current_complete_lap.length > 2){
                //check inside the complete current array
                for (var item2 in diff_predicted_time_item.current_complete_lap){
                    //check the first paths higher than the current one
                    if (diff_predicted_time_item.path_s < diff_predicted_time_item.current_complete_lap[parseInt(item2)].path_s){
                        //slice the current array from the first point to the first paths higher than the current one
                        diff_predicted_time_item.current_complete_lap = diff_predicted_time_item.current_complete_lap.slice(0,parseInt(item2))
                        break
                    }
                }
            }

            //do not add points when they are null. this is needed when no path sensor is present to avoid push arrays unuseful
            if (diff_predicted_time_item.path_s !== 0){
                diff_predicted_time_item.current_complete_lap.push(
                            {path_s: diff_predicted_time_item.path_s, time: diff_predicted_time_item.lap_time_value})
            }

            var check_sanity = true;

            //when: the lap is changed, the current lap array last element is lower than the best lap array last element, OR when entering lap 1 from lap 0
            if (diff_predicted_time_item.lap_num_memory < diff_predicted_time_item.lap_num &&
                    diff_predicted_time_item.best_complete_lap[diff_predicted_time_item.best_complete_lap.length-1].time > diff_predicted_time_item.current_complete_lap[diff_predicted_time_item.current_complete_lap.length-2].time ||
                    (diff_predicted_time_item.lap_num_memory === 0 && diff_predicted_time_item.lap_num === 1 && diff_predicted_time_item.lap_diff_value === 0)|| //first lap trigger
                    (diff_predicted_time_item.lap_diff_value === 0 && diff_predicted_time_item.lap_num_memory < diff_predicted_time_item.lap_num) ){

                //check if the current array is good (does not contain voids inside)
                for (var index in diff_predicted_time_item.current_complete_lap){
                    if ((parseInt(index) > 0) &&
                        (parseInt(index)< (diff_predicted_time_item.current_complete_lap.length-1)) &&
                        (Math.abs(diff_predicted_time_item.current_complete_lap[parseInt(index)].path_s - diff_predicted_time_item.current_complete_lap[parseInt(index)-1].path_s) > 50)){
                        check_sanity = false;
                        break
                    }
                }

                if (check_sanity &&
                    diff_predicted_time_item.current_complete_lap.length > 2){
                    //fill the best lap array with the current one. Deleting also the last element that is the first of the next lap
                    diff_predicted_time_item.best_complete_lap = diff_predicted_time_item.current_complete_lap.slice(0,diff_predicted_time_item.current_complete_lap.length-1)
                }
                //resetting current lap array
                diff_predicted_time_item.current_complete_lap = diff_predicted_time_item.current_complete_lap.slice(0,1)

            }

            //check in the best lap array
            for (var item in diff_predicted_time_item.best_complete_lap){
                //find the first paths higher than current paths AND in a best array with at least one valid point (over the first that is 0 by default)
                if (diff_predicted_time_item.path_s < diff_predicted_time_item.best_complete_lap[parseInt(item)].path_s &&
                        diff_predicted_time_item.best_complete_lap.length > 2){
                    // diff is equal to the difference between current lap time and reference best one
                    diff_predicted_time_item.lap_diff_value = diff_predicted_time_item.lap_time_value - diff_predicted_time_item.best_complete_lap[parseInt(item)-1].time
                    //predicted lap time is equal to the best last point time + diff time  predicted_time_text_.text = dashboard_Utils.lap_current_fcn(dashboard_Utils.saturation(diff_predicted_time_item.best_complete_lap[diff_predicted_time_item.best_complete_lap.length-1].time + diff_predicted_time_item.lap_diff_value,0,100000000000000))
                    if (diff_predicted_time_item.csv_file !== "" && diff_predicted_time_item.lap_num === 0){/*do not update predicted in this condition*/}else{
                        predicted_time_text_.text = dashboard_Utils.lap_predicted_fcn(dashboard_Utils.saturation(timer_.best_laptime_number + diff_predicted_time_item.lap_diff_value,0,100000000000000))
                    }

                    break
                }
            }
            //set lap num memory
            diff_predicted_time_item.lap_num_memory = diff_predicted_time_item.lap_num
        }
    }
    Rectangle {
        id: diff_predicted_time_background
        width: 400
        height: 120
        color: dashboard_Utils.vi_transparent
        radius: width/20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: diff_predicted_time_text
        x: 0
        width: 127
        height: 32
        color: dashboard_Utils.vi_yellow
        text: "Diff"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        rightPadding: 20
        anchors.verticalCenterOffset: -30
        font.family: "Sansation"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -65
    }

    Text {
        id: diff_predicted_time_text_
        y: 102
        width: 200
        height: 65
        color: diff_predicted_time_item.lap_diff_value > 0 ? dashboard_Utils.vi_red:
                                                             dashboard_Utils.vi_green
        text: diff_predicted_time_item.lap_diff_value > 0 ? "+" + Math.abs(diff_predicted_time_item.lap_diff_value).toFixed(2):
                                                            "-" + Math.abs(diff_predicted_time_item.lap_diff_value).toFixed(2)
        elide: Text.ElideRight
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 50
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenterOffset: 20
        anchors.horizontalCenterOffset: -102
        anchors.horizontalCenter: parent.horizontalCenter
        rightPadding: 10
        anchors.topMargin: 68
        font.family: "Open Sans"
        layer.smooth: true

    }

    Text {
        id: predicted_time_text
        width: 178
        height: 32
        color: dashboard_Utils.vi_yellow
        text: "Predicted"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: 20
        anchors.verticalCenterOffset: -30
        font.family: "Sansation"
        layer.smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 87
    }

    Text {
        id: predicted_time_text_
        y: 147
        width: 202
        height: 65
        color: dashboard_Utils.vi_cream
        text: "0 : 00 . 00"
        elide: Text.ElideRight

        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 35
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenterOffset: 81
        anchors.horizontalCenter: parent.horizontalCenter
        rightPadding: 10
        anchors.verticalCenterOffset: 25
        font.family: "Open Sans"
        layer.smooth: true
        anchors.topMargin: 135
    }

    Rectangle {
        id: separator
        width: 2
        height: 100
        radius: width/20
        anchors.verticalCenter: parent.verticalCenter
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop {
                position: 0
                color: dashboard_Utils.vi_transparent
            }

            GradientStop {
                position: 0.1
                color: dashboard_Utils.vi_light_grey
            }

            GradientStop {
                position: 0.9
                color: dashboard_Utils.vi_light_grey
            }

            GradientStop {
                position: 1
                color: dashboard_Utils.vi_transparent
            }


        }
        anchors.horizontalCenter: parent.horizontalCenter
    }

    onReset_diff_valueChanged: {
        if (diff_predicted_time_item.reset_diff_value !== 0 && diff_predicted_time_item.lap_diff_type === 0){
            //diff_predicted_time_item.current_complete_lap = diff_predicted_time_item.current_complete_lap.slice(0,1)
            diff_predicted_time_item.best_complete_lap = diff_predicted_time_item.best_complete_lap.slice(0,1)
            diff_predicted_time_item.lap_diff_value = 0
            //predicted lap time is equal to the best last point time + diff time
            predicted_time_text_.text = dashboard_Utils.lap_predicted_fcn(0)

            console.log("reset the best lap for diff")
        }
    }
    Dashboard_Utils{
        id: dashboard_Utils
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:2;height:120;width:400}D{i:14}
}
##^##*/
