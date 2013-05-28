import QtQuick 2.0


Flickable {
    id: imageFlick

    contentHeight: image.height
    contentWidth: image.width

    onDragEnded: {
        console.log(image.Left)
        image.nextImage()
    }

    Image {
        id: image
        anchors.centerIn: parent
        source: "http://localhost:8080/images/" + exifData.getPath(currentImageID)
        fillMode: Image.Stretch
        width: calcImageWidth()
        height: calcImageHeight()

        property int currentImageID: 0

        function nextImage() {
            //currentImageID += 1
            source = "http://localhost:8080/images/" + exifData.getPath(1)
            console.log(sourceSize.height / sourceSize.width)
        }

        function previousImage() {
            currentImageID -= 1
        }

        function calcImageWidth() {
            return calcImageRatio() > imageFlick.calcPaintRatio() ? imageFlick.width : imageFlick.height / calcImageRatio();
        }

        function calcImageHeight() {
            return calcImageRatio() > imageFlick.calcPaintRatio() ? imageFlick.width * calcImageRatio() : imageFlick.height;
        }

        function calcImageRatio() {
            return sourceSize.height / sourceSize.width;
        }
    }
    function calcPaintRatio() {
        return height / width;
    }
}
