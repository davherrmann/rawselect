import QtQuick 2.0
import Ubuntu.Components 0.1


Rectangle {
    property string fileName: ""
    property string dateTime: ""
    property string fNumber: ""
    property string barColor: "#000000"

    property real colorBarHeight: units.gu(1)
    property real apertureViewOverlap: units.gu(3)

    color: "transparent"

    Column {
        anchors.fill: parent
        Rectangle {
            color: barColor
            height: colorBarHeight
            //width: parent.width
            anchors.left: parent.left
            anchors.right: parent.right
        }
        Item {
            anchors.right: parent.right
            anchors.left: parent.left
            //anchors.bottom: parent.bottom
            height: parent.height - colorBarHeight
            //width: parent.width
            Column {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                //height: parent.height
                //width: parent.width - parent.height * 0.9
                anchors.leftMargin: units.gu(2)
                Label {
                    text: fileName
                    font.pixelSize: FontUtils.sizeToPixels("large")
                }
                Label {
                    //width: parent.width
                    text: dateTime
                }
            }

            Rectangle {
                height: parent.height * 1.3
                width: height
                color: "transparent"
                anchors.right: parent.right
                anchors.rightMargin: -apertureViewOverlap * 1.5
                //antialiasing: true

                Rectangle {
                    height: parent.height
                    width: height
                    //anchors.centerIn: parent
                    //anchors.horizontalCenter: parent.Center
                    anchors.top: parent.top
                    anchors.topMargin: -apertureViewOverlap
                    antialiasing: true
                    color: "#333333"
                    radius: width * .5

                    Rectangle {
                        antialiasing: parent.antialiasing
                        height: (22 - fNumberText.text.valueOf()) / 25 * parent.height
                        width: height
                        radius: width * 0.5
                        anchors.centerIn: parent
                        color: "#ECECEC"
                        Label {
                            id: fNumberText
                            anchors.centerIn: parent
                            text: {var f = fNumber.split("/"); return f.length==1?f[0]: f[0]/f[1]}
                            font.pixelSize: FontUtils.sizeToPixels("x-large")
                        }
                    }

                }
            }
        }
    }


}

