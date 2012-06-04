import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as Plasma
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets

Item {
	
	width: 300
	
	property string currentActivity : ''
	property string stateSource : ''
	
	PlasmaCore.DataSource {
		id: activitiesSource
		dataEngine: "org.kde.activities"

		onSourceAdded: {
			connectSource(source);
		}
		
		onSourceRemoved: {
			disconnectSource(source);
		}
		
		onDataChanged: {
			stateSource = activitiesSource.sources[activitiesSource.sources.length - 1];
			currentActivity = (activitiesSource.data[stateSource]) ? activitiesSource.data[activitiesSource.data[stateSource].Current].Name : '';
		}
		
		Component.onCompleted: {
			connectedSources = sources;
		}
	}
	
	Plasma.ToolButton {
		id: currentActivityLabel
		text: '<b>' + currentActivity + '</b>'
		anchors.fill: parent
		
		onClicked: plasmoid.togglePopup();
	}
}