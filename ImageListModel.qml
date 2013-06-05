import QtQuick 2.0
import QtQuick.XmlListModel 2.0

ListModel {
    id: exifData

    function getPath(idx) {
        return (idx >= 0 && idx < count) ? get(idx).path: ""
    }

    function getDateTime(idx) {
        return (idx >= 0 && idx < count) ? get(idx).dateTime: 0.0
    }

    function getImageRatio(idx) {
        return (idx >= 0 && idx < count) ? get(idx).imageRatio: 0.0
    }

    function calcRatio() {
        var ratio = 1000
        for(var i = 0; i < count; i++) {
            ratio = ratio>getImageRatio(i)?getImageRatio(i):ratio;
        }
        return ratio
    }
    property XmlListModel xmlListModel: XmlListModel {
        id: exifDataFetcher
        source: "http://localhost:8080"
        query: "/Images/Image"

        onStatusChanged: {
            if (status === XmlListModel.Ready) {
                console.log("xml changed...")
                for (var i = 0; i < count; i++) {
                    exifData.append({"fileName": get(i).path,
                                        "dateTime": get(i).dateTime,
                                        "imageRatio": get(i).imageHeight / get(i).imageWidth,
                                        "exposureTime": get(i).exposureTime,
                                        "fNumber": get(i).fNumber,
                                        "colorSpace": get(i).colorSpace,
                                        "whiteBalance": get(i).whiteBalance,
                                        "cameraModel": get(i).cameraModel,
                                        "isoSpeed": get(i).isoSpeed,
                                        "lensModel": get(i).lensModel,
                                        "exposureMode": get(i).exposureMode})
                }
            }
        }

        XmlRole { name: "path"; query: "path/string()" }
        XmlRole { name: "dateTime"; query: "DateTime/string()" }
        XmlRole { name: "imageWidth"; query: "ExifImageWidth/string()" }
        XmlRole { name: "imageHeight"; query: "ExifImageLength/string()" }
        XmlRole { name: "exposureTime"; query: "ExposureTime/string()" }
        XmlRole { name: "fNumber"; query: "FNumber/string()" }
        XmlRole { name: "colorSpace"; query: "ColorSpace/string()" }
        XmlRole { name: "whiteBalance"; query: "WhiteBalance/string()" }
        XmlRole { name: "cameraModel"; query: "Model/string()" }
        XmlRole { name: "isoSpeed"; query: "ISOSpeedRatings/string()" }
        //XmlRole { name: ""; query: "/string()" }
        XmlRole { name: "lensModel"; query: "LensModel/string()" }
        XmlRole { name: "exposureMode"; query: "ExposureMode/string()" }
    }
}
