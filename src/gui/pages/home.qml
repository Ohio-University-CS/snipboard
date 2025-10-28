import QtQuick 2.15
import QtQuick.Controls 2.15

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

        Text {
            id: text2
            x: 76
            y: 251
            width: 251
            height: 43
            text: qsTr("Settings")
            font.pixelSize: 35

            Rectangle {
                id: rectangle10
                x: -45
                y: 9
                width: 29
                height: 25
                color: "#ffffff"
                rotation: 0
            }
        }

        Text {
            id: text3
            x: 76
            y: 299
            width: 251
            height: 43
            text: qsTr("Favorites")
            font.pixelSize: 35

            Rectangle {
                id: rectangle11
                x: -49
                y: 10
                width: 31
                height: 30
                color: "#ffffff"
                rotation: 0
            }
        }

        Text {
            id: text4
            x: 76
            y: 203
            width: 251
            height: 43
            text: qsTr("Home")
            font.pixelSize: 35

            Rectangle {
                id: rectangle9
                x: -45
                y: 9
                width: 29
                height: 25
                color: "#ffffff"
                rotation: 0
            }
        }

        Text {
            id: text5
            x: 77
            y: 348
            width: 251
            height: 43
            text: qsTr("Folders")
            font.pixelSize: 35

            Rectangle {
                id: rectangle12
                x: -48
                y: 9
                width: 29
                height: 30
                color: "#ffffff"
                rotation: 0
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


/*##^##
Designer {
    D{i:0}D{i:14;locked:true}D{i:15;locked:true}D{i:16;locked:true}D{i:17;locked:true}
D{i:18;locked:true}
}
##^##*/
