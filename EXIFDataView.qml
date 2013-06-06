import QtQuick 2.0
import Ubuntu.Components 0.1

Rectangle {
    property string barColor: "#000000"

    property real colorBarHeight: units.gu(1)
    property real apertureViewOverlap: units.gu(3)

    color: "#ECECEC"

    function updateExifData(exifData) {
        fileName.text = exifData.fileName;
        whiteBalance.text = "WB: " + exifData.whiteBalance;
        exposureTime.text = exifData.exposureTime;
        isoSpeed.text = "ISO " + exifData.isoSpeed;
        lensModel.text = exifData.lensModel;
        dateTime.text = exifData.dateTime;
        fNumber.text = function(){var f = exifData.fNumber.split("/"); return f.length===1?f[0]: f[0]/f[1]}();
    }

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
                    id: fileName
                    font.pixelSize: FontUtils.sizeToPixels("large")
                }
                Label {
                    id: whiteBalance
                    //font.pixelSize: FontUtils.sizeToPixels("large")
                }
                Row {
                    spacing: units.gu(2)
                    Label {
                        id: exposureTime
                        font.pixelSize: FontUtils.sizeToPixels("x-large")
                    }
                    Label {
                        id: isoSpeed
                        font.pixelSize: FontUtils.sizeToPixels("x-large")
                    }
                }
                Label {
                    id: lensModel
                }
                Label {
                    id: dateTime
                    //width: parent.width
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
                        height: (22 - fNumber.text.valueOf()) / 25 * parent.height
                        width: height
                        radius: width * 0.5
                        anchors.centerIn: parent
                        color: "#ECECEC"
                        Label {
                            id: fNumber
                            anchors.centerIn: parent
                            font.pixelSize: FontUtils.sizeToPixels("x-large")
                        }
                    }
                }
            }
        }
    }
}

