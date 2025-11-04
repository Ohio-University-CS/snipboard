import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard 1.0  // for SnippetObject type if needed

Page {
    id: window
    visible: true
    width: 800
    height: 600
    title: "Snippet Testing File"

    Rectangle {
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
            id: rectangle
            x: 0
            y: 0
            width: 124
            height: 600
            color: "#cfcfcf"
        }

        Rectangle {
            id: rectangle1
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

            Image {
                id: image
                x: 22
                y: 28
                width: 30
                height: 30
                opacity: 0.4
                visible: true
                source: "qrc:/resources/icons/search.png"
                clip: false
                fillMode: Image.PreserveAspectFit
            }

        }
    }
}


// Page {
//     // anchors.fill: parent;
//     title: "HOME";

// Item {
//     anchors.fill: parent
//     anchors.leftMargin: 0
//     anchors.rightMargin: 0
//     anchors.topMargin: 12
//     anchors.bottomMargin: -12

//     Rectangle {
//         id: rectangle13
//         x: 0
//         y: -18
//         width: 1440
//         height: 900
//         color: "#ffffff"

//         Rectangle {
//             id: rectangle
//             x: 0
//             y: 0
//             width: 402
//             height: 900
//             color: "#cecece"

//             Text {
//                 id: settings_button_text
//                 x: 102
//                 y: 337
//                 width: 251
//                 height: 81
//                 text: qsTr("Settings")
//                 font.pixelSize: 50

//                 Image {
//                     id: image2
//                     x: -60
//                     y: 15
//                     width: 45
//                     height: 45
//                     source: "qrc:/resources/icons/settings.png"
//                     fillMode: Image.PreserveAspectFit
//                 }
//             }

//             Text {
//                 id: fav_button_text
//                 x: 102
//                 y: 424
//                 width: 251
//                 height: 73
//                 text: qsTr("Favorites")
//                 font.pixelSize: 50

//                 Image {
//                     id: image3
//                     x: -60
//                     y: 15
//                     width: 45
//                     height: 45
//                     source: "qrc:/resources/icons/star.png"
//                     fillMode: Image.PreserveAspectFit
//                 }
//             }

//             Text {
//                 id: home_button_text
//                 x: 102
//                 y: 251
//                 width: 251
//                 height: 72
//                 text: qsTr("Home")
//                 font.pixelSize: 50

//                 Image {
//                     id: image1
//                     x: -60
//                     y: 15
//                     width: 45
//                     height: 45
//                     source: "qrc:/resources/icons/home.png"
//                     fillMode: Image.PreserveAspectFit
//                 }
//             }

//             Text {
//                 id: folders_button_text
//                 x: 102
//                 y: 509
//                 width: 251
//                 height: 69
//                 text: qsTr("Folders")
//                 font.pixelSize: 50

//                 Image {
//                     id: image4
//                     x: -60
//                     y: 15
//                     width: 45
//                     height: 45
//                     source: "qrc:/resources/icons/folder.png"
//                     fillMode: Image.PreserveAspectFit
//                 }
//             }

//             Rectangle {
//                 id: rectangle1
//                 x: 449
//                 y: 194
//                 width: 913
//                 height: 706
//                 color: "#cecece"

//                 Rectangle {
//                     id: rectangle4
//                     x: 49
//                     y: 42
//                     width: 390
//                     height: 310
//                     color: "#8f8f8f"
//                     radius: 50
//                 }

//                 Rectangle {
//                     id: rectangle5
//                     x: 474
//                     y: 42
//                     width: 390
//                     height: 310
//                     color: "#8f8f8f"
//                     radius: 50
//                 }

//                 Rectangle {
//                     id: rectangle6
//                     x: 49
//                     y: 388
//                     width: 390
//                     height: 310
//                     color: "#8f8f8f"
//                     radius: 50
//                 }

//                 Rectangle {
//                     id: rectangle7
//                     x: 474
//                     y: 388
//                     width: 390
//                     height: 310
//                     color: "#8f8f8f"
//                     radius: 50
//                 }
//             }




//         }

//         Rectangle {
//             id: rectangle8
//             x: 42
//             y: 39
//             width: 303
//             height: 113
//             color: "#734c91"
//             radius: 75

//             Button {
//                 id: button
//                 x: 26
//                 y: 16
//                 width: 286
//                 height: 95
//                 visible: false
//                 text: "New +"
//                 display: AbstractButton.TextUnderIcon
//                 font.pointSize: 60
//                 icon.color: "#d4d4d4"

//                 onClicked: StackView.view.push(
//                                Qt.resolvedUrl("new_snippet.qml")
//                                )
//             }

//             Text {
//                 id: text1
//                 x: 8
//                 y: 2
//                 width: 295
//                 height: 103
//                 color: "#dddddd"
//                 text: qsTr("New +")
//                 font.pixelSize: 70
//                 horizontalAlignment: Text.AlignHCenter
//                 verticalAlignment: Text.AlignVCenter
//             }
//         }

//         Rectangle {
//             id: rectangle2
//             x: 449
//             y: 34
//             width: 913
//             height: 117
//             color: "#cecece"
//             radius: 75

//             // TextInput {
//             //     id: textInput
//             //     x: 130
//             //     y: 1
//             //     width: 654
//             //     height: 115
//             //     color: '#000000'
//             //     text: ""
//             //     font.pixelSize: 50
//             //     verticalAlignment: Text.AlignVCenter
//             //     font.family: "Segoe UI"

//             //     // Placeholder overlay
//             //     Text {
//             //         anchors.fill: parent
//             //         verticalAlignment: Text.AlignVCenter
//             //         color: "#767676"
//             //         text: "Search..."
//             //         visible: !parent.activeFocus && parent.text.length === 0
//             //         font.pixelSize: 50
//             //         MouseArea {
//             //             anchors.fill: parent
//             //             onClicked: parent.forceActiveFocus()
//             //         }
//             //     }
//             // }

//             FocusScope {
//                 x: 130
//                 y: 0
//                 width: 654; height: 115

//                 TextInput {
//                     id: input
//                     anchors.fill: parent
//                     font.pixelSize: 50
//                     verticalAlignment: Text.AlignVCenter
//                     color: "#000"
//                     text: ""              // start empty
//                     focus: false
//                 }

//                 // Placeholder label (non-interactive so clicks pass through)
//                 Text {
//                     id: hint
//                     anchors.fill: input
//                     z: 1
//                     verticalAlignment: Text.AlignVCenter
//                     color: "#767676"
//                     text: "Search..."
//                     font.pixelSize: 50
//                     visible: !input.activeFocus && input.text.length === 0
//                     // Important: make sure the overlay doesn't eat events
//                     enabled: false
//                 }

//                 // Click helper that focuses the input while not stealing the event
//                 TapHandler {
//                     // Attach to the input’s area
//                     parent: input
//                     enabled: hint.visible
//                     onTapped: input.forceActiveFocus()
//                     // Passive by default; TextInput will still place the caret
//                 }
//             }

//             Image {
//                 id: image
//                 x: 41
//                 y: 26
//                 width: 64
//                 height: 68
//                 opacity: 0.388
//                 source: "qrc:/resources/icons/search.png"
//                 fillMode: Image.PreserveAspectFit
//             }
//         }

//         Rectangle {
//             id: rectangle3
//             x: 1414
//             y: 0
//             width: 26
//             height: 900
//             color: "#cecece"
//         }

//     }
// }
// }



