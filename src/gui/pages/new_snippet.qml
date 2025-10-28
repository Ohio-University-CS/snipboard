import QtQuick
import QtQuick.Controls

Window {
    id: welcomeScreen
    visible: true
    width: Screen.width
    height: Screen.height
    color: "#cacaca"
    visibility: Window.FullScreen
    title: qsTr("Hello World")

    Rectangle {
        id: rectangle
        x: 69
        y: 58
        width: 472
        height: 133
        color: "#ffffff"

        TextField {
            id: textField
            x: 16
            y: -8
            width: 464
            height: 149
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 50
            placeholderText: qsTr("Prefix...")
        }
    }

    Rectangle {
        id: rectangle1
        x: 69
        y: 224
        width: 1461
        height: 184
        color: "#ffffff"

        TextArea {
            id: textArea1
            x: 8
            y: 0
            width: 1453
            height: 143
            font.pointSize: 50
            placeholderText: qsTr("Description...")
        }
    }

    Rectangle {
        id: rectangle2
        x: 69
        y: 437
        width: 1461
        height: 439
        color: "#ffffff"

        TextArea {
            id: textArea
            x: 8
            y: 8
            width: 1453
            height: 431
            color: "#000000"
            text: ""
            verticalAlignment: Text.AlignTop
            font.pointSize: 50
            placeholderText: "Code..."
        }
    }

    Rectangle {
        id: rectangle3
        x: 577
        y: 58
        width: 953
        height: 133
        color: "#ffffff"

        TextField {
            id: textField1
            x: 8
            y: -8
            width: 464
            height: 149
            verticalAlignment: Text.AlignVCenter
            placeholderText: qsTr("Name...")
            font.pointSize: 50
        }
    }

    Rectangle {
        id: rectangle8
        x: 427
        y: 911
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
        x: 838
        y: 911
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

