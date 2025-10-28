import QtQuick

Window {
    width: 500
    height: 300
    visible: true
    color: "#e6e6e6"
    title: qsTr("Hello World")

    Text {
        id: text1
        x: 18
        y: 41
        width: 464
        height: 132
        text: qsTr("   Are you sure you want to delete the snippet:")
        font.pixelSize: 35
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignTop
        wrapMode: Text.Wrap

        Text {
            id: text2
            x: 306
            y: 48
            width: 132
            height: 50
            color: "#734c91"
            text: qsTr("UI SUCKS")
            font.pixelSize: 35
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.italic: true
            font.weight: Font.Bold
        }
    }

    Rectangle {
        id: rectangle
        x: 35
        y: 179
        width: 201
        height: 99
        color: "#ffffff"
        border.color: "#6c6c6c"
        border.width: 5

        Text {
            id: text3
            x: 0
            y: 0
            width: 201
            height: 99
            color: "#6c6c6c"
            text: qsTr("CANCEL")
            font.pixelSize: 50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: rectangle1
        x: 264
        y: 179
        width: 201
        height: 99
        color: "#6c6c6c"
        border.color: "#ffffff"
        border.width: 5

        Text {
            id: text4
            x: 0
            y: 0
            width: 201
            height: 99
            color: "#ffffff"
            text: qsTr("DELETE")
            font.pixelSize: 50
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
