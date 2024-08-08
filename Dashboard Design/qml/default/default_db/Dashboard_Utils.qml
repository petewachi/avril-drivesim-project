import QtQuick 2.12

Item {
    id: dashboard_Utils




    //colors
    property color vi_yellow: "#ffd611"
    property color vi_yellow_2: "#fdb520"
    property color vi_red: "#e10000"
    property color vi_white: "#ffffff"
    property color vi_cream: "#d7d7d7"
    property color vi_light_grey: "#C0C0C0"
    property color vi_grey: "#3d3d3d"
    property color vi_dark_grey: "#0f0f0f"
    property color vi_green: "#00B050"
    property color vi_acid_green: "#a5f760"
    property color vi_petrol: "#316067"
    property color vi_transparent: "#00ffffff"
    property color vi_fucsia: "#aa3de1"
    property color vi_black: "#000000"
    property color vi_azure: "#3DAEE9"
    property color vi_orange: "#FF7F00"

    //vehicle solver status
    property double vICRT_SOLVER_STATUS_OK:             0
    property double vICRT_SOLVER_STATUS_STARTED:        1
    property double vICRT_SOLVER_STATUS_STOPPED:        2
    property double vICRT_SOLVER_STATUS_PAUSED:         3

    // cueign status
    property double cUEING_STATUS_STARTED:              0
    property double cUEING_STATUS_PAUSED:               1
    property double cUEING_STATUS_STOPPED:              2
    property double cUEING_STATUS_RAMPING_UP:           3
    property double cUEING_STATUS_RAMPING_DOWN:         4
    property double cUEING_STATUS_OPTSOLVER_CRASH:      5
    property double cUEING_STATUS_WAITINIT:             6
    property double cUEING_STATUS_WAITENG:              7
    property double cUEING_STATUS_KILLED:               8
    property double cUEING_SAFE_WAIT:                   9
    property double cUEING_SAFE_WAIT1:                  10
    property double cUEING_SAFE_WAIT2:                  11
    property double cUEING_SAFE_WAIT3:                  12
    property double cUEING_SAFE_WAIT4:                  13
    property double cUEING_SAFE_WAIT5:                  14
    property double cUEING_SAFE_WAIT6:                  15
    property double cUEING_SAFE_WAIT7:                  16
    property double cUEING_SAFE_WAIT8:                  17
    property double cUEING_SAFE_WAIT9:                  18

    //cueing requests
    property double cUEING_REQUEST_NONE:                0
    property double cUEING_REQUEST_RAMP_DOWN:           1
    property double cUEING_REQUEST_RAMP_UP:             2
    property double cUEING_REQUEST_PAUSE:               3
    property double cUEING_REQUEST_REINIT:              4
    property double cUEING_REQUEST_STOP:                5
    property double cUEING_REQUEST_RESTART:             6
    property double cUEING_REQUEST_ENGAGE:              7
    property double cUEING_REQUEST_KILL:                8

    //platform limits. default DiM400
    property double pos_long_max:                       1.95    //m
    property double pos_lat_max:                        1.95    //m
    property double pos_yaw_max:                        1       //rad

    // platform operation status
    property double pLATFORM_STATUS_READY: 0
    property double pLATFORM_STATUS_HALTED: 1

    //  hmi platform status
    property double hMI_STATUS_READY: 0
    property double hMI_STATUS_STOP: 1
    property double hMI_STATUS_STATUS: 2                //just after pressing start from sag pc

    // stream status
    property double sTREAM_STATUS_READY: 1
    property double sTREAM_STATUS_NOT_READY: 0

    //platforms limits
    property var longitudinal_limit: {
        150 : 0.9,
        250 : 1.6,
        400 : 1.95
    }
    property var lateral_limit: {
        150 : 0.85,
        250 : 1.5,
        400 : 1.95
    }
    property var yaw_limit: {
        150 : 0.6,
        250 : 0.6,
        400 : 1.0
    }
    property var vert_limit: {
        150 : 0.22,
        250 : 0.22,
        400 : 0.285
    }

    //drivesim connection properties (to be used in conjuction with driveSim_conneciton and driveSim_timeout_function ())
    property alias driveSim_activity: driveSim_connection.activity
    property alias driveSim_timeout: driveSim_connection.timeout

    //lap alias
    property alias lap_last: internal_variables_lastlap.lap_time_last
    property alias lap_best: internal_variables_bestlap.lap_time_best
    property alias lap_best_crt: internal_variables_bestlap_crt.lap_time_best

    //phase & kollmorgen drive status
    property double drive_ph_ok: 55
    property double drive_ph_ok_20213: 183
    property double drive_ph_cable_disabled: 8  //when unplugging encoder cable
    property double drive_km_ok: 567
    property double drive_ph_km_disabled: 0
    property double drive_ph_km_safety: -1


    //timer that defines timeout before telling to qml that iodb_dashboard is disconnected
    Timer{
        //define if the qml is connected or not with DriveSim
        property bool activity: false
        //define the interval of timeout before switching to stopped simulation in seconds
        property int timeout: 1

        id: driveSim_connection

        triggeredOnStart: false
        running: false
        repeat: false
        interval: driveSim_connection.timeout*1000
        onTriggered: {
            //putting connection to off state after timeout is reached
            driveSim_connection.activity = false
        }

    }

    //function that keeps alive driveSim_activity while iodb_dashboard is connected
    function driveSim_timeout_function (){
        driveSim_connection.restart()
    }


    // resetting lap by pressing R on keyboard
//    focus: true
//    Keys.onPressed: {
//        if (event.key === Qt.Key_R) {
//            internal_variables_bestlap.lap_time_best = 0;
//            console.log("reset the best lap")
//        }

//        //debugging offline
//        if (event.key === Qt.Key_Left) {
//            root.page_number = dashboard_Utils.saturate(root.page_number,-1,1,(Object.keys(root.state_names).length-2))
//            root.state = root.state_names[root.page_number]
//        }
//        if (event.key === Qt.Key_Right) {
//            root.page_number = dashboard_Utils.saturate(root.page_number,1,1,(Object.keys(root.state_names).length-2))
//            root.state = root.state_names[root.page_number]
//        }
//        if (event.key === Qt.Key_P) {
//            root.pit_limiter_activity = !root.pit_limiter_activity
//        }

//        if (event.key === Qt.Key_A) {
//            root.knob_LL = root.knob_LL + 10
//        }

//        if (event.key === Qt.Key_S) {
//            root.knob_L = root.knob_L - 10
//        }

//        if (event.key === Qt.Key_D) {
//            root.knob_R = root.knob_R + 1
//        }

//        if (event.key === Qt.Key_F) {
//            root.knob_RR = root.knob_RR - 1
//        }
//        if (event.key === Qt.Key_C) {
//            root.incoming_call_trigger = root.incoming_call_trigger + 1
//        }
//    }


    //gear function
    function gear_to_string (gear){
        var gear_selected = "";
        switch (gear) {
        case 0:
            gear_selected = "N";
            break;
        case -1:
            gear_selected = "R";
            break;
        default:
            gear_selected = gear.toFixed(0);
            break;
        }
        return gear_selected;
    }

    //lap time functions
    function seconds (t){
        return Math.floor(t % 60)
    }

    function minutes(t){
        return Math.floor((Math.floor(t) - seconds(t))/60);
    }

    function cents(t){
        return Math.floor((t - Math.floor(t))*100);
    }

    function mils(t){
        return Math.floor((t - Math.floor(t))*1000);
    }

    //convert a to string with precision 0 and 2 digits
    function two_dig(a){

        a = a.toFixed(0)
        a = a.padStart(2, "0");
        return a

    }

    //convert a to string with precision 0 and 3 digits
    function three_dig(a){

        a = a.toFixed(0)
        a = a.padStart(3, "0");
        return a

    }

    //returns the lap  as min:sec.millis  0:00.000 string
    function lap_current_fcn (lap_time){

        return ((minutes(lap_time))+" : " +
                two_dig(seconds(lap_time))+" . " +
                three_dig(mils  (lap_time)))

    }

    //returns the lap  as min:sec.cents  0:00.00 string
    function lap_predicted_fcn (lap_time){

        return ((minutes(lap_time))+" : " +
                two_dig(seconds(lap_time))+" . " +
                two_dig(cents (lap_time)))

    }

    Item {
        id: internal_variables_lastlap

        //lap time variables
        property double lap_num_memory: 0
        property double lap_time_last: 0
        property double lap_time_memory: 0
        property double lap_time_best: 0
    }

    //returns the last lap computed inside the dashboard as min:sec.cents  00:00.00 string
    function lap_last_fcn (lap_time,lap_num){
        if ( internal_variables_lastlap.lap_num_memory< lap_num){

            internal_variables_lastlap.lap_time_last = internal_variables_lastlap.lap_time_memory;

        }

        internal_variables_lastlap.lap_num_memory = lap_num;
        internal_variables_lastlap.lap_time_memory = lap_time;




        return ((minutes(internal_variables_lastlap.lap_time_last))+" : " +
                two_dig(seconds(internal_variables_lastlap.lap_time_last))+" . " +
                three_dig(mils  (internal_variables_lastlap.lap_time_last)))
    }

    Item {
        id: internal_variables_bestlap

        //lap time variables
        property double lap_num_memory
        property double lap_time_last
        property double lap_time_memory
        property double lap_time_best
    }


    //returns the best lap computed inside the dashboard as min:sec.cents  00:00.00 string
    function lap_best_fcn (lap_time,lap_num){

        if (internal_variables_bestlap.lap_num_memory < lap_num &&
                internal_variables_bestlap.lap_time_best == 0){

            internal_variables_bestlap.lap_time_best = internal_variables_bestlap.lap_time_memory;

        }else if(internal_variables_bestlap.lap_num_memory < lap_num &&
                 internal_variables_bestlap.lap_time_best != 0 &&
                 internal_variables_bestlap.lap_time_memory < internal_variables_bestlap.lap_time_best){

            internal_variables_bestlap.lap_time_best = internal_variables_bestlap.lap_time_memory;

        }

        internal_variables_bestlap.lap_num_memory = lap_num;
        internal_variables_bestlap.lap_time_memory = lap_time;


        return ((minutes(internal_variables_bestlap.lap_time_best))+" : " +
                two_dig(seconds(internal_variables_bestlap.lap_time_best))+" . " +
                three_dig(mils(internal_variables_bestlap.lap_time_best)))
    }


    Item {
        id: internal_variables_bestlap_crt

        //lap time variables
        property double lap_num_memory
        property double lap_time_last
        property double lap_time_memory
        property double lap_time_best
    }


    //returns the best lap computed inside the dashboard as min:sec.cents  00:00.00 string
    function lap_best_crt_fcn (lap_last_crt){

        if (lap_last_crt !== internal_variables_bestlap_crt.lap_time_last &&
            internal_variables_bestlap_crt.lap_time_best === 0){
                    internal_variables_bestlap_crt.lap_time_best = lap_last_crt;

         }else if (lap_last_crt < internal_variables_bestlap_crt.lap_time_best &&
                   internal_variables_bestlap_crt.lap_time_best !== 0 &&
                   lap_last_crt !== 0){

            internal_variables_bestlap_crt.lap_time_best = lap_last_crt;
        }

        internal_variables_bestlap_crt.lap_time_last = lap_last_crt


        return ((minutes(internal_variables_bestlap_crt.lap_time_best))+" : " +
                two_dig(seconds(internal_variables_bestlap_crt.lap_time_best))+" . " +
                three_dig(mils  (internal_variables_bestlap_crt.lap_time_best)))
    }

    //returns the number from a string
    function lap_string_to_num (lap_time_string){
        var test_internal =lap_time_string.split(":")
        var test_internal_2 =test_internal[test_internal.length-1].split(".")
        var lap_time_number = parseInt(test_internal_2[0]) + parseInt(test_internal_2[test_internal_2.length-1])/1000 + parseInt(test_internal[0])*60
        return lap_time_number
    }

    //convert speed into mph in case mph_activity is true
    function update_speed (velocity, mph_activity){
        if (mph_activity){
            velocity = (velocity * 0.621371) ;   //conversion to miles per hour
        }
        if (velocity < 0){
            velocity = -velocity
        }

        return velocity
    }

    //this function resize the scale of the content by using standard width and height
    function resize_content (width, height, std_width, std_height){
        var aspect_ratio = width/height
        var scale = 1
        if (aspect_ratio < (std_width/std_height)){
            scale = width / std_width
        }else{
            scale = height / std_height
        }
        return scale
    }


    function update_cueing_status_text (cueing_status, solver_status, operation_status,
                                        stream_status, hmi_status,
                                        status_cueing_limit_long_pitch,status_cueing_limit_lat_roll
                                        ,status_cueing_limit_yaw,status_cueing_limit_vert,
                                        cueing_request){

        // if no stream is given, display a "disabled" message ( || pos_forstatus === 0.0)
        if (solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STOPPED ||
                solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_OK){
            if (cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_DOWN){
                //show ramp down when stop is triggered from the drivesim ui during started cueing
                return "RAMP DOWN"
            }else{
                return "DISABLED"
            }            
            // if something arrives, it shows cueing status
        }else{

            if (cueing_status === dashboard_Utils.cUEING_STATUS_STARTED){
                // show up the safety log just when soft stop is reached
                if (dashboard_Utils.is_soft_stop(status_cueing_limit_long_pitch,status_cueing_limit_lat_roll
                                 ,status_cueing_limit_yaw,status_cueing_limit_vert)){
                    return "STARTED Soft Lim"
                }else{
                    return "STARTED"
                }
                //return green
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_PAUSED){
                return "READY PAUSE"
                //return green
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_STOPPED ||
                      cueing_status === dashboard_Utils.cUEING_STATUS_OPTSOLVER_CRASH ||
                      cueing_status === dashboard_Utils.cUEING_STATUS_KILLED){
                return "KILLED"
                //return red
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_UP){
                return "RAMP UP"
                //return yellow
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_DOWN){
                return "RAMP DOWN"
                //return yellow
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_WAITINIT){
                return "WAIT INIT"
                //return yellow
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_WAITENG){
                // this is used on dim not cable to fix initial status
                /*if (operation_status === dashboard_Utils.pLATFORM_STATUS_READY      &&
                        hmi_status === dashboard_Utils.hMI_STATUS_STATUS             &&
                        cueing_request === dashboard_Utils.cUEING_REQUEST_NONE)
                {
                    return "READY PAUSE"
                }*/
                return "WAIT platform"
                //return yellow
            }else if (cueing_status >= dashboard_Utils.cUEING_SAFE_WAIT && cueing_status <= dashboard_Utils.cUEING_SAFE_WAIT9){
                // for version < 2023 --> return qsTr("SAFE WAIT (" + (cueing_status - dashboard_Utils.cUEING_SAFE_WAIT) + ")")
                return qsTr("SAFE WAIT")
                //return yellow
            }else if (operation_status === dashboard_Utils.pLATFORM_STATUS_HALTED    ||
                     stream_status === dashboard_Utils.sTREAM_STATUS_NOT_READY      ||
                     hmi_status === dashboard_Utils.hMI_STATUS_STOP)
            {
                //check platform availability
                return "DISABLED"
            }else{
                return "GENERAL ERROR"
                //return red
            }
        }
    }


    function update_cueing_status_color (cueing_status, solver_status, operation_status,
                                         stream_status, hmi_status,
                                         status_cueing_limit_long_pitch,status_cueing_limit_lat_roll,
                                         status_cueing_limit_yaw,status_cueing_limit_vert,
                                         cueing_request){

        // if no stream is given, display a "disabled" message ( || pos_forstatus === 0.0)
        if (solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STOPPED ||
            solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_OK){
            //return "DISABLED"
            return dashboard_Utils.vi_yellow_2
            // if something arrives, it shows cueing status
        }else{
            if (cueing_status === dashboard_Utils.cUEING_STATUS_STARTED){
                if (dashboard_Utils.is_soft_stop(status_cueing_limit_long_pitch,status_cueing_limit_lat_roll
                                 ,status_cueing_limit_yaw,status_cueing_limit_vert)){
                    return dashboard_Utils.vi_acid_green
                }else{
                    return dashboard_Utils.vi_green
                }
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_PAUSED){
                return dashboard_Utils.vi_green
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_STOPPED ||
                      cueing_status === dashboard_Utils.cUEING_STATUS_OPTSOLVER_CRASH ||
                      cueing_status === dashboard_Utils.cUEING_STATUS_KILLED){
                return dashboard_Utils.vi_red
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_UP){
                return dashboard_Utils.vi_yellow_2
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_DOWN){
                return dashboard_Utils.vi_yellow_2
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_WAITINIT || cueing_status === dashboard_Utils.cUEING_STATUS_WAITENG){                
                // this is used on dim not cable to fix initial status
                /*if (operation_status === dashboard_Utils.pLATFORM_STATUS_READY      &&
                        hmi_status === dashboard_Utils.hMI_STATUS_STATUS            &&
                        cueing_request === dashboard_Utils.cUEING_REQUEST_NONE){
                    return dashboard_Utils.vi_green
                }*/
                return dashboard_Utils.vi_yellow_2
            }else if (cueing_status >= dashboard_Utils.cUEING_SAFE_WAIT && cueing_status <= dashboard_Utils.cUEING_SAFE_WAIT9){
                return dashboard_Utils.vi_yellow_2
            }else if (operation_status === dashboard_Utils.pLATFORM_STATUS_HALTED    ||
                      stream_status === dashboard_Utils.sTREAM_STATUS_NOT_READY      ||
                      hmi_status === dashboard_Utils.hMI_STATUS_STOP){
                //check platform availability
                return dashboard_Utils.vi_yellow_2
            }else{
                return dashboard_Utils.vi_red
            }
        }
    }

    function update_cueing_safety (cueing_status, solver_status, operation_status,
                                   stream_status, hmi_status,
                                   status_cueing_limit_long_pitch,status_cueing_limit_lat_roll
                                   ,status_cueing_limit_yaw,status_cueing_limit_vert,
                                   cueing_request){

        // if no stream is given, display a "disabled" message
        if (solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STOPPED ||
                solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_OK){
            return false
        // if something arrives, it shows cueing status
        }else{
            // in this portion, the regular update is done of the status
            if (cueing_status === dashboard_Utils.cUEING_STATUS_STARTED){
                // show up the safety log just when soft stop is reached
                if (dashboard_Utils.is_soft_stop(status_cueing_limit_long_pitch,status_cueing_limit_lat_roll
                                 ,status_cueing_limit_yaw,status_cueing_limit_vert)){
                    return true
                }else{
                    return false
                }
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_PAUSED){
                return false
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_STOPPED  ||
                      cueing_status === dashboard_Utils.cUEING_STATUS_OPTSOLVER_CRASH        ||
                      cueing_status === dashboard_Utils.cUEING_STATUS_KILLED){
                return true
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_UP){
                return false
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_RAMPING_DOWN){
                return false
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_WAITINIT){
                return false
            }else if (cueing_status === dashboard_Utils.cUEING_STATUS_WAITENG){
                // this is used on dim<=250 to fix initial status
                if (operation_status === dashboard_Utils.pLATFORM_STATUS_READY      &&
                        hmi_status === dashboard_Utils.hMI_STATUS_STATUS             &&
                        cueing_request === dashboard_Utils.cUEING_REQUEST_NONE){
                    return false
                }
                return false
            }else if ( dashboard_Utils.cUEING_SAFE_WAIT<= cueing_status  && cueing_status <=dashboard_Utils.cUEING_SAFE_WAIT9 ){
                return true
            }else{
                return true
            }
        }

    }

    //if there is an hard stop during cueing operations
    function is_hard_stop (status_xy, status_yx, status_za, status_zv)
    {
        if ( 0<status_xy && status_xy<51 )
        {
            return true
        }
        else if ( 0<status_yx && status_yx<51 )
        {
            return true
        }
        else if ( 0<status_za && status_za!==5 && status_za!==6 )
        {
            return true
        }
        else if ( 0<status_zv && status_zv!==5 )
        {
            return true
        }
        else
        {
            return false;
        }
    }

    //if there is a soft stop during cueing operations
    function is_soft_stop (status_xy, status_yx, status_za, status_zv)
    {
        if ( 50<status_xy && status_xy<55 )
        {
            return true
        }
        else if ( 50<status_yx && status_yx<55 )
        {
            return true
        }
        else if ( status_za===5 && status_za===6 && status_za===7 )
        {
            return true
        }
        else if ( status_zv===5 )
        {
            return true
        }
        else
        {
            return false;
        }
    }

    //text for the safety exit from cueing
    function safety_logic_text (status_xy, status_yx, status_za, status_zv){

        var limit_type = "No platform available"

        if (dashboard_Utils.is_hard_stop(status_xy, status_yx, status_za, status_zv))
        {
            limit_type = "HARD STOP\n"
        }
        else if (dashboard_Utils.is_soft_stop(status_xy, status_yx, status_za, status_zv))
        {
            limit_type = "SOFT STOP\n"
        }

        if ( 0<status_xy && status_xy<55 )
        {
            switch (status_xy)
            {
            // hard stop
            case 1:  return limit_type + "Optimizer";
            case 3:  return limit_type + "High input";
            case 21: return limit_type + "Pitch vel limit";
            case 22: return limit_type + "Pitch ang limit";
            case 23: return limit_type + "Lon pos limit";
            case 24: return limit_type + "Lon vel limit";
            case 25: return limit_type + "Lon acc limit";
            case 26: return limit_type + "Pitch acc limit";
            case 27: return limit_type + "Lon pos HF limit";
            case 28: return limit_type + "Lon vel HF limit";
            case 29: return limit_type + "Lon acc HF limit";
            case 30: return limit_type + "Lon pos LF limit";
            case 31: return limit_type + "Lon vel LF limit";
            case 32: return limit_type + "Lon acc LF limit";
            case 33: return limit_type + "Lon vel/pos limit";

            // soft stop
            case 51: return limit_type + "Pitch ang limit";
            case 52: return limit_type + "Lon pos limit";
            case 53: return limit_type + "Lon pos limit hexa";
            case 54: return limit_type + "Lon pos limit disk";
            }
        }
        else if ( 0<status_yx && status_yx<55 )
        {
            switch (status_yx)
            {
            // hard stop
            case 1:  return limit_type + "Optimizer";
            case 3:  return limit_type + "High input";
            case 21: return limit_type + "Roll vel limit";
            case 22: return limit_type + "Roll ang limit";
            case 23: return limit_type + "Lat pos limit";
            case 24: return limit_type + "Lat vel limit";
            case 25: return limit_type + "Lat acc limit";
            case 26: return limit_type + "Roll acc limit";
            case 27: return limit_type + "Lat pos HF limit";
            case 28: return limit_type + "Lat vel HF limit";
            case 29: return limit_type + "Lat acc HF limit";
            case 30: return limit_type + "Lat pos LF limit";
            case 31: return limit_type + "Lat vel LF limit";
            case 32: return limit_type + "Lat acc LF limit";
            case 33: return limit_type + "Lat vel/pos limit";

            // soft stop
            case 51: return limit_type + "Roll ang limit";
            case 52: return limit_type + "Lat pos limit";
            case 53: return limit_type + "Lat pos limit hexa";
            case 54: return limit_type + "Lat pos limit disk";
            }
        }
        else if ( 0<status_za )
        {
            switch (status_za)
            {
            // hard stop
            case 1:  return limit_type + "Optimizer";
            case 3:  return limit_type + "High input";
            case 21: return limit_type + "Yaw vel limit";
            case 22: return limit_type + "Yaw ang limit";
            case 23: return limit_type + "Yaw acc limit";
            case 24: return limit_type + "Yaw vel HF limit";
            case 25: return limit_type + "Yaw ang HF limit";
            case 26: return limit_type + "Yaw acc HF limit";
            case 27: return limit_type + "Yaw vel LF limit";
            case 28: return limit_type + "Yaw ang LF limit";
            case 29: return limit_type + "Yaw acc LF limit";
            case 33: return limit_type + "Yaw vel/pos limit";

            // soft stop
            case 5: return limit_type + "Yaw ang limit";
            case 6: return limit_type + "Yaw ang limit hexa";
            case 7: return limit_type + "Yaw ang limit disk";
            }
        }
        else if ( 0<status_zv )
        {
            switch (status_zv)
            {
            //hard stop
            case 1:  return limit_type + "Optimizer";
            case 3:  return limit_type + "High input";
            case 21: return limit_type + "Vertical pos limit";
            case 22: return limit_type + "Vertical vel limit";
            case 23: return limit_type + "Vertical acc limit";
            case 33: return limit_type + "Vert vel/pos limit";

            // soft stop
            case 5: return limit_type + "Vert pos limit";
            }
        }
        else
        {
            return limit_type + "";
        }

    }


    //visibility of steering wheel
    function update_visibility_on_solver_status (solver_status, forced_visibility){
        // setting the visibility depending on solver status (visible only on pause)
        if (forced_visibility){
            return true
        }else{
            if (solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED ||
                    solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_OK){
                return true
            }else{
                return false
            }
        }

    }

    //return correct steering wheel image depending on solver_status
    function update_str_wheel_image (str_wheel_value, solver_status){

        if (solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED){
            if (Math.abs(str_wheel_value) < 0.15){
                return "images/SteeringWheel_green.png"
            }else{
                return "images/SteeringWheel_red.png"
            }
        }else{
            return "images/SteeringWheel_grey.png"
        }
    }

    //return 1 when need to realign the steering clockwise, -1 counterclockwise
    function update_str_wheel_red_indication (str_wheel_value, solver_status){

        if (solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_PAUSED){
            if ((str_wheel_value) > 0.15){
                return 1
            }else if ((str_wheel_value) < -0.15){
                return -1
            }else{
                return 0
            }
        }else{
            return 0
        }
    }

    //update_drive_ status text
    function update_drive_status_text (drive_status, drive_fault, drive_program_status, solver_status){
        if(solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STOPPED ||
           solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_OK ||
           drive_program_status === dashboard_Utils.drive_ph_km_disabled){
            return "DISABLED"
//            return dashboard_Utils.vi_yellow_2
        }else{
            if (drive_program_status === dashboard_Utils.drive_ph_km_safety){
                return "SAFETY"
//                return dashboard_Utils.vi_red
            }
            else if ((drive_status === dashboard_Utils.drive_ph_ok) ||
                     (drive_status === dashboard_Utils.drive_ph_ok_20213) ||
                     (drive_status === dashboard_Utils.drive_km_ok) &&
                     (drive_fault === 0)){
                return "ACTIVE"
//                return dashboard_Utils.vi_green
            }
            else if (drive_status === dashboard_Utils.drive_ph_km_disabled){
                return "DISABLED"
//                return dashboard_Utils.vi_yellow_2
            }
            else if (drive_fault === 1){
                if (drive_status === dashboard_Utils.drive_ph_cable_disabled){
                    return "DISABLED"
                }
                return "FAULT"
//                return dashboard_Utils.vi_red
            }
            else {
                return "ERROR"
//                return dashboard_Utils.vi_red
            }
        }
    }

    //update_drive_ status text
    function update_drive_status_color (drive_status, drive_fault, drive_program_status, solver_status){
        if(solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STOPPED ||
           solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_OK ||
           drive_program_status === dashboard_Utils.drive_ph_km_disabled){
//            return "DISABLED"
            return dashboard_Utils.vi_yellow_2
        }else{
            if (drive_program_status === dashboard_Utils.drive_ph_km_safety){
                return dashboard_Utils.vi_yellow_2
            }
            else if ((drive_status === dashboard_Utils.drive_ph_ok) ||
                     (drive_status === dashboard_Utils.drive_ph_ok_20213) ||
                     (drive_status === dashboard_Utils.drive_km_ok) &&
                     (drive_fault === 0)){
//                return "ACTIVE"
                return dashboard_Utils.vi_green
            }
            else if (drive_status === dashboard_Utils.drive_ph_km_disabled){
//                return "DISABLED"
                return dashboard_Utils.vi_yellow_2
            }
            else if (drive_fault === 1){
                if (drive_status === dashboard_Utils.drive_ph_cable_disabled){
                    return dashboard_Utils.vi_yellow_2
                }
//                return "FAULT"
                return dashboard_Utils.vi_red
            }
            else {
//                return "ERROR"
                return dashboard_Utils.vi_red
            }
        }
    }

    //increase value + increment. if higher than max, switch to min, if lower than min switch to max
    function loop_values (value, increment, min, max){

        value = value + increment

        if (value > max){
            value = min
        }else if (value < min){
            value = max
        }

        return value
    }

    //saturate (value + increment) to min and max
    function saturate (value, increment, min, max){
        value = value + increment
        if (value > max){
            value = max
        }else if (value < min){
            value = min
        }
        return value
    }

    //saturation (value) to min and max
    function saturation (value, min, max){
        if (value > max){
            value = max
        }else if (value < min){
            value = min
        }
        return value
    }

    //returns a value as a string with certain precision with + or minus in front
    function num_to_string_precision (value, precision, percentage){
        if (value >= 0){
            if (percentage){
                return "+ " + Math.abs(value).toFixed(precision) + " %"
            }else{
                return "+ " + Math.abs(value).toFixed(precision)
            }
        }else{
            if (percentage){
                return "- " + Math.abs(value).toFixed(precision) + " %"
            }else{
                return "- " + Math.abs(value).toFixed(precision)
            }

        }

//        return (value >= 0) ? :

    }

    //returns a value as a string with certain precision in absolute value
    function num_abs_to_string_precision (value, precision, percentage){
        return (percentage) ? Math.abs(value).toFixed(precision) + " %" : Math.abs(value).toFixed(precision)
    }

    //returns a value as a string with certain precision without controilling the sign
    function num_unsign_to_string_precision (value, precision){
        return (value).toFixed(precision)
    }

    //returns azure if value is lower than low_threshold, green in the middle, red if above high_threshold
    function three_way_color (value, low_threshold, high_threshold){

        if (value < low_threshold){
            return dashboard_Utils.vi_azure
        }else if (value < high_threshold){
            return dashboard_Utils.vi_green
        }else{
            return dashboard_Utils.vi_red
        }
    }

    // return the nearest value on an array between down and up with step
    function nearest (variable, down, up, step){
        var arr = []
        for (var i = down; i <= up; i=parseFloat((i+step).toFixed(4))) {

            console.log(step)
            console.log(i)
            arr.push(i)
        }

        if(arr == null){
            return
        }

        return arr.reduce((prev,current) => Math.abs(current - variable)<Math.abs(prev - variable) ? current : prev);

    }

    //rad 2 deg
    function rad2deg (radians){
        return (radians * (180/Math.PI))
    }

    //deg 2 rad
    function deg2rad (degrees){
        return (degrees * (Math.PI/180))
    }

    //calculate euclidean absolute rnage with pos lat and pos long
    function eu_dist_from_zero (a,b){
        return Math.sqrt(Math.pow(a,2)+Math.pow(b,2))
    }

    //open a file and read the text
    function openFile(fileUrl) {
        var request = new XMLHttpRequest();
        request.open("GET", fileUrl, false);
        request.send(null);
        return request.responseText;
    }
    //open a file and get the complete request
    function openFileasync(fileUrl) {
        var request = new XMLHttpRequest();
        request.open("GET", fileUrl, true);
        request.send(null);
        return request;
    }

    //save to a text file
    function saveFile(fileUrl, text) {
        var request = new XMLHttpRequest();
        request.open("PUT", fileUrl, false);
        request.send(text);
        return request.status;
    }

    //change the dashboard main page plus (1) minus (-1)
    function change_page (plus_minus){
        var j = 0;
        for (var item in root.states){
            if (root.states[item].name === root.state){
                j = parseInt(item);
            }
        }
        root.state = root.states[dashboard_Utils.loop_values(j,plus_minus,0,root.states.length-1)].name
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
