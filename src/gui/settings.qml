import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 190
        height: 480
        color: '#3ba169'
        radius: 0

        Text {
            id: text1
            x: 81
            y: 92
            font.pixelSize: 12
        }
    }
}
