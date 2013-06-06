import QtQuick 2.0
import Ubuntu.Components 0.1

Page {
    id: imageStackPage
    //title: i18n.tr("Select...")

    ImageListView {
        id: imageView
        model: exifDataList
        height: imageStackPage.height - toolBarHeight
        width: imageStackPage.width
        imageWidth: height / exifDataList.calcRatio()
        sourceURL: "http://localhost:8080/images/"

        onCurrentIndexChanged: {
            exifDataView.updateExifData(exifDataList.getData(currentIndex));
        }
    }

    ButtonToolBar {
        id: buttonToolBar
        anchors.bottom: parent.bottom
        anchors.bottomMargin: toolBarHeight //- units.gu(0.6)
        width: imageStackPage.width
        buttonsWidth: imageStackPage.width * 0.75
        height: imageStackPage.height - toolBarHeight
    }

    EXIFDataView {
        id: exifDataView
        width: parent.width
        height: toolBarHeight
        anchors.bottom: parent.bottom
        /*exifData: {
            return exifData.getData(imageView.currentIndex);
        }*/
        barColor: "#333333"
    }

    /*tools: ToolbarActions {
        Action {
            text: "up"
        }
    }*/
}
