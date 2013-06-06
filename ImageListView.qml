import QtQuick 2.0

ListView {
    id: imageListView
    clip: true

    property real imageWidth: width
    property string sourceURL: ""

    //snapMode: ListView.SnapOneItem;
    orientation: ListView.Horizontal
    cacheBuffer: imageWidth * 2;
    //flickDeceleration: 500
    preferredHighlightBegin: (width - imageWidth) / 2
    preferredHighlightEnd: width - (width - imageWidth) / 2
    highlightRangeMode: ListView.StrictlyEnforceRange
    highlightFollowsCurrentItem: true

    delegate: Image {
        id: imageDelegate
        source: sourceURL + fileName

        height: parent.height
        width: imageWidth
        fillMode: Image.PreserveAspectCrop
    }
}
