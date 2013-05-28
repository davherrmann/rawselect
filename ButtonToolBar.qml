import QtQuick 2.0

Item {
    id: buttonToolBar
    anchors.margins: units.gu(2)

    property real buttonMargins: units.gu(2)
    property real buttonsWidth: width
    property real buttonWidth: (buttonsWidth - (buttonTexts.length + 1)
                                * buttonMargins) / buttonTexts.length
    property var buttonTexts: ["1", "2", "3"]
    property real buttonHeight: units.gu(5)

    FolderPicker {
        id: folderPicker
        visible: false
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height
        width: parent.width

        onFolderChosen: {
            visible = false;
            console.log("chosen folder: " + lastChosenFolder)
        }
    }

    MouseArea {
        id: buttonToolBarMA
        anchors.bottom: parent.bottom
        width: parent.width
        height: folderPicker.visible?parent.height:buttonHeight
        z: folderPicker.z + 1
        propagateComposedEvents: true
        onPressedChanged: {
            if (!folderPicker.visible) {
                for (var i = 0; i < buttons.count; i++) {
                    var button = buttons.itemAt(i)
                    var mappedPointObject = button.mapFromItem(buttonToolBarMA,
                                                               mouseX, mouseY)
                    var mappedPoint = Qt.point(mappedPointObject.x,
                                               mappedPointObject.y)
                    if (button.contains(mappedPoint)) {
                        button.pressed = pressed;
                        button.pressedChanged();
                    }
                }
            } else {
                for (var i = 0; i < buttons.count; i++) {
                    var button = buttons.itemAt(i)
                    if (button.pressed && !pressed) {
                        button.pressed = false;
                        button.pressedChanged();
                    }
                }
                for (var i = 0; i < folderPicker.folderRects.length; i++) {
                    var folderRect = folderPicker.folderRects[i]
                    var mappedPointObject = folderRect.mapFromItem(
                                buttonToolBarMA, mouseX, mouseY)
                    var mappedPoint = Qt.point(mappedPointObject.x,
                                               mappedPointObject.y)
                    if (folderRect.contains(mappedPoint)) {
                        folderRect.pressed = pressed
                        folderRect.pressedChanged()
                    }
                }
            }
        }
        onMouseYChanged: {
            if (pressed && folderPicker.visible) {
                for (var i = 0; i < folderPicker.folderRects.length; i++) {
                    var folderRect = folderPicker.folderRects[i]
                    var mappedPointObject = folderRect.mapFromItem(
                                buttonToolBarMA, mouseX, mouseY)
                    var mappedPoint = Qt.point(mappedPointObject.x,
                                               mappedPointObject.y)
                    if (folderRect.contains(mappedPoint)) {
                        folderRect.pressedMouseHovers = true
                        folderRect.pressedMouseHoversChanged()
                    } else if (folderRect.pressedMouseHovers === true) {
                        folderRect.pressedMouseHovers = false
                        folderRect.pressedMouseHoversChanged()
                    }
                }
            }
        }
    }

    Repeater {
        id: buttons
        model: buttonTexts.length
        FlatButton {
            id: flatButton
            text: buttonTexts[index]
            width: buttonWidth
            height: buttonHeight
            anchors.bottom: buttonToolBar.bottom
            roundCorners: [true, true, false, false]
            x: (buttonWidth + buttonMargins) * index + buttonMargins
            z: folderPicker.z - 1
            onPressedChanged: {
                exifDataView.barColor = pressed ? "#77216F" : "#333333"
                folderPicker.visible = pressed
            }
        }
    }
}
