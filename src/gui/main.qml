import QtQuick
import QtQuick.Controls
import SnipBoard

Window {
    id: welcomeScreen
    visible: true
    width: Screen.width
    height: Screen.height
    visibility: Window.FullScreen
    color: "#5e5270"
    title: qsTr("Hello World")

    onWidthChanged: updateScale
    onHeightChanged: updateScale

    function updateScale() {
        Scaling.factor = Math.min(width/Scaling.baseWidth, height/Scaling.baseHeight) //IGNORE: qmllint warning
    }

    FontLoader {
        id: montserrat
        source: "../../fonts/Montserrat-VariableFont_wght.ttf"
    }



    Text {
        id: text3
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 1/3
        color: "#f0f0f0"
        text: qsTr("SnipBoard")
        font.pixelSize: 147
        horizontalAlignment: Text.AlignHCenter
        font.family: montserrat
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
            font.family: montserrat
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
