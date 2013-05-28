import QtQuick 2.0

Item {
    id: folderPicker

    property real folderMargins: units.gu(0.5)
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

                property bool pressedMouseHovers: false
                property bool pressed: false

                onPressedMouseHoversChanged: {
                    color =  pressedMouseHovers?"#77216F":"#333333";
                }

                onPressedChanged: {
                    if(!pressed) {
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
            }
        }
    }
}
