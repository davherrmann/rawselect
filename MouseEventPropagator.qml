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
                                                     initialised: false,
                                                     pressed: false
                                                 });
            }
        }
    }

    onPressedChanged: {
        for (var i = 0; i < mouseAreas.length; i++) {
            if (containsMouse(mouseAreas[i])) {
                if(pressed) {
                    //mouseAreas[i].pressed = true;
                    console.log("pressed " + i);
                    mouseAreasInfo[mouseAreas[i]].pressed = true;
                } else {
                    if(mouseAreasInfo[mouseAreas[i]].pressed) {
                        //mouseAreas[i].pressed = false;
                        //mouseAreas[i].clicked();
                        mouseAreas[i].pressedChanged();
                        mouseAreasInfo[mouseAreas[i]].pressed = false;
                        console.log("released " + i);
                        console.log("clicked " + i);
                    } else {
                        mouseAreas[i].pressedChanged();
                        console.log("released " + i);
                    }
                }
            } else {
                if(!pressed) {
                    if(mouseAreasInfo[mouseAreas[i]].pressed) {
                        //mouseAreas[i].pressed = false;
                        console.log("released " + i)
                        mouseAreasInfo[mouseAreas[i]].pressed = false;
                    }
                }
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

    /* function calcMinRect() {
        var minX = 100000;
        var minY = 100000;
        var maxX = 0;
        var maxY = 0;
        for (var i = 0; i < mouseAreas.length; i++) {
            var max = Math.max;
            var min = Math.min;
            console.log(i)
            var mouseAreaRect = mouseEventPropagator.parent.mapFromItem(mouseAreas[i], 0, 0, mouseAreas[i].width, mouseAreas[i].height);
            minX = min(minX, mouseAreaRect.x);
            console.log("minX: " + mouseAreaRect.x)
            minY = min(minY, mouseAreaRect.y);
            console.log(mouseAreaRect.y)
            maxX = max(maxX, mouseAreaRect.x + mouseAreaRect.width);
            console.log(mouseAreaRect.x + mouseAreaRect.width)
            maxY = max(maxY, mouseAreaRect.y + mouseAreaRect.height);
            console.log(mouseAreaRect.y + mouseAreaRect.height)
        }
        return ({
                    x: minX,
                    y: minY,
                    width: maxX - minX,
                    height: maxY - minY
                });
    } */

    function containsMouse(mouseArea) {
        var mappedPointObject = mouseArea.mapFromItem(mouseEventPropagator,
                                                      mouseX, mouseY)
        var mappedPoint = Qt.point(mappedPointObject.x, mappedPointObject.y)
        return mouseArea.contains(mappedPoint)
    }
}
