import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard 1.0  // for SnippetObject and ClipboardHelper type if needed
import QtQuick.Controls.Basic as Basic

Item {
    id: favoritesRoot
    property Loader parentLoader
    width: 800
    height: 600
    MouseArea {
        //prevents mouse clicks from going through
        anchors.fill: parent
        z: 50
        hoverEnabled: true
    }

    Rectangle {
        id: favoritesBg
        width: parent.width
        height: parent.height
        visible: true
        color: "#f4f4f4"

        //Lays out the snippet list and delete/reload buttons
        ColumnLayout {
            anchors.fill: parent
            spacing: 12
            anchors.margins: 12
            anchors.leftMargin: 136
            anchors.rightMargin: 12
            anchors.topMargin: 109
            anchors.bottomMargin: 66

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

                    //Copies snippet code to clipboard
                    MouseArea {
                        z: -1
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                        onClicked: {
                            Clipboard.copyText(String(model.data));
                            ToolTip.show("Code copied", 1200, root);
                        }
                    }

                    //Displays snippet in list
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

                        // Wrap both buttons in a RowLayout
                        RowLayout {
                            Layout.alignment: Qt.AlignRight
                            spacing: 4  // Space between the two buttons

                            //Edit a snippet
                            Basic.Button {
                                id: edit_button
                                Layout.alignment: Qt.AlignRight
                                icon.source: "qrc:/resources/icons/edit.png" 
                                icon.height: 14
                                icon.width: 14
                                implicitHeight: 28
                                implicitWidth: 28
                                padding: 6
                                background: Rectangle {
                                    radius: 8
                                    color: hovered ? '#ffffff' : "#f2f2f2"
                                    border.color: "#d0d0d0"
                                }

                                onClicked: {
                                    // pull roles from this row
                                    root.editDialogId = model.id;
                                    root.editDialogName = model.name;
                                    root.editDialogDescription = model.description;
                                    root.editDialogLanguage = model.language;
                                    root.editDialogContent = model.data;
                                    editDialog.open();  // <-- open the page-level dialog
                                }
                            }

                            //Delete a snippet
                            Button {
                                id: favButton
                                height: 42
                                width: 46
                                implicitWidth: width
                                implicitHeight: height
                                padding: 0
                                Text {
                                    anchors.centerIn: parent
                                    text: favorite ? "⭐" : "☆"
                                    font.pixelSize: favorite ? 16 : 22
                                    color: "#a7a7a7"
                                }
                                onClicked: {
                                    snippetService.toggleFavorite(id)
                                    snippetService.reload()
                                }
                            }

                            Button {
                                height: 42
                                width: 46
                                implicitWidth: width
                                implicitHeight: height
                                Text {
                                    anchors.centerIn: parent
                                    text: "❌"
                                }
                                padding: 0
                                //Layout.alignment: Qt.AlignRight
                                onClicked: {//snippetService.deleteSnippet(id)
                                    root.snippetDialogId = id
                                    root.snippetDialogName = name
                                    deleteDialog.open()
                                } 

                                                // --- Delete Snippet Dialog ---
                                Dialog {
                                    id: deleteDialog
                                    title: "Delete Snippet?"
                                    modal: true
                                    standardButtons: Dialog.Ok | Dialog.Cancel
                                    anchors.centerIn: Overlay.overlay
                                    ColumnLayout {
                                        //anchors.fill: parent
                                        anchors.margins: 20
                                        spacing: 10

                                        Label {
                                            text: "Are you sure you want to delete the snippet: " + root.snippetDialogName
                                            wrapMode: Text.WordWrap
                                            //color: "#000000"
                                        }
                                    }

                                    onAccepted: {
                                        snippetService.deleteSnippet(root.snippetDialogId)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}