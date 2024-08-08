import QtQml 2.12
import QtQuick 2.9
import QtQuick.Window 2.2
import com.vigrade.DaemonInterface 1.0


Window {

    id: root
    visible: true
    x: 0
    y: 0
    property double isXREnabled: 0
    color: "#000000"
    Loader{
        id: pageLoader
        focus: true
		//console.log("Loader starting..")
        source:"./default/default_db/Dashboard.qml"
        onSourceChanged: animation.running = true

        NumberAnimation {
			id: animation
			target: pageLoader.item
			property: "opacity"
			from: 0
			to: 1
			duration: 1000
            easing.type: Easing.InCirc
		}

    }

    DaemonInterface{
        id: daemonitf
		Component.onCompleted: {
			daemonitf.setDashboardId(dashboardId);
			daemonitf.startDaemonInterface();
		}
        onDashboardSourceChanged: {
            //set the source for the Loader component. it gets the latest file on the disk instead of the cached one
            pageLoader.setSource("./"+daemonitf.getdashboardSourceValue()+"?t="+Date.now(),{"dashboardId": dashboardId})
        }
        onCloseDashboard: {
			Qt.quit()
		}

    }
    onClosing:{
        if (!isXREnabled){
		    daemonitf.stopCommand()
        }
	}

}
