import QtQuick 2.0
import Ubuntu.Components 0.1

Item {
    property string sourceURL: ""
    property int numberOfColumns: 3
    property real margins: units.gu(1)
    property alias model: gridView.model

    GridView {
        id: gridView
        cellWidth: width / numberOfColumns
        cellHeight: cellWidth

        anchors.fill: parent
        anchors.leftMargin: margins
        anchors.topMargin: margins

        delegate: Item {
            width: gridView.cellWidth
            height: gridView.cellHeight

            UbuntuShape {
                id: cropRect
                anchors.left: parent.left
                anchors.top: parent.top
                width: parent.width - margins
                height: parent.height - margins

                image: Image {
                    source: sourceURL + fileName
                    fillMode: Image.PreserveAspectCrop
                }
            }
        }
    }
}
