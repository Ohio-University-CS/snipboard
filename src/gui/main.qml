import QtQuick
import QtQuick.Controls


Window {
    id: welcomeScreen
    visible: true
    width: Screen.width
    height: Screen.height
    color: "#5e5270"
    title: qsTr("Hello World")


    Text {
        id: text3
        x: -13
        y: 40
        color: "#ffffff"
        text: qsTr("SnipBoard")
        font.pixelSize: 147
        horizontalAlignment: Text.AlignHCenter
    }
    Rectangle {
        id: newRectangle
        anchors.horizontalCenter: parent.horizontalCenter
        width: 278
        height: 61
        color: "#ffffff"
        radius: 16

        Text {
            id: text1
            x: 89
            y: -6
            color: "#5e5270"
            text: qsTr("New")
            font.pixelSize: 50
        }

        Button {
            id: newButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: 278
            height: 61

        }
    }

    Rectangle {
        id: homeButton
        x: 181
        y: 356
        width: 278
        height: 61
        color: "#ffffff"
        radius: 16
        Text {
            id: text2
            x: 44
            y: -6
            color: "#5e5270"
            text: qsTr("Snippets")
            font.pixelSize: 50
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
