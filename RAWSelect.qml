import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

MainView {
    id: root
    objectName: "mainView"
    applicationName: "RAWSelect" //must match the .desktop file name
    automaticOrientation: true
    
    width: units.gu(50)
    height: units.gu(75)

    property real margins: units.gu(2)
    property real toolBarHeight: units.gu(16)
    property real innerWidth: root.width - 2 * margins

    ImageListModel {
        id: exifData
    }

    Page {
        id: selectingPage
        title: i18n.tr("Select...")

        ImageView {
            id: imageView
            model: exifData
            height: selectingPage.height - toolBarHeight
            width: selectingPage.width
            imageWidth: height / exifData.calcRatio()
            sourceURL: "http://localhost:8080/images/"

            onCurrentIndexChanged: {
                exifDataView.update()
            }
        }

        ButtonToolBar {
            id: buttonToolBar
            anchors.bottom: parent.bottom
            anchors.bottomMargin: toolBarHeight //- units.gu(0.6)
            width: selectingPage.width
            buttonsWidth: selectingPage.width * 0.75
            height: selectingPage.height - toolBarHeight
        }

        EXIFDataView {
            id: exifDataView
            width: parent.width
            height: toolBarHeight
            anchors.bottom: parent.bottom
            exifData: exifData.get(imageView.currentIndex)
            //fileName: imageView.getCurrentPath()

            function update() {
                /*var currentEXIFData = exifData.get(imageView.currentIndex)
                fileName = currentEXIFData.path
                dateTime = currentEXIFData.dateTime
                fNumber = currentEXIFData.fNumber*/
                //barColor = "#" + 0 + 0 + imageView.currentIndex + imageView.currentIndex + imageView.currentIndex + imageView.currentIndex
                barColor = "#333333"
            }
        }
    }
}
