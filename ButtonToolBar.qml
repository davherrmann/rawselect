import QtQuick 2.0

Item {
    id: buttonToolBar
    anchors.margins: units.gu(2)

    property real buttonMargins: units.gu(2)
    property real buttonsWidth: width
    property real buttonWidth: (buttonsWidth - (buttonTexts.length + 1)
                                * buttonMargins) / buttonTexts.length
    property var buttonMapping: [{data: "rubbish", text: "", icon: "./res/icons/rubbish.svg", showFolders: false},
                                    {data: "accept", text: "", icon: "./res/icons/tick.svg", showFolders: true},
                                    {data: "edit", text: "", icon: "./res/icons/edit.svg", showFolders: true}
                                ]
    property var buttonTexts: ["", "", ""]
    property real buttonHeight: units.gu(5)
    property int lastButtonPressedIndex: -1

    function setupMouseAreas() {
        try {
            var mouseAreas = [buttons.itemAt(0), buttons.itemAt(1), buttons.itemAt(2)];
            mouseAreas.push.apply(mouseAreas, folderPicker.folderRects)
            console.log(mouseAreas)
            mouseEventPropagator.setMouseAreas(mouseAreas);
        } catch(err) {
            console.log(err);
        }
    }

    FolderPicker {
        id: folderPicker
        visible: false
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width

        onFolderChosen: {
            visible = false;
            console.log(buttonMapping[lastButtonPressedIndex].data +
                        (buttonMapping[lastButtonPressedIndex].showFolders?": " + folderPicker.lastChosenFolder:""))
            for (var i=0; i < folderRects.length; i++) {
                folderRects[i].containsMouse = false;
                folderRects[i].pressed = false;
            }
        }

        Component.onCompleted: setupMouseAreas()
    }

    MouseEventPropagator {
        id: mouseEventPropagator
        anchors.bottom: parent.bottom
        width: parent.width
        height: folderPicker.visible?parent.height:buttonHeight
        z: folderPicker.z + 1
        propagateComposedEvents: true
    }

    Repeater {
        id: buttons
        model: buttonTexts.length
        FlatButton {
            text: buttonMapping[index].text
            iconSource: buttonMapping[index].icon
            width: buttonWidth
            height: buttonHeight
            anchors.bottom: buttonToolBar.bottom
            roundCorners: [true, true, false, false]
            x: (buttonWidth + buttonMargins) * index + buttonMargins
            z: folderPicker.z - 1
            onPressedChanged: {
                exifDataView.barColor = pressed ? "#77216F" : "#333333"
                folderPicker.visible = buttonMapping[index].showFolders?pressed:false
                if(pressed) {
                    lastButtonPressedIndex = index
                }
            }
        }
        onItemAdded: setupMouseAreas()
    }
}
