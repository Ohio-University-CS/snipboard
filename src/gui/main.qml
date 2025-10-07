import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: rectangle
        x: 220
        y: 140
        width: 200
        height: 200
        color: '#933ba1'
        radius: 16

        Text {
            id: text1
            x: 81
            y: 92
            text: qsTr("Testing")
            font.pixelSize: 12
        }
    }
}
