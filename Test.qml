Tabs {
    id: tabs

    anchors.fill: parent

    //tab with image list
    Tab {
        objectName: "Tab1"
        title: i18n.tr("Hello..")

        page: Page {

            XmlListModel {
                id: exifDataFetcher
                source: "http://localhost:8080"
                query: "/Images/Image"

                onStatusChanged: {
                    if (status === XmlListModel.Ready) {
                        for (var i = 0; i < count; i++) {
                            exifData.append({"path": get(i).path, "DateTime": get(i).DateTime})
                        }
                    }
                }

                XmlRole { name: "path"; query: "path/string()" }
                XmlRole { name: "DateTime"; query: "DateTime/string()" }
            }

            Column {
                anchors.fill: parent
                ListView {
                    clip: true
                    width: parent.width
                    height: parent.height
                    model: exifData
                    delegate: ListItem.Subtitled {
                        text: path
                        subText: DateTime
                        icon: "http://localhost:8080/images/" + path
                        progression: true
                    }
                }
            }
        }
    }

    // Second tab begins here
    Tab {
        objectName: "Tab2"

        onActiveChanged: {
            label.text = "onActiveChanged"
        }

        title: i18n.tr("..Toolbar!")
        page: Page {
            tools: ToolbarActions {
                Action {
                    objectName: "action"

                    iconSource: Qt.resolvedUrl("toolbarIcon.png")
                    text: i18n.tr("Tap me!")

                    onTriggered: {
                        label.text = i18n.tr("Toolbar tapped")
                    }
                }
            }

            Column {
                anchors.centerIn: parent
                Label {
                    id: label
                    objectName: "label"

                    text: i18n.tr("Swipe from bottom to up to reveal the toolbar.")
                }
            }
        }
    }
}
