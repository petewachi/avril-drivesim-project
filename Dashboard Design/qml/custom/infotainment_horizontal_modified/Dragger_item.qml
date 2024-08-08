import QtQuick 2.12
import "../../../qml/default/default_db"


MouseArea{
    id: dragger_item

    //this component can be used to switch between states using a drag with mous eor touch
    property double init_offset: 0
    property double threshold: 0.1
    property string stateOnLeft: "home"
    property string stateOnRight: "radio"
    property bool stateOnLeftActivity: true
    property bool stateOnRightActivity: true

    anchors.fill: parent
    acceptedButtons: Qt.AllButtons
    onMouseXChanged: {
        //defining the intial point where the mouse is
        if (init_offset === 0){
            init_offset =
                    parent.anchors.horizontalCenterOffset + (-parent.width / 4 + mouseX/2);
        }else{
            // dragging the item depending on mouse/touch input
            parent.anchors.horizontalCenterOffset =
                    parent.anchors.horizontalCenterOffset + (-parent.width / 4 + mouseX/2) - init_offset
        }
        //debug
        // console.log("offset: " + (parent.anchors.horizontalCenterOffset))
    }
    onReleased: {
        //debug
        // console.log("ratio: " + (parent.anchors.horizontalCenterOffset/parent.width))

        //change the dashboard state to the next one depending on a threshold
        if (parent.anchors.horizontalCenterOffset/parent.width < - threshold &&
                stateOnRightActivity){
            root.state = dragger_item.stateOnRight
        }else if (parent.anchors.horizontalCenterOffset/parent.width > threshold &&
                  stateOnLeftActivity){
            root.state = dragger_item.stateOnLeft
        }

        //resetting init offset and position while releasing
        init_offset = 0
        parent.anchors.horizontalCenterOffset = 0
    }
    Dashboard_Utils{id: dashboard_Utils}
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
