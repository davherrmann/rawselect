import QtQuick 2.0

MouseArea {
    id: mouseEventPropagator
    hoverEnabled: true

    property var mouseAreas: []
    property var mouseAreasInfo: ({})

    function setMouseAreas(mouseAreasUnchecked) {
        if (!check(mouseAreasUnchecked) || !check(mouseAreasUnchecked.length)) {
            throw new Error("setMouseAreas(): argument must be an array");
        }
        mouseAreas = [];
        var mappedIndex = 0;
        for (var i = 0; i < mouseAreasUnchecked.length; i++) {
            if (check(mouseAreasUnchecked[i])){
                try {
                    mouseAreasUnchecked[i].containsMouse = false;
                    mouseAreasUnchecked[i].pressed = false;
                    mouseAreas[mappedIndex] = mouseAreasUnchecked[i];
                    mappedIndex++;
                } catch(err) {
                    throw new Error("setMouseAreas(): mouseArea with index " + i + " has to have both 'containsMouse' and 'pressed' as writable properties...")
                }
            }
        }
        mouseAreasChanged();
    }

    onMouseAreasChanged: {
        for (var i = 0; i < mouseAreas.length; i++) {
            if (!(mouseAreas[i] in mouseAreasInfo)) {
                initMouseArea(mouseAreas[i])
                mouseAreasInfo[mouseAreas[i]] = ({
                                                     initialised: false
                                                 });
            }
        }
    }

    onPressedChanged: {
        for (var i = 0; i < mouseAreas.length; i++) {
            if (!containsMouse(mouseAreas[i])) {
                if(!pressed) {
                    if(mouseAreas[i].pressed) {
                        mouseAreas[i].pressed = false;
                        //console.log("released " + i)
                    }
                }
            }
        }
        for (var i = 0; i < mouseAreas.length; i++) {
            if (containsMouse(mouseAreas[i])) {
                if(pressed) {
                    mouseAreas[i].pressed = true;
                    //console.log("pressed " + i);
                } else {
                    if(mouseAreas[i].pressed) {
                        mouseAreas[i].pressed = false;
                        //mouseAreas[i].clicked(null);
                        //console.log("released " + i);
                        //console.log("clicked " + i);
                    } else {
                        //mouseAreas[i].pressed = false;
                        mouseAreas[i].pressedChanged();
                        //console.log("released " + i);
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
                if(!mouseAreas[i].containsMouse) {
                    mouseAreas[i].containsMouse = true;
                    //console.log("entered " + i)
                }
            } else {
                if(mouseAreas[i].containsMouse) {
                    mouseAreas[i].containsMouse = false;
                    //console.log("exited " + i)
                }
            }
        }
    }

    function check(obj) {
        return (typeof (obj) != 'undefined' && obj !== null);
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
