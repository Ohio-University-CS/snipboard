import QtQuick
import QtQuick.Controls

Window {
    id: welcomeScreen
    visible: true
    width: Screen.width
    height: Screen.height
    color: "#5e5270"
    visibility: Window.FullScreen
    title: qsTr("Hello World")

    FontLoader {
        id: quantico
        source: "../../fonts/Quantico-Regular.ttf"
    }

    FontLoader {
        id:quanticoBold
        source: "../../fonts/Quantico-Bold.ttf"
    }

    FontLoader {
        id: quanticoItalic
        source: "../../fonts/Quantico-Italic.ttf"
    }

    FontLoader {
        id: quanticoBoldItalic
        source: "../../fonts/Quantico-BoldItalic.ttf"
    }


    Text {
        id: text3
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 1/3
        color: "#f0f0f0"
        text: qsTr("SnipBoard")
        font.pixelSize: 147
        horizontalAlignment: Text.AlignHCenter
        font.family: quanticoBold
    }

    Rectangle {
        id: newRectangle
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 11/14
        width: 278
        height: 61
        color: "#ffffff"
        radius: 16

        Text {
            id: text1
            x: 90
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
            x: 90
            y: -6

        }
    }

    Rectangle {
        id: homeButton
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 6/7
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

        Button {
            id: snippetsButton
            anchors.horizontalCenter: parent.horizontalCenter
            width: 278
            height: 61
            x: 44
            y: -6

        }
    }
}
