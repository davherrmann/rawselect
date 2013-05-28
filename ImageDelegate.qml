import QtQuick 2.0

Image {
    id: imageDelegate

    property string imageSource: ""

    fillMode: Image.PreserveAspectCrop
    source: imageSource
}
