import QtQuick
import QtQuick.Controls

Window {
    id: welcomeScreen
    width: 1440
    height: 900
    visible: true
    color: "#cacaca"
    visibility: Window.FullScreen
    title: qsTr("Hello World")

    Rectangle {
        id: rectangle
        x: 69
        y: 58
        width: 406
        height: 110
        color: "#ffffff"

        TextField {
            id: textField
            x: 16
            y: -8
            width: 386
            height: 126
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 50
            placeholderText: qsTr("Prefix...")
        }
    }

    Rectangle {
        id: rectangle1
        x: 69
        y: 192
        width: 1341
        height: 187
        color: "#ffffff"

        TextArea {
            id: textArea1
            x: 8
            y: 0
            width: 1333
            height: 187
            font.pointSize: 50
            placeholderText: qsTr("Description / Tags...")
        }
    }

    Rectangle {
        id: rectangle2
        x: 69
        y: 409
        width: 1341
        height: 286
        color: "#ffffff"

        TextArea {
            id: textArea
            x: 8
            y: 8
            width: 1325
            height: 278
            color: "#000000"
            text: ""
            verticalAlignment: Text.AlignTop
            font.pointSize: 50
            placeholderText: "Code..."
        }
    }

    Rectangle {
        id: rectangle3
        x: 519
        y: 58
        width: 891
        height: 110
        color: "#ffffff"

        TextField {
            id: textField1
            x: 8
            y: 2
            width: 863
            height: 106
            verticalAlignment: Text.AlignVCenter
            placeholderText: qsTr("Name...")
            font.pointSize: 50
        }
    }

    Rectangle {
        id: rectangle8
        x: 379
        y: 723
        width: 345
        height: 124
        color: "#8041b0"
        radius: 75
        Button {
            id: button
            x: 26
            y: 16
            width: 286
            height: 95
            visible: false
            text: "New +"
            icon.color: "#d4d4d4"
            font.pointSize: 60
            display: AbstractButton.TextUnderIcon

            onClicked: StackView.view.push(
                Qt.resolvedUrl("home.qml")
            )
        }

        Text {
            id: text1
            x: 22
            y: 7
            width: 295
            height: 103
            color: "#ffffff"
            text: qsTr("Back")
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: rectangle9
        x: 760
        y: 723
        width: 345
        height: 124
        color: "#8041b0"
        radius: 75
        Button {
            id: button1
            x: 26
            y: 16
            width: 286
            height: 95
            visible: false
            text: "New +"
            icon.color: "#d4d4d4"
            font.pointSize: 60
            display: AbstractButton.TextUnderIcon

            onClicked: StackView.view.push(
                Qt.resolvedUrl("home.qml")
            )
        }

        Text {
            id: text2
            x: 22
            y: 7
            width: 295
            height: 103
            color: "#dddddd"
            text: qsTr("Save")
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

}

