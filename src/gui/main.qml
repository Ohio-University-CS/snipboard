import QtQuick
import QtQuick.Controls
import QtQuick.Window

Window {
    id: window
    visible: true
    width: 800
    height: 600
    color: "#734c91"
    title: qsTr(SnipBoard)


    Rectangle {
        id: rectangle
        x: 98
        y: 428
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
                    stack.replace("qrc:/qt/qml/SnipBoard/src/gui/pages/home.qml")
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

        Text {
            id: text1
            x: 3
            y: 100
            width: 797
            height: 256
            color: "#ffffff"
            text: qsTr("SnipBoard")
            font.pixelSize: 175
        }
    }
}






/*##^##
Designer {
    D{i:0}D{i:2;locked:true}
}
##^##*/
