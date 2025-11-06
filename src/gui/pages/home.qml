import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import SnipBoard 1.0  // for SnippetObject type if needed
import QtQuick.Controls.Basic as Basic   // <-- add this

Page {
    id: root
    visible: true
    width: 800
    height: 600
    title: "Snippet Testing File"

    // --- Clipboard (Qt 6.5+). Falls back to a hidden TextEdit if needed.
    function copyToClipboard(text) {
        if (Qt.application && Qt.application.clipboard && Qt.application.clipboard.setText) {
            Qt.application.clipboard.setText(text);
        } else {
            clipper.text = text;
            clipper.forceActiveFocus();
            clipper.selectAll();
            clipper.copy();
            root.forceActiveFocus();   // was root.*
        }
    }

    // Hidden fallback editor
    TextEdit {
        id: clipper
        visible: false
        focus: false
    }

    Rectangle {
        id: bg_rect
        width: parent.width
        height: parent.height
        color: "#f4f4f4"

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

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                        onClicked: {
                            // Copy the snippet's code to clipboard
                            root.copyToClipboard("NEED TO PUT CODE HERE");   // or model.code if that’s your role
                            //Tell user code copied
                            ToolTip.show("Code copied", 1200, root);
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
                width: 52
                height: 52
                display: AbstractButton.IconOnly
                icon.source: "qrc:/resources/icons/home.png"
                icon.width: 32
                icon.height: 32
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
                width: 52
                height: 52
                display: AbstractButton.IconOnly
                icon.source: "qrc:/resources/icons/star.png"
                icon.width: 30
                icon.height: 30
                background: Rectangle {
                    radius: 12
                    color: fav_button.down ? '#958235' : (fav_button.hovered ? '#c7af4b' : '#b19b3b')
                }
            }

            // Settings
            Basic.Button {
                id: settings_button
                x: 36
                y: 533
                width: 52
                height: 52
                display: AbstractButton.IconOnly
                icon.source: "qrc:/resources/icons/setting.png"
                icon.width: 30
                icon.height: 30
                background: Rectangle {
                    radius: 12
                    color: settings_button.down ? '#797979' : (settings_button.hovered ? '#828181' : '#a9a8a8')
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
            radius: 12          // <- round the corners
            clip: true          // keeps children clipped to the rounded shape
            color: "#cfcfcf"

            FocusScope {
                x: 58
                y: 0
                width: 594
                height: 82

                // Debounce timer so we don't call search on every keystroke immediately
                Timer {
                    id: debounceSearch
                    interval: 200
                    repeat: false
                    onTriggered: snippetService.search(input.text.trim())
                }

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
                    // ... your existing props ...
                    onTextChanged: debounceSearch.restart()

                    // Enter = search now, Esc = clear
                    Keys.onPressed: function (e) {
                        if (e.key === Qt.Key_Return || e.key === Qt.Key_Enter) {
                            snippetService.search(input.text.trim());
                            e.accepted = true;
                        } else if (e.key === Qt.Key_Escape) {
                            input.text = "";
                            snippetService.search("");       // reset to all
                            e.accepted = true;
                        }
                    }
                }

                // Placeholder label (non-interactive so clicks pass through)
                Text {
                    id: hint
                    x: 0
                    y: 0
                    width: 586
                    height: 82
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
                y: 17
                width: 42
                height: 38
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
                        width: 28
                        height: 28
                        opacity: search_button.enabled ? (search_button.down ? 0.55 : (search_button.hovered ? 0.25 : .40)) : 0.35
                        Behavior on opacity {
                            NumberAnimation {
                                duration: 120
                            }
                        }
                        fillMode: Image.PreserveAspectFit
                    }
                }
                background: Rectangle {
                    radius: 10
                    color: search_button.down ? '#cdcdcd' : (search_button.hovered ? '#d7d7d7' : "#cfcfcf")
                }

                onClicked: snippetService.search(input.text.trim())
            }

            Basic.Button {
                id: clearBtn
                x: 620
                y: 29
                width: 24
                height: 26
                // shows only an "x"
                Accessible.name: "Clear search"
                padding: 6
                background: null                 // <- no background at all
                focusPolicy: Qt.NoFocus          // avoid focus ring if any
                contentItem: Text {
                    text: "✕"
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: clearBtn.pressed ? "#555" : (clearBtn.hovered ? "#777" : "#999")
                    opacity: clearBtn.enabled ? 1 : 0.4
                }

                // click action
                onClicked: {
                    input.text = "";
                    snippetService.search("");
                }
            }

            Label {
                x: 17
                y: 58
                width: 44
                height: 16
                text: `${snippetList.count} results`
            }
        }

        Basic.Button {
            id: reload_button
            x: 246
            y: 540
            width: 90
            height: 40
            text: "Reload"
            padding: 0
            background: Rectangle {
                radius: 12
                color: reload_button.down ? '#797979' : (reload_button.hovered ? '#969696' : '#cfcfcf')
            }
            onClicked: snippetService.loadSnippetsFromDb()
        }

        Basic.Button {
            id: addSnippetBtn
            x: 142
            y: 540
            width: 90
            height: 40
            text: "Add Snippet"
            padding: 0
            background: Rectangle {
                radius: 12
                color: addSnippetBtn.down ? '#797979' : (addSnippetBtn.hovered ? '#969696' : '#cfcfcf')
            }
            onClicked: newSnippetDialog.open()

            Dialog {
                id: newSnippetDialog
                title: "New Snippet"
                modal: true
                focus: true
                implicitWidth: 520
                anchors.centerIn: Overlay.overlay       // center over the whole window
                standardButtons: Dialog.Ok | Dialog.Cancel

                // simple model of the form's values
                property string fTitle: ""
                property string fDesc: ""
                property string fLang: ""
                property string fCode: ""

                // reset when opened/closed
                onOpened: {
                    fTitle = "";
                    fDesc = "";
                    fLang = "";
                    fCode = "";
                    titleField.forceActiveFocus();
                }

                // validate + submit
                onAccepted: {
                    if (!fTitle.trim() || !fCode.trim()) {
                        // keep dialog open and show error
                        err.visible = true;
                        // prevent Dialog from auto-closing
                        newSnippetDialog.open();
                        return;
                    }
                    // Call whichever API you exposed:
                    // If you registered a singleton: SnippetService.createSnippet(...)
                    // If you set a context property:  snippetService.createSnippet(...)
                    (typeof SnippetService !== "undefined" ? SnippetService : snippetService).createSnippet(fTitle, fDesc, fLang.length ? fLang : "Plain Text", fCode, 0      // folderId (adjust as needed)
                    , false   // favorite flag
                    );
                }

                contentItem: ColumnLayout {
                    spacing: 10

                    Label {
                        id: err
                        text: "Title and Code are required."
                        color: "#b00020"
                        visible: false
                        Layout.fillWidth: true
                    }

                    // Title
                    Basic.TextField {
                        id: titleField
                        Layout.fillWidth: true
                        placeholderText: "Title *"
                        text: newSnippetDialog.fTitle
                        onTextChanged: {
                            newSnippetDialog.fTitle = text;
                            err.visible = false;
                        }
                    }

                    // Description
                    Basic.TextField {
                        Layout.fillWidth: true
                        placeholderText: "Short description"
                        text: newSnippetDialog.fDesc
                        onTextChanged: newSnippetDialog.fDesc = text
                    }

                    // Language
                    Basic.ComboBox {
                        Layout.fillWidth: true
                        model: ["C++", "QML", "Python", "JavaScript", "Plain Text"]
                        currentIndex: 0
                        onCurrentTextChanged: newSnippetDialog.fLang = currentText
                    }

                    //Code editor
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6

                        Label {
                            text: "Code *"
                        }

                        Frame {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 220
                            background: Rectangle {
                                radius: 8
                                color: "white"
                                border.color: "#ddd"
                            }

                            Basic.TextArea {
                                anchors.fill: parent
                                anchors.margins: 12
                                wrapMode: TextArea.Wrap
                                placeholderText: "// Paste or type your snippet here"
                                text: newSnippetDialog.fCode
                                onTextChanged: newSnippetDialog.fCode = text
                            }
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0}D{i:39;invisible:true}
}
##^##*/
