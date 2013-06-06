import QtQuick 2.0
import Ubuntu.Components 0.1

Page {
    id: imageGridPage

    ImageGridView {
        id: imageGridView
        model: exifDataList
        height: imageGridPage.height
        width: imageGridPage.width
        sourceURL: "http://localhost:8080/images/"
    }
}
