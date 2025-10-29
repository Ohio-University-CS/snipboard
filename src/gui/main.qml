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
        id: text1
        x: -23
        y: 156
        width: 1630
        height: 492
        color: "#ffffff"
        text: qsTr("SnipBoard")
        font.pixelSize: 147
        horizontalAlignment: Text.AlignHCenter
        font.family: montserrat
    }


    Rectangle {
        id: rectangle
        x: 498
        y: 744
        width: 604
        height: 72
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

        ProgressBar {
            id: progressBar
            x: 3
            y: 0
            width: 601
            height: 72
            visible: true
            value: 0.5
            transformOrigin: Item.Center
        }

        Text {
            id: text2
            x: 16
            y: 0
            width: 242
            height: 72
            color: "#734c91"
            text: qsTr("Loading...")
            font.pixelSize: 50
            font.bold: true
            font.italic: true
        }
    }
}


/*##^##
Designer {
    D{i:0}D{i:1;locked:true}D{i:4;locked:true}
}
##^##*/
