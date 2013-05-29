import QtQuick 2.0

Rectangle {
    id: flatButton
    width: units.gu(10)
    height: units.gu(5)
    radius: units.gu(0.8)
    antialiasing: true
    color: pressed ? "#77216F": "#333333"

    signal clicked()
    signal pressAndHold()
    //signal pressedChanged()

    property alias text: buttonText.text
    property alias iconSource: buttonImage.source

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
    Item {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: buttonImage.width + buttonText.width

        Image {
            id: buttonImage
            source: "./res/icons/tick.svg"
            height: source!=""?parent.height * 0.7:0
            width: height
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: buttonText
            anchors.left: buttonImage.right
            anchors.verticalCenter: parent.verticalCenter
            color: buttonMA.pressed? "#ECECEC": "#ECECEC"
            font.pixelSize: FontUtils.sizeToPixels("x-large")
            font.family: "Ubuntu"
        }
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
