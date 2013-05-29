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

        onVisibleChanged: {
            if(visible) {
                for (var folderRect in folderRects) {
                    folderRect.pressedMouseHovers = false;
                    console.log("resetHover")
                }
            }
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
                        //button.pressedChanged();
                        buttonToolBarMA.mouseYChanged(this)
                    }
                }
            } else {
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
            if(!pressed) {
                for (var i = 0; i < buttons.count; i++) {
                    var button = buttons.itemAt(i)
                    if (button.pressed && !pressed) {
                        button.pressed = false;
                        //button.pressedChanged();
                    }
                }
            }
        }
        onMouseYChanged: {
            console.log("ychanged: " + pressed + " " + folderPicker.visible)
            if (pressed && folderPicker.visible) {
                for (var i = 0; i < folderPicker.folderRects.length; i++) {
                    var folderRect = folderPicker.folderRects[i]
                    var mappedPointObject = folderRect.mapFromItem(
                                buttonToolBarMA, mouseX, mouseY)
                    var mappedPoint = Qt.point(mappedPointObject.x,
                                               mappedPointObject.y)
                    console.log("check for contain")
                    console.log(mappedPointObject.x + " " + mappedPointObject.y)
                    if (folderRect.contains(mappedPoint)) {
                        console.log("contains")
                        console.log(folderRect.pressedMouseHovers)
                        folderRect.pressedMouseHovers = true
                        //folderRect.pressedMouseHoversChanged()
                    } else if (folderRect.pressedMouseHovers === true) {
                        folderRect.pressedMouseHovers = false
                        //folderRect.pressedMouseHoversChanged()
                    }
                }
            }
        }
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
                if(!pressed) {
                    console.log(buttonMapping[index].data +
                                (buttonMapping[index].showFolders?": " + folderPicker.lastChosenFolder:""))
                }
            }
        }
    }
}
