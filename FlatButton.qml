import QtQuick 2.0

Rectangle {
    id: buttonRect
    width: parent.width / 3 - parent.spacing * 2
    height: FontUtils.sizeToPixels("x-large") * 1.2
    radius: units.gu(0.8)
    antialiasing: true
    color: buttonMA.pressed ? "#77216F": "#333333"

    signal clicked()
    signal pressAndHold()
    //signal pressedChanged()

    property alias text: buttonText.text
    property alias pressed: buttonMA.pressed

    Text {
        id: buttonText
        anchors.centerIn: parent
        color: buttonMA.pressed? "#ECECEC": "#ECECEC"
        font.pixelSize: FontUtils.sizeToPixels("x-large")
        font.family: "Ubuntu"
    }

    MouseArea {
        id: buttonMA
        anchors.fill: parent
        onClicked: buttonRect.clicked()
        onPressAndHold: buttonRect.pressAndHold();
        onPressedChanged: buttonRect.pressedChanged();
    }
}
