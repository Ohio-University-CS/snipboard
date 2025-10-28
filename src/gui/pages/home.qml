import QtQuick
import QtQuick.Controls

Window {

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 426
        height: 1067
        color: "#cecece"

        Rectangle {
            id: rectangle8
            x: 42
            y: 39
            width: 345
            height: 124
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
                x: 22
                y: 7
                width: 295
                height: 103
                color: "#dddddd"
                text: qsTr("New +")
                font.pixelSize: 80
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    Rectangle {
        id: rectangle1
        x: 468
        y: 204
        width: 1063
        height: 863
        color: "#cecece"
        topRightRadius: 75
        topLeftRadius: 75

        Rectangle {
            id: rectangle4
            x: 49
            y: 61
            width: 450
            height: 400
            color: "#8f8f8f"
            radius: 50
        }

        Rectangle {
            id: rectangle5
            x: 554
            y: 61
            width: 450
            height: 400
            color: "#8f8f8f"
            radius: 50
        }

        Rectangle {
            id: rectangle6
            x: 49
            y: 523
            width: 450
            height: 340
            color: "#8f8f8f"
            radius: 0
            topRightRadius: 50
            topLeftRadius: 50
        }

        Rectangle {
            id: rectangle7
            x: 554
            y: 523
            width: 450
            height: 340
            color: "#8f8f8f"
            radius: 0
            topRightRadius: 50
            topLeftRadius: 50
        }
    }

    Rectangle {
        id: rectangle2
        x: 468
        y: 36
        width: 1063
        height: 130
        color: "#cecece"
        radius: 75

        Image {
            id: image
            x: 32
            y: 36
            width: 58
            height: 52
            opacity: 0.5
            source: "../../../../../Downloads/search.png"
            mirror: false
            fillMode: Image.PreserveAspectFit
        }

        TextInput {
            id: textInput
            x: 128
            y: 4
            width: 654
            height: 115
            color: "#767676"
            text: qsTr("Search...")
            font.pixelSize: 50
            verticalAlignment: Text.AlignVCenter
            font.family: "Segoe UI"
        }
    }

    Rectangle {
        id: rectangle3
        x: 1568
        y: 0
        width: 32
        height: 1067
        color: "#cecece"
    }

}

