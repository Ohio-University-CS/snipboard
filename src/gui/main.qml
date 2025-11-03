import QtQuick
import QtQuick.Controls
import QtQuick.Window

Window {
    id: welcomeScreen
    visible: true
    width: Screen.width
    height: Screen.height
    color: "#734c91"
    visibility: Window.Maximized
    title: qsTr("Main.qml - Should load pages")

    StackView {
        id: stack
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.topMargin: 0
        initialItem: "pages/home.qml"
    }

    Text {
        id: text1
        x: -23
        y: 156
        width: 1630
        height: 492
        color: "#ffffff"
        text: qsTr("SnipBoard")
        font.pixelSize: 340
        font.bold: true
    }


    Rectangle {
        id: rectangle
        x: 498
        y: 744
        width: 604
        height: 72
        color: "#ffffff"

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
##What this is?
Designer {
    D{i:0}D{i:1;locked:true}D{i:4;locked:true}
}
##^##*/
