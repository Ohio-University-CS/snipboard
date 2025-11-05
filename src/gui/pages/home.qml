import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard 1.0  // for SnippetObject type if needed
import QtQuick.Controls.Basic as Basic   // <-- add this

Page {
    id: window
    visible: true
    width: 800
    height: 600
    title: "Snippet Testing File"

    Rectangle {
        id: bg_rect
        width: parent.width
        height: parent.height
        color: "#f4f4f4"

        ColumnLayout {
            anchors.fill: parent
            spacing: 12
            anchors.margins: 12
            anchors.leftMargin: 142
            anchors.topMargin: 109


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
                    font.pointSize: 15
                    icon.height: 40
                    icon.width: 50
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
                    icon.height: 40
                    icon.width: 50
                    font.pointSize: 15
                    onClicked: snippetService.loadSnippetsFromDb()
                }
            }
        }

        Rectangle {
            id: selection_rect
            x: 0
            y: 0
            width: 124
            height: 600
            color: "#cfcfcf"

            Basic.Button {
                id: home_button
                x: 36
                y: 130
                width: 52; height: 52
                display: AbstractButton.IconOnly
                icon.source: "qrc:/resources/icons/home.png"
                icon.width: 32; icon.height: 32
                background: Rectangle {
                    radius: 12
                    color: home_button.down ? "#5a2f86" : (home_button.hovered ? '#915fc4' : "#734c91")
                }
            }

            // Favorites
            Basic.Button {
                id: fav_button
                x: 36
                y: 200
                width: 52; height: 52
                display: AbstractButton.IconOnly
                icon.source: "qrc:/resources/icons/star.png"
                icon.width: 30; icon.height: 30
                background: Rectangle {
                    radius: 12
                    color: fav_button.down ? '#958235' : (fav_button.hovered ? '#c7af4b' : '#b19b3b')
                }
            }

            // Settings
            Basic.Button {
                id: settings_button
                x: 36
                y: 525
                width: 52; height: 52
                display: AbstractButton.IconOnly
                icon.source: "qrc:/resources/icons/setting.png"
                icon.width: 30; icon.height: 30
                background: Rectangle {
                    radius: 12
                    color: settings_button.down ? '#5b5b5b' : (settings_button.hovered ? '#989898' : '#7f7f7f')
                }
            }

            Image {
                id: image1
                x: 25
                y: 20
                width: 75
                height: 75
                source: "qrc:/resources/icons/sb_logo.png"
                fillMode: Image.PreserveAspectFit
            }

        }

        Rectangle {
            id: search_rect
            x: 136
            y: 15
            width: 652
            height: 82
            color: "#cfcfcf"

            FocusScope {
                x: 58
                y: 0
                width: 594; height: 82

                // TextInput {
                //     id: input
                //     anchors.fill: parent
                //     anchors.rightMargin: 8
                //     anchors.topMargin: 20
                //     anchors.bottomMargin: 15
                //     font.pixelSize: 40
                //     verticalAlignment: Text.AlignVCenter
                //     color: "#000"
                //     text: "" // start empty
                //     focus: false
                // }

                TextEdit {
                    id: input
                    x: 20
                    y: 0
                    width: 560
                    height: 82
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
                    font.pointSize: 30
                    textFormat: TextEdit.PlainText
                    cursorVisible: activeFocus   // shows only when focused
                    // Optional styling to look like a field
                    padding: 8
                }

                // Placeholder label (non-interactive so clicks pass through)
                Text {
                    id: hint
                    anchors.fill: input
                    anchors.leftMargin: -6
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    z: 1
                    verticalAlignment: Text.AlignVCenter
                    color: "#767676"
                    text: "Search..."
                    font.pixelSize: 40
                    visible: !input.activeFocus && input.text.length === 0
                    // Important: make sure the overlay doesn't eat events
                    enabled: false
                }

                // Click helper that focuses the input while not stealing the event
                TapHandler {
                    // Attach to the input’s area
                    parent: input
                    enabled: hint.visible
                    onTapped: input.forceActiveFocus()
                    // Passive by default; TextInput will still place the caret
                }
            }

            Basic.Button {
                id: search_button
                x: 17
                y: 21
                width: 42; height: 46
                display: AbstractButton.IconOnly
                padding: 0   // so the image centers nicely

                // custom content so we can control opacity
                contentItem: Item {
                    anchors.fill: parent
                    Image {
                        anchors.centerIn: parent
                        source: "qrc:/resources/icons/search.png"
                        anchors.verticalCenterOffset: -1
                        anchors.horizontalCenterOffset: 1
                        width: 35; height: 35
                        opacity: search_button.enabled
                                ? (search_button.down ? 0.55
                                    : (search_button.hovered ? 0.25 : .40))
                                : 0.35
                        Behavior on opacity { NumberAnimation { duration: 120 } }
                        fillMode: Image.PreserveAspectFit
                    }
                }

                background: Rectangle {
                    radius: 10
                    color: search_button.down ? '#cdcdcd'
                        : (search_button.hovered ? "#cfcfcf" : "#cfcfcf")
                }
            }

            // Button {
            //     id: search_button
            //     x: 8
            //     y: 15
            //     width: 51
            //     height: 49
            //     text: qsTr("Button")
            //     display: AbstractButton.IconOnly

            //     Image {
            //         id: image
            //         x: 7
            //         y: 7
            //         width: 38
            //         height: 35
            //         opacity: 0.4
            //         visible: true
            //         source: "qrc:/resources/icons/search.png"
            //         clip: false
            //         fillMode: Image.PreserveAspectFit
            //     }
            // }

        }
    }
}

