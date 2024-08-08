import QtQuick 2.12


Item {

    property double fuel_consumption_value: 0
    property double solver_status: 0

    id: fuel_consumption_widget
    width: 200
    height: 80

    Item {
        id: internal_props
        property variant fuel_consumption_array: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        property double fuel_consumption_value_average: 0
    }

    Timer{
        id:timer_array
        interval: 100
        running: fuel_consumption_widget.solver_status === dashboard_Utils.vICRT_SOLVER_STATUS_STARTED
        repeat: true
        onTriggered: {
            var avg = 0
            //delete first element of the array
            internal_props.fuel_consumption_array.shift()
            //add the last element to be the current FC
            internal_props.fuel_consumption_array.push(fuel_consumption_widget.fuel_consumption_value)
            //sum the complete array
            internal_props.fuel_consumption_array.forEach(function (item, index) {
                avg = avg + item
              })
            //make the average and saturate it
            internal_props.fuel_consumption_value_average = dashboard_Utils.saturation( (avg / (internal_props.fuel_consumption_array.length) ), 0, 50)
        }
    }
    Timer{
        id:timer_array_write
        interval: 1500
        running: true
        repeat: true
        onTriggered: {
            //display the average every 1.5 seconds
            fuel_consumption_text.text = internal_props.fuel_consumption_value_average.toFixed(1)
        }
    }

    Image {
        id: fuel_consumption_image
        x: 0
        y: 0
        scale: 0.6
        opacity: 0.6
        anchors.verticalCenter: parent.verticalCenter
        source: "images/fuel-icon.png"
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: -59
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: fuel_consumption_unit
        color: dashboard_Utils.vi_white
        text: qsTr(" l/100km")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 20
        horizontalAlignment: Text.AlignRight
        anchors.horizontalCenterOffset: 58
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 0
        font.family: "Sansation"
    }

    Text {
        id: fuel_consumption_text
        x: 70
        y: 33
        width: 48
        height: 33
        color: dashboard_Utils.vi_white
        text: qsTr("0.0")
        anchors.right: fuel_consumption_unit.left
        anchors.bottom: fuel_consumption_unit.bottom
        font.pixelSize: 25
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors.bottomMargin: -3
        fontSizeMode: Text.FixedSize
        anchors.rightMargin: 3
        font.family: "Open Sans"
    }
    Dashboard_Utils{id: dashboard_Utils}

}

/*##^##
Designer {
    D{i:0;formeditorZoom:6;height:80;width:200}
}
##^##*/
