import QtQuick 2.0

Rectangle {
    id: flatButton
    width: units.gu(10)
    height: units.gu(5)
    radius: units.gu(0.8)
    antialiasing: true
    color: buttonMA.pressed ? "#77216F": "#333333"

    signal clicked()
    signal pressAndHold()
    //signal pressedChanged()

    property alias text: buttonText.text
    property var pressed: buttonMA.pressed

    property var roundCorners: [true, true, true, true]

    Repeater {
        id: corners
        model: 4
        Rectangle {
            antialiasing: parent.antialiasing
            width: flatButton.radius
            height: flatButton.radius
            visible: !roundCorners[index]
            color: flatButton.color
            anchors.left: (index==0 || index==3)?flatButton.left:undefined
            anchors.right: (index==1 || index==2)?flatButton.right:undefined
            anchors.top: (index==0 || index==1)?flatButton.top:undefined
            anchors.bottom: (index==2 || index==3)?flatButton.bottom:undefined
        }
    }

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
        onClicked: {
            mouse.accepted = false
            flatButton.clicked()
        }
        onPressAndHold: flatButton.pressAndHold();
        onPressedChanged: flatButton.pressedChanged();
        preventStealing: false
        propagateComposedEvents: true
        //drag.target: buttonRect
    }
}
