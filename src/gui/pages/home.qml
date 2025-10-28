import QtQuick
import QtQuick.Controls

Window {
    width: 1440
    height: 900
    title: "HOME"

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 402
        height: 900
        color: "#cecece"

        Rectangle {
            id: rectangle8
            x: 42
            y: 39
            width: 303
            height: 113
            color: "#734c91"
            radius: 75

            Button {
                id: button
                x: 26
                y: 16
                width: 286
                height: 95
                visible: false
                text: "New +"
                display: AbstractButton.TextUnderIcon
                font.pointSize: 60
                icon.color: "#d4d4d4"

                onClicked: StackView.view.push(
                               Qt.resolvedUrl("new_snippet.qml")
                               )
            }

            Text {
                id: text1
                x: 8
                y: 2
                width: 295
                height: 103
                color: "#dddddd"
                text: qsTr("New +")
                font.pixelSize: 70
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Rectangle {
        id: rectangle1
        x: 449
        y: 194
        width: 913
        height: 706
        color: "#cecece"
        topRightRadius: 75
        topLeftRadius: 75

        Rectangle {
            id: rectangle4
            x: 49
            y: 42
            width: 390
            height: 310
            color: "#8f8f8f"
            radius: 50
        }

        Rectangle {
            id: rectangle5
            x: 474
            y: 42
            width: 390
            height: 310
            color: "#8f8f8f"
            radius: 50
        }

        Rectangle {
            id: rectangle6
            x: 49
            y: 388
            width: 390
            height: 310
            color: "#8f8f8f"
            radius: 50
        }

        Rectangle {
            id: rectangle7
            x: 474
            y: 388
            width: 390
            height: 310
            color: "#8f8f8f"
            radius: 50
        }

        GridView {
            id: gridView
            x: 387
            y: 246
            width: 140
            height: 140
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
            delegate: Item {
                x: 5
                height: 50
                Column {
                    spacing: 5
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        x: 5
                        text: name
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
            cellWidth: 70
            cellHeight: 70
        }
    }

    Rectangle {
        id: rectangle2
        x: 449
        y: 34
        width: 913
        height: 117
        color: "#cecece"
        radius: 75

        TextInput {
            id: textInput
            x: 130
            y: 1
            width: 654
            height: 115
            color: "#767676"
            text: qsTr("Search...")
            font.pixelSize: 50
            verticalAlignment: Text.AlignVCenter
            font.family: "Segoe UI"
        }

        Image {
            id: image
            x: 41
            y: 26
            width: 64
            height: 68
            opacity: 0.388
            source: "../../../../../../Downloads/search.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: rectangle3
        x: 1419
        y: 0
        width: 30
        height: 900
        color: "#cecece"
    }


}

