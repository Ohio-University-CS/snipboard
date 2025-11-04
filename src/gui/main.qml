import QtQuick
import QtQuick.Controls
import QtQuick.Window

Window {
    id: welcomeScreen
    width: 1440
    height: 900
    visible: true
    color: "#734c91"
    title: qsTr("Main/loading page")


    Text {
        id: text1
        x: -7
        y: 112
        width: 1630
        height: 492
        color: "#ffffff"
        text: qsTr("SnipBoard")
        font.pixelSize: 300
        font.bold: true
    }

    Rectangle {
        id: rectangle
        x: 418
        y: 576
        width: 604
        height: 72
        color: "#ffffff"

        ProgressBar {
            id: progressBar
            x: 3
            y: 0
            width: 601
            height: 72
            from: 0
            to: 1
            value: 0
            visible: true
            transformOrigin: Item.Center

            // Animate the bar filling up
            NumberAnimation on value {
                id: fillAnim
                from: 0
                to: 1
                duration: 2500 // time to fill up progress bar
                running: true
                onFinished: {
                    stack.clear() 
                    stack.push("qrc:/qt/qml/SnipBoard/src/gui/pages/home.qml")
                }
            }

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
    StackView {
        id: stack
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }
}






/*##^##
Designer {
    D{i:0}D{i:3;locked:true}
}
##^##*/
