import QtQuick 2.0

Item {
    id: folderPicker

    property real folderMargins: 0 // units.gu(0.5)
    property real folderSeparatorHeight: 0 //units.gu(0.3)
    property real folderColorWidth: units.gu(2)
    property int folderCount: Object.keys(folders).length
    property var folders: {"Folder 1": "red", "Folder 2": "yellow", "Folder 3": "blue", "Folder 4": "lime", "Folder 5": ""}
    property var folderRects: {
        var folderRects = []
        for(var i=0; i<folderRectRepeater.count; i++) {
            folderRects.push(folderRectRepeater.itemAt(i))
        }
        return folderRects
    }
    property int lastChosenFolder: -1

    signal folderChosen()

    Column {
        spacing: folderMargins
        Repeater {
            id: folderRectRepeater
            model: folderCount
            Rectangle {
                width: folderPicker.width
                height: (folderPicker.height - (folderCount - 1) * folderMargins) / folderCount
                color: "#333333"

                property bool containsMouse: false
                property bool pressed: false

                onContainsMouseChanged: {
                    color =  containsMouse?"#77216F":"#333333";
                }

                onPressedChanged: {
                    if(!pressed && containsMouse) {
                        lastChosenFolder = index;
                        folderPicker.folderChosen();
                        color = "#333333";
                    }
                }

                Text {
                    text: Object.keys(folders)[index]
                    anchors.centerIn: parent
                    color: "#ECECEC"
                    font.pixelSize: FontUtils.sizeToPixels("large")
                    font.family: "Ubuntu"
                }

                Rectangle {
                    height: parent.height * 0.6
                    width: folderColorWidth
                    radius: height * 0.1
                    antialiasing: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: units.gu(1)
                    color: folders[Object.keys(folders)[index]]
                }

                Rectangle {
                    width: parent.width
                    anchors.bottom: parent.bottom
                    height: folderSeparatorHeight
                    color: "#77216F"
                }
            }
        }
    }
}
