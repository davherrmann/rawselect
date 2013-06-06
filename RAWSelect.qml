import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

import "common/Utils.js" as Utils

MainView {
    id: mainView
    objectName: "mainView"
    applicationName: "RAWSelect" //must match the .desktop file name
    automaticOrientation: true
    
    width: units.gu(50)
    height: units.gu(75)

    property real margins: units.gu(2)
    property real toolBarHeight: units.gu(16)
    property real innerWidth: width - 2 * margins

    property var exifDataList: ImageListModel { }

    Tabs {
        Tab {
            title: "Stack"
            page: ImageStackPage {
                id: imageStackPage
            }
        }
    }
}
