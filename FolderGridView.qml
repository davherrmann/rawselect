import QtQuick 2.0

Item {
    property real gridMargins: 0

    GridView {
        id: folderGridView
        model: ListModel {
            ListElement { name: "Folder 1"}
            ListElement { name: "Folder 2"}
            ListElement { name: "Folder 3"}
            ListElement { name: "Folder 4"}
            ListElement { name: "Folder 5"}
            ListElement { name: "Folder 6"}
            ListElement { name: "Folder 7"}
            ListElement { name: "Folder 8"}
        }

        cellWidth: width / 3
        cellHeight: height / 3

        anchors.fill: parent
        //anchors.left: parent.left
        anchors.leftMargin: gridMargins / 2
        anchors.topMargin: gridMargins / 2
        anchors.rightMargin: gridMargins / 2

        delegate: Rectangle {
            color: "transparent"
            height: folderGridView.cellHeight
            width: folderGridView.cellWidth
            Rectangle {
                id: folderRect
                color: "#333333"
                width: parent.width - gridMargins
                height: parent.height - gridMargins
                anchors.centerIn: parent
                Text {
                    text: name
                    anchors.centerIn: parent
                    color: "#ECECEC"
                    font.pixelSize: FontUtils.sizeToPixels("large")
                    font.family: "Ubuntu"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        folderRect.color = "#77216F"
                    }
                    onMouseXChanged: {
                        folderRect.color = "#77216F"
                    }

                    onExited: { folderRect.color = "#333333" }
                }
            }
        }
    }
}
