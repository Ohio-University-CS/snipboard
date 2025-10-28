import QtQuick
import QtQuick.Controls

Window {
    id: welcomeScreen
    visible: true
    width: Screen.width
    height: Screen.height
    color: "#f3f3f3"
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

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: Qt.resolvedUrl("pages/home.qml")
    }
}

