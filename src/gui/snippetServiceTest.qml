import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard 1.0  // for SnippetObject type if needed

ApplicationWindow {
    id: window
    visible: true
    width: 700
    height: 500
    title: "Snippet Testing File"

    ColumnLayout {
        anchors.fill: parent
        spacing: 12
            anchors.margins: 12


        Label {
            text: "Snippets"
            font.pixelSize: 24
            font.bold: true
        }

        // --- Snippet List ---
        ListView {
            id: snippetList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 8
            model: snippetService.snippets   // Bind directly to SnippetListModel

            delegate: Rectangle {
                width: parent.width
                height: 80
                radius: 8
                color: hovered ? "#e0e0e0" : "white"
                border.color: "#cccccc"

                property bool hovered: false

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.hovered = true
                    onExited: parent.hovered = false
                    onClicked: {
                        console.log("Snippet clicked:", id, name)
                    }
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 12

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 4

                        Text {
                            text: name
                            font.bold: true
                            font.pixelSize: 16
                            color: "#333"
                            elide: Text.ElideRight
                        }

                        Text {
                            text: description
                            color: "#666"
                            elide: Text.ElideRight
                            wrapMode: Text.WordWrap
                        }
                    }

                    Button {
                        text: "❌"
                        Layout.alignment: Qt.AlignRight
                        onClicked: snippetService.deleteSnippet(id)
                    }
                }
            }
        }

        // --- Control Row ---
        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Button {
                text: "Add Snippet"
                onClicked: {
                    snippetService.createSnippet(
                        "New Snippet",
                        "This is a new snippet",
                        "C++",
                        "int main() { return 0; }",
                        0,    // folder ID
                        false // favorite
                    )
                }
            }

            Button {
                text: "Reload"
                onClicked: snippetService.reload()
            }
        }
    }
}
