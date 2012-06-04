import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as Plasma
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets

Item {
	id: root
	width: 170
    height: 210
    
    property int minimumWidth: 170
    property int minimumHeight: 210
	
	property Component compactRepresentation: SystemIcon { width: 300 }
	
	// separator line svg
	PlasmaCore.Svg {
		id: lineSvg
		imagePath: "widgets/line"
	}	
	
	PlasmaCore.DataSource {
		id: executableSource
		dataEngine: "executable"
	}

	PlasmaCore.DataSource {
		id: powerEngine
		engine: "powermanagement"
		connectedSources: ["PowerDevil"]
		interval: 0
	}
	
	function powerAction(action) {
		var service = powerEngine.serviceForSource("PowerDevil"),
			operation = service.operationDescription(action);
			
		service.startOperationCall(operation);
	}
	
	// main item
	Item {
		anchors {
			fill: parent
			margins: 10
		}
		
		Column {
			spacing: 10
			anchors {
				left: parent.left
				right: parent.right
			}
			
			// show desktop
			Plasma.ToolButton {
				text: "Show Desktop"
				iconSource: 'plasmapackage:/images/blank.png' // use blank icon to left-align text
				anchors {
					left: parent.left
					right: parent.right
				}
				
				onClicked: {
					// hide popup
					plasmoid.togglePopup();
					
					// show desktop
					var executablePath = "wmctrl -k on";

					// run
					executableSource.connectSource(executablePath);
					// allow multiple execution
					executableSource.removeSource(executablePath);
				}
			}
			
			// separator
			PlasmaCore.SvgItem {
				anchors {
					left: parent.left
					right: parent.right
				}
				svg: lineSvg
				elementId: "horizontal-line"
				height: lineSvg.elementSize("horizontal-line").height
			}
			
			Plasma.ToolButton {
				text: "Chat"
				iconSource: 'plasmapackage:/images/blank.png' // use blank icon to left-align text
				anchors {
					left: parent.left
					right: parent.right
				}
				
				onClicked: {
					// hide popup
					plasmoid.togglePopup();
					
					// open telepathy contact list
					plasmoid.runApplication("ktp-contactlist");
				}
			}
			
			Plasma.ToolButton {
				text: "System Settings"
				iconSource: 'plasmapackage:/images/blank.png' // use blank icon to left-align text
				anchors {
					left: parent.left
					right: parent.right
				}
				
				onClicked: {
					// hide popup
					plasmoid.togglePopup();
					
					plasmoid.runApplication("systemsettings");
				}
			}
			
			// separator
			PlasmaCore.SvgItem {
				anchors {
					left: parent.left
					right: parent.right
				}
				svg: lineSvg
				elementId: "horizontal-line"
				height: lineSvg.elementSize("horizontal-line").height
			}
			
			Plasma.ToolButton {
				text: "Lock Screen"
				iconSource: 'plasmapackage:/images/blank.png' // use blank icon to left-align text
				anchors {
					left: parent.left
					right: parent.right
				}
				
				onClicked: {
					// hide popup
					plasmoid.togglePopup();
					
					powerAction("lockScreen");
				}
			}
			
			Plasma.ToolButton {
				text: "Leave"
				iconSource: 'plasmapackage:/images/blank.png' // use blank icon to left-align text
				anchors {
					left: parent.left
					right: parent.right
				}
				
				onClicked: {
					// hide popup
					plasmoid.togglePopup();
					
					powerAction("requestShutDown");
				}
			}
			
		}
		
	}
	
	Component.onCompleted: {
		plasmoid.popupIcon = "user-desktop";
		plasmoid.aspectRationMode = "IgnoreAspectRatio"
	}

}