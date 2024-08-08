import QtQuick 2.14

import QtQuick.Shapes 1.14

import "../../../qml/default/default_db"
import "../../../qml/default/default_db/images"
import "../../../qml/default/default_db/files"

Item {



    //.........................................................................
    //user adjustable parameters

    property double drd_subsampling: 10
    property string path_to_drd: "files/Calabogie.drd"

    property double path_s: 0
    property alias track_color: myPath.strokeColor
    property alias track_width: myPath.strokeWidth
    property alias rect_pointerWidth: rect_pointer.width
    property alias rect_pointerColor: rect_pointer.color
    onPath_sChanged: {
        if (track_id.path_s <= properties.drd_length){
            rect_pointer.anchors.horizontalCenterOffset = (-this_shape.width/2 + (myPath.pointAtPercent(track_id.path_s/properties.drd_length).x))
            rect_pointer.anchors.verticalCenterOffset = (-this_shape.height/2 + myPath.pointAtPercent(track_id.path_s/properties.drd_length).y)
        }
    }

    Item {
        id: properties
        //those are computed at start based on the drd
        property double path_x_offset: 0
        property double path_y_offset: 0
        property double drd_scale: 0
        property double drd_length: 0
        property double std_width: 500
        property double std_height: 500
        property double int_x: 0
        property double int_y: 0
        property double drd_x_min: 0
        property double drd_y_min: 0
        property double drd_x_max: 0
        property double drd_y_max: 0
    }

    //.........................................................................

    id: track_id
    width: 500
    height: 500
    antialiasing: true


    Shape {
        property double square_dimension: 350 * dashboard_Utils.resize_content(track_id.width, track_id.height, properties.std_width, properties.std_height)
        id: this_shape
        width: parent.width
        height: parent.height
        rotation: 180
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: starting_line
            x: 0
            y: 0
            rotation: 90
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "images/starting_line.png"
            fillMode: Image.PreserveAspectFit
            Component.onCompleted: {
                starting_line.anchors.verticalCenterOffset= (-this_shape.height/2 + myPath.pointAtPercent(0).y)
                starting_line.anchors.horizontalCenterOffset= (-this_shape.width/2 + myPath.pointAtPercent(0).x)
            }
        }

        Rectangle {
            id: rect_pointer
            width: 2
            height: rect_pointer.width
            color: dashboard_Utils.vi_red
            radius: rect_pointer.width/2
            border.width: 0
            anchors.verticalCenterOffset: (-this_shape.height/2 + myPath.pointAtPercent(track_id.path_s/properties.drd_length).y)
            anchors.horizontalCenterOffset: (-this_shape.width/2 + myPath.pointAtPercent(track_id.path_s/properties.drd_length).x)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        ListModel {
            id: myPositions
        }


        function createPathLineElements(file, positionsModel, shapePath)
        {
            var temp_x_max;
            var temp_y_max;
            var temp_x_min;
            var temp_y_min;
            var temp_elements_x = [];
            var temp_elements_y = [];
            var x_files = []
            var y_files = []

            //requesting the drd file and loading into memory
            var rawFile = new XMLHttpRequest();

            console.log("cheching state of the text = " + rawFile.readyState) //checking state
            var pathElements = []
            var ok = true
            rawFile.open("GET", file, false);
            rawFile.send(null);
            console.log("DONE cheching state of the text = " + rawFile.readyState)

            //loading text into a full string
            var allText = rawFile.responseText;

            //split the string by line
            var one_line = allText.split("\n")
            console.log("lenght of the complete drd = " + allText.length)
            var i;
            var path_string = []

            // making a first loop to check geometrical stuff like height and width
            for (i = 2; i < one_line.length; i = i + 10) {
                //split each line using space separator
                var temp_element = one_line[i].split(" ")
                //console.warn(i + " something "+ temp_element)
                //getting array of "pure" x (1) and y(3) coordinates . with (2) you get a space. loading only valid lines of size > 1
                if (temp_element.length > 1){
                    temp_elements_x.push(-parseFloat(temp_element[1]))
                    temp_elements_y.push(parseFloat(temp_element[3]))
                }
            }

            //computing drd leght to be compared with path_s
            for (i = 1; i < temp_elements_x.length; i = i + 1) {
                properties.drd_length = properties.drd_length + Math.sqrt((Math.pow(temp_elements_x[i]-temp_elements_x[i-1],2))+(Math.pow(temp_elements_y[i]-temp_elements_y[i-1],2)))
            }
            console.log("drd_lenght: " + properties.drd_length)

            //sorting in descending order the array
            temp_elements_x.sort(function(a, b){return b - a});
            //getting "pure" max and min from the sorted array
            temp_x_max = (temp_elements_x[0])
            temp_x_min = ((temp_elements_x[temp_elements_x.length - 1]))

            //sorting in descending order the array
            temp_elements_y.sort(function(a, b){return b - a});
            //getting "pure" max and min from the sorted array
            temp_y_max = ((temp_elements_y[0]))
            temp_y_min = ((temp_elements_y[temp_elements_y.length - 1]))

            //computing the lenght of x and y in pure coordinates
            var lenght_x = Math.abs(temp_x_max) + Math.abs(temp_x_min)
            var lenght_y = Math.abs(temp_y_max) + Math.abs(temp_y_min)

            //deciding the max between x and y lenght to determine the scaling
            var max = Math.max(lenght_x, lenght_y)
            console.log("the temp x min is " + temp_x_min)
            console.log("the temp y min is " + temp_y_min)
            console.log("the lenght x is " + lenght_x)
            console.log("the lenght y is " + lenght_y)
            console.log("the max is " + max)

            //defining the drd to qml scaling based on the max of the two dimension of the drd
            properties.drd_scale = square_dimension / max
            console.log("the scale is " + properties.drd_scale)

            //computing border between square_dimension (virtual square inside wich there is the map)
            // and the map scaled appropiately
            var a = (square_dimension - lenght_x * properties.drd_scale)/2
            var b = (square_dimension - lenght_y * properties.drd_scale)/2

            //moving the starting point of the shape from 0,0 to (border) + (a or b) + min_dimension * scale
            myPath.startX = ((track_id.width - this_shape.square_dimension)/2) + Math.abs(a) + Math.abs(temp_x_min * properties.drd_scale)
            myPath.startY = ((track_id.height - this_shape.square_dimension)/2) + Math.abs(b) + Math.abs(temp_y_min * properties.drd_scale)

            //declaring at root level the path offset scaled
            properties.path_x_offset = myPath.startX
            properties.path_y_offset = myPath.startY
            properties.int_x = a
            properties.int_y = b

            //looping into the drd descarding the first line (no data there)
            // and subsampling usign the track_id.drd_subsampling key
            for (i = 2; i < one_line.length; i = i + drd_subsampling) {

                //splitting each line by space argument
                var element = one_line[i].split(" ")

                //creating a dynamic qml object to store each pathline
                var pathLine = Qt.createQmlObject("import QtQuick 2.12; PathLine {}",shapePath);

                //not sure why, but x should be reverted in sign (maybe rotation?)
                pathLine.x = -parseFloat(element[1]) * properties.drd_scale + Math.abs(temp_x_min * properties.drd_scale) +
                        ((track_id.width - this_shape.square_dimension)/2) + a
                x_files.push(pathLine.x)
                pathLine.y = parseFloat(element[3]) * properties.drd_scale + Math.abs(temp_y_min * properties.drd_scale) +
                        ((track_id.height - this_shape.square_dimension)/2) + b
                y_files.push(pathLine.y)

                //pushing each pathline into pathElements
                pathElements.push(pathLine)

            }

            console.log("done doing drd conversion")
            console.log("min x = " + temp_x_min + "  , max x = " + temp_x_max)
            console.log("length in x = " + lenght_x)
            console.log("min y = " + temp_y_min + "  , max y = " + temp_y_max)
            console.log("length in y = " + lenght_y)
            console.log("start_x = " + properties.path_x_offset)
            console.log("start_y = " + properties.path_y_offset)
            properties.drd_x_min = temp_x_min;
            properties.drd_x_max = temp_x_max;
            properties.drd_y_min = temp_y_min;
            properties.drd_y_max = temp_y_max;

            return pathElements
        }



        ShapePath {
            id: myPath
            strokeWidth: 2
            strokeColor: dashboard_Utils.vi_black
            fillColor: dashboard_Utils.vi_transparent
            strokeStyle: ShapePath.SolidLine
            startX: properties.path_x_offset
            startY: properties.path_y_offset
            Component.onCompleted: {
                myPath.pathElements = this_shape.createPathLineElements(track_id.path_to_drd,myPositions,myPath)
                // initialize the point
                rect_pointer.anchors.horizontalCenterOffset = (-this_shape.width/2 + (myPath.pointAtPercent(track_id.path_s/properties.drd_length).x))
                rect_pointer.anchors.verticalCenterOffset = (-this_shape.height/2 + myPath.pointAtPercent(track_id.path_s/properties.drd_length).y)
            }
        }
    }




    Monofur{}
    Sansation_Regular{}
    OpenSans_Regular{}
    Dashboard_Utils{id: dashboard_Utils}



}
/*
<div>Icons made by <a href="https://www.flaticon.com/authors/pixel-perfect" title="Pixel perfect">Pixel perfect</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
<a href='https://www.freepik.com/photos/background'>Background photo created by mrsiraphol - www.freepik.com</a>
*/



/*##^##
Designer {
    D{i:0;height:228;width:256}
}
##^##*/
