import QtQuick 2.0

MouseArea {
    id: mouseEventPropagator
    hoverEnabled: true

    property var mouseAreas: []
    property var mouseAreasInfo: ({})

    onMouseAreasChanged: {
        for (var i = 0; i < mouseAreas.length; i++) {
            if (check(mouseAreas[i]) && !(mouseAreas[i] in mouseAreasInfo)) {
                console.log("initalise " + i)
                initMouseArea(mouseAreas[i])
                mouseAreasInfo[mouseAreas[i]] = ({
                                                     containsMouse: false,
                                                     initialised: false
                                                 });
            }
        }
    }

    onMouseYChanged: mouseMoved()
    onMouseXChanged: mouseMoved()

    function mouseMoved() {
        for (var i = 0; i < mouseAreas.length; i++) {
            if (containsMouse(mouseAreas[i])) {
                if(!mouseAreasInfo[mouseAreas[i]].containsMouse) {
                    mouseAreas[i].entered();
                    console.log("entered " + i)
                    mouseAreasInfo[mouseAreas[i]].containsMouse = true;
                }
            } else {
                if(mouseAreasInfo[mouseAreas[i]].containsMouse) {
                    mouseAreas[i].exited();
                    console.log("exited " + i)
                    mouseAreasInfo[mouseAreas[i]].containsMouse = false;
                }
            }
        }
    }

    function check(obj) {
        return (typeof (obj) != 'undefined' && obj !== null)
    }

    function initMouseArea(mouseArea) {
        mouseArea.enabled = false
        return mouseArea
    }

    function containsMouse(mouseArea) {
        var mappedPointObject = mouseArea.mapFromItem(mouseEventPropagator,
                                                      mouseX, mouseY)
        var mappedPoint = Qt.point(mappedPointObject.x, mappedPointObject.y)
        return mouseArea.contains(mappedPoint)
    }
}
