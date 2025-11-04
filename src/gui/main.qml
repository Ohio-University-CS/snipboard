import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Controls.Basic as Basic   // <-- add this

Window {
    id: win
    visible: true
    width: 800
    height: 600
    color: "#734c91"
    title: qsTr("SnipBoard")

    Loader {
        id: stage
        anchors.fill: parent
        asynchronous: true
        sourceComponent: splash
    }

    // Listen for the splash's "finished" signal even though Loader.item is typed as QObject.
    // ignoreUnknownSignals avoids qmllint warnings when item doesn't have that signal yet.
    Connections {
        target: stage.item
        ignoreUnknownSignals: true
        function onFinished() {
            stage.sourceComponent = undefined
            stage.source = "qrc:/qt/qml/SnipBoard/src/gui/pages/home.qml"
        }
    }

    // ---- Splash component (no references to outer IDs) ----
    Component {
        id: splash
        Item {
            id: splashRoot
            anchors.fill: parent
            signal finished()

            Text {
                x: 3; y: 100; width: 797; height: 256
                color: "white"; text: qsTr("SnipBoard"); font.pixelSize: 175
            }

            Rectangle {
                x: 98; y: 428; width: 604; height: 72; color: "white"

                Basic.ProgressBar {                      // <-- use Basic.ProgressBar
                    id: bar
                    x: 3; y: 3; width: 598; height: 67
                    from: 0; to: 1; value: 0

                    contentItem: Item {
                        clip: true
                        Rectangle {
                            width: bar.visualPosition * bar.width
                            height: bar.height
                            color: "#734c91"  // your loading color
                            radius: 4
                        }
                    }

                    background: Rectangle {
                        color: "white"
                        radius: 4
                        border.color: "#d9d9d9"
                    }

                    NumberAnimation on value {
                        from: 0; to: 1; duration: 2000; running: true
                        onFinished: splashRoot.finished()
                    }
                }


                Text {
                    x: 16; y: 0; width: 242; height: 72
                    color: "#734c91"; text: qsTr("Loading...")
                    font.pixelSize: 50; font.bold: true; font.italic: true
                }
            }
        }
    }
}
