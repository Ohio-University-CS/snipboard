import QtQuick
import "." as Colors

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Colors {id: color}

    Rectangle {
        id: rectangle
        x: 220
        y: 140
        width: 200
        height: 200
        color: color.primary
        radius: 16

        Text {
            id: text1
            x: 81
            y: 92
            text: qsTr("Snip Board")
            font.pixelSize: 40
            color: color.primaryText
        }
    }
}
