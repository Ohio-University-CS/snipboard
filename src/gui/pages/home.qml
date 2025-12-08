import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard 1.0  // for SnippetObject and ClipboardHelper type if needed
import QtQuick.Controls.Basic as Basic

Page {
    id: root
    visible: true
    width: 800
    height: 600
    title: "The home screen of SnipBoard"

    //Properties of delete dialog
    property int snippetDialogId: -1
    property string snippetDialogName: ""

    //Properties of edit dialog
    property int editDialogId: -1
    property string editDialogName: ""
    property string editDialogDescription: ""
    property string editDialogLanguage: ""
    property string editDialogContent: ""
    property bool editDialogFavorite: false

    //Properties of delete tag
    property int tagDialogId: -1
    property string tagDialogName: ""

    //checked tag ID list
    property var checkedTags: []
    property bool showAllSnippets: true
    
    //EDit dialog
    Dialog {
        id: editDialog
        title: "Edit Snippet"
        modal: true
        focus: true
        implicitWidth: 520
        anchors.centerIn: Overlay.overlay
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted: {
            // Trim and validate
            const trimmedName = root.editDialogName.trim();
            const trimmedContent = root.editDialogContent.trim();

            if (!trimmedName || !trimmedContent) {
                // Show error and prevent dialog from closing
                console.log("Validation failed: missing required fields");
                return;
            }

            // Perform the update
            snippetService.updateSnippet(root.editDialogId, trimmedName, root.editDialogDescription.trim(), (root.editDialogLanguage && root.editDialogLanguage.length) ? root.editDialogLanguage : "txt", trimmedContent, 0     // folderId for now
            , root.editDialogFavorite);
        }

        contentItem: ColumnLayout {
            spacing: 10

            Basic.TextField {
                id: editTitleField
                Layout.fillWidth: true
                placeholderText: "Title *"
                text: root.editDialogName
                onTextChanged: root.editDialogName = text
            }

            Basic.TextField {
                Layout.fillWidth: true
                placeholderText: "Short description"
                text: root.editDialogDescription
                onTextChanged: root.editDialogDescription = text
            }

            // Keep ComboBox in sync with current language
            Basic.ComboBox {
                Layout.fillWidth: true
                model: ["txt", "qml", "py", "js", "cpp"]
                currentIndex: {
                    const list = ["txt", "qml", "py", "js", "cpp"];
                    const cur = root.editDialogLanguage || "txt";
                    const idx = list.indexOf(cur);
                    return idx >= 0 ? idx : 0;
                }
                onCurrentTextChanged: root.editDialogLanguage = currentText
            }

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
                    text: root.editDialogContent
                    onTextChanged: root.editDialogContent = text
                }
            }
        }
    }

    //EDit dialog
    Dialog {
        id: editTagDialog
        title: "Edit Tag Name"
        modal: true
        focus: true
        implicitWidth: 350
        anchors.centerIn: Overlay.overlay
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted: {
            // Trim and validate
            const trimmedName = root.tagDialogName.trim();

            if (!trimmedName) {
                // Show error and prevent dialog from closing
                console.log("Validation failed: missing required fields");
                return;
            }

            // Perform the update
            tagService.updateTag(root.tagDialogId, root.tagDialogName);
        }

        contentItem: ColumnLayout {
            spacing: 10

            Basic.TextField {
                id: editTagTitleField
                Layout.fillWidth: true
                placeholderText: "Name *"
                text: root.tagDialogName
                onTextChanged: root.tagDialogName = text
            }
        }
    }

    Dialog {
        id: deleteTagDialog
        title: "Delete Tag?"
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel
        anchors.centerIn: Overlay.overlay
        ColumnLayout {
            //anchors.fill: parent
            anchors.margins: 20
            spacing: 10

            Label {
                text: "Are you sure you want to delete the tag: " + root.tagDialogName
                wrapMode: Text.WordWrap
                //color: "#000000"
            }
        }

        onAccepted: {
            tagService.deleteTag(root.tagDialogId);
        }
    }

    //Main bg rect
    Rectangle {
        id: bg_rect
        width: parent.width
        height: parent.height
        color: "#f4f4f4"

        //Lays out the snippet list and delete/reload buttons
        ColumnLayout {
            anchors.fill: parent
            spacing: 12
            anchors.margins: 12
            anchors.leftMargin: 145
            anchors.rightMargin: 15
            anchors.topMargin: 112
            anchors.bottomMargin: 79

            Label {
                text: "Snippets"
                font.pixelSize: 32
                font.bold: true
            }

            GridView {
                id: snippetGrid
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter
                clip: true
                cellWidth: 320
                cellHeight: 180
                model: snippetService.snippets

                property int columns: Math.floor(width / cellWidth)
                property int totalContentWidth: columns * cellWidth
                property int sidePadding: Math.max(0, (width - totalContentWidth) / 2)

                leftMargin: sidePadding
                rightMargin: sidePadding

                delegate: Rectangle {
                    width: snippetGrid.cellWidth - 16  // Add some margin
                    height: snippetGrid.cellHeight - 16
                    radius: 12
                    color: hovered ? '#eaeaea' : '#cfcfcf'
                    border.color: '#aeaeae'
                    border.width: 1

                    property bool hovered: false

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                    Behavior on border.color {
                        ColorAnimation {
                            duration: 150
                        }
                    }

                    // Copies snippet code to clipboard
                    MouseArea {
                        z: -1
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                        onClicked: {
                            snippetService.incrementCopiedSnippet(model.id);
                            Clipboard.copyText(String(model.data));
                            ToolTip.show("Code copied to clipboard!", 1200, root);
                        }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 8

                        // Header with title and copy icon
                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                Layout.fillWidth: true
                                text: name
                                font.bold: true
                                font.pixelSize: 16
                                color: "#222"
                                elide: Text.ElideRight
                                wrapMode: Text.NoWrap
                            }
                        }

                        //Selected language display
                        Rectangle {
                            Layout.preferredWidth: 30
                            Layout.preferredHeight: 20
                            radius: 4
                            color: "#734c91"

                            Text {
                                anchors.centerIn: parent
                                text: language
                                font.pixelSize: 10
                                font.bold: true
                                color: "white"
                            }
                        }

                        // Description area
                        Text {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: description
                            color: "#444"
                            font.pixelSize: 12
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                            maximumLineCount: 3
                        }

                        // Spacer to push buttons to bottom
                        Item {
                            Layout.fillHeight: true
                        }

                        // Bottom action buttons
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignBottom
                            spacing: 6

                            // Trash/Delete button (bottom left)
                            Button {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                padding: 0

                                contentItem: Text {
                                    anchors.centerIn: parent
                                    text: "🗑️"
                                    font.pixelSize: 16
                                }

                                background: Rectangle {
                                    radius: 6
                                    color: parent.hovered ? "#c0c0c0" : "#d0d0d0"
                                    border.color: "#999"
                                }

                                onClicked: {
                                    root.snippetDialogId = model.id;
                                    root.snippetDialogName = model.name;
                                    deleteDialog.open();
                                }

                                // Delete Dialog
                                Dialog {
                                    id: deleteDialog
                                    title: "Delete Snippet?"
                                    modal: true
                                    standardButtons: Dialog.Ok | Dialog.Cancel
                                    anchors.centerIn: Overlay.overlay

                                    ColumnLayout {
                                        anchors.margins: 20
                                        spacing: 10

                                        Label {
                                            text: "Are you sure you want to delete the snippet: " + root.snippetDialogName
                                            wrapMode: Text.WordWrap
                                        }
                                    }

                                    onAccepted: {
                                        snippetService.deleteSnippet(root.snippetDialogId);
                                    }
                                }
                            }

                            // Spacer
                            Item {
                                Layout.fillWidth: true
                            }

                            // Edit button
                            Basic.Button {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                icon.source: "qrc:/resources/icons/edit.png"
                                icon.height: 16
                                icon.width: 16
                                padding: 4

                                background: Rectangle {
                                    radius: 6
                                    color: parent.hovered ? '#ffffff' : "#e8e8e8"
                                    border.color: "#999"
                                }

                                onClicked: {
                                    root.editDialogId = model.id;
                                    root.editDialogName = model.name;
                                    root.editDialogDescription = model.description;
                                    root.editDialogLanguage = model.language;
                                    root.editDialogContent = model.data;
                                    root.editDialogFavorite = model.favorite;
                                    editDialog.open();
                                }
                            }

                            // Favorite button
                            Button {
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                padding: 0

                                display: AbstractButton.IconOnly

                                icon.source: favorite ? "qrc:/resources/icons/gold_star.png" : "qrc:/resources/icons/star.png"
                                icon.width: 20
                                icon.height: 20

                                icon.color: "transparent"

                                background: Rectangle {
                                    radius: 6
                                    color: parent.hovered ? '#ffffff' : "#e8e8e8"
                                    border.color: "#999"
                                }

                                onClicked: {
                                    snippetService.toggleFavorite(model.id);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // --- Control Row ---

    Rectangle {
        id: selection_rect
        x: 0
        y: 0
        width: 124
        height: 600
        color: "#cfcfcf"

        // Home
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
            onClicked: {
                snippetService.loadAll();
                snippetService.sortByDateModified(false);
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
                color: fav_button.down ? '#b0962f' : (fav_button.hovered ? '#d4b435' : '#ae962b')
            }
            onClicked: {
                snippetService.loadFavoriteSnippets();
                snippetService.sortByDateModified(false);
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
            onClicked: {
                if (settingsLoader.visible) {
                    settingsLoader.visible = false;
                    settingsLoader.source = "";
                } else {
                    settingsLoader.source = "qrc:/qt/qml/SnipBoard/src/gui/pages/settings.qml";
                    settingsLoader.visible = true;
                }
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

        //tags column

        ColumnLayout {
            y: 271
            width: 112
            height: 227
            anchors.horizontalCenter: parent.horizontalCenter
            RowLayout {

                Label {
                    text: " Tags"
                    font.pixelSize: 20
                    font.bold: true
                }
                Basic.Button {
                    id: showAllButton
                    implicitWidth: 55
                    implicitHeight: 22
                    padding: 0

                    property bool showAllSnippets: root.showAllSnippets
                    Text {
                        text: "Show All"
                        anchors.centerIn: parent
                        font.pixelSize: 10 
                        color: "#222"
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        radius: 8
                        color: (showAllButton.showAllSnippets || showAllButton.down)
                               ? "#797979"
                               : (showAllButton.hovered ? "#969696" : "#b4b4b4")
                    }

                    onClicked: {
                        root.showAllSnippets = !root.showAllSnippets

                        if(root.showAllSnippets){
                            snippetService.loadAll()
                        }
                        else {
                            //snippetService.loadByAny(root.checkedTags)
                        }
                    }
                }
            }

            //tags rectangle
            Rectangle {
                radius: 8
                color: "#e6e6e6"
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                layer.enabled: true

                // -- TAG LIST --
                
                ListView {
                    id: tagList
                    anchors.fill: parent
                    clip: true
                    spacing: 2
                    topMargin: 2
                    bottomMargin: 2
                    width: 83
                    height: 154
                    model: tagService.tags

                    delegate: Rectangle {
                        id: tagBackground
                        width: parent.width - 5
                        height: tagRow.implicitHeight + 10
                        radius: 4
                        color: hovered ? "#e0e0e0" : "white"
                        border.color: "#cccccc"
                        anchors.horizontalCenter: parent.horizontalCenter

                        property alias checkbox: tagChecked
                        property bool hovered: false

                        //Copies tag to clipboard
                        MouseArea {
                            z: -1
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: parent.hovered = true
                            onExited: parent.hovered = false
                            onClicked: {
                                tagChecked.checked = !tagChecked.checked;
                            }
                        }

                        // tags
                        RowLayout {
                            id: tagRow
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.margins: 5
                            spacing: 8

                            Item {
                                Layout.fillWidth: true
                                Layout.preferredHeight: tagText.implicitHeight

                                Text {
                                    id: tagText
                                    text: name
                                    wrapMode: Text.Wrap
                                    font.bold: true
                                    font.pixelSize: 10
                                    color: "#333"
                                    width: parent.width
                                }
                            }

                            ColumnLayout {
                                spacing: 2

                                Button {
                                    id: deleteTagButton
                                    Layout.preferredHeight: 11
                                    Layout.preferredWidth: 11
                                    padding: 0
                                    Text {
                                        anchors.centerIn: parent
                                        text: "❌"
                                        font.pixelSize: 6
                                    }
                                    background: Rectangle {
                                        width: parent.width
                                        height: parent.height
                                        radius: 1
                                        color: "#e5e5e5"
                                        border.color: "#bcbcbc"
                                    }
                                    //Layout.alignment: Qt.AlignRight
                                    onClicked: {//snippetService.deleteSnippet(id)
                                        root.tagDialogId = model.id;
                                        root.tagDialogName = model.name;
                                        deleteTagDialog.open();
                                    }
                                }

                                Basic.Button {
                                    id: edit_tag_button
                                    Layout.alignment: Qt.AlignRight
                                    icon.source: "qrc:/resources/icons/edit.png"
                                    icon.height: 6
                                    icon.width: 6
                                    implicitHeight: 11
                                    implicitWidth: 11
                                    padding: 0
                                    background: Rectangle {
                                        width: parent.width
                                        height: parent.height
                                        radius: 1
                                        color: hovered ? '#ffffff' : "#f2f2f2"
                                        border.color: "#d0d0d0"
                                    }

                                    onClicked: {
                                        // pull roles from this row
                                        root.tagDialogId = model.id;
                                        root.tagDialogName = model.name;
                                        editTagDialog.open();  // <-- open the page-level dialog
                                    }
                                }

                                CheckBox {
                                    id: tagChecked
                                    Layout.preferredWidth: 11
                                    Layout.preferredHeight: 11
                                    checked: tag.checked
                                    padding: 0

                                    onCheckedChanged: {
                                        tag.checked = checked
                                        if(checked === true) {
                                            root.checkedTags.push(model.id)

                                        }
                                        else { //checked === false
                                            var index = root.checkedTags.indexOf(model.id)
                                            if(index !== -1) {
                                                root.checkedTags.splice(index, 1) //removes tag from list of checked tags
                                            }
                                        }
                                        //snippetService.loadByAnyTags(root.checkedTags)
                                        //uncomment this ^^^ once function is added to snippetService 
                                        root.showAllSnippets = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
            RowLayout {
                height: 30
                Layout.fillWidth: true
                spacing: 0
                Basic.Button {
                    id: newTagButton
                    implicitWidth: 52
                    implicitHeight: 22
                    padding: 0
                    Text {
                        text: "New tag"
                        anchors.centerIn: parent
                        font.pixelSize: 10
                        color: "#222"
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        radius: 8
                        color: newTagButton.down ? '#797979' : (newTagButton.hovered ? '#969696' : '#b4b4b4')
                    }
                    onClicked: newTagDialog.open()

                    Dialog {
                        id: newTagDialog
                        title: "New Tag"
                        modal: true
                        focus: true
                        implicitWidth: 520
                        anchors.centerIn: Overlay.overlay       // center over the whole window
                        standardButtons: Dialog.Ok | Dialog.Cancel

                        // simple model of the form's values
                        property string fTitle: ""

                        // reset when opened/closed
                        onOpened: {
                            fTitle = "";
                            tagTitleField.forceActiveFocus();
                        }

                        // validate + submit
                        onAccepted: {
                            if (!fTitle.trim()) {
                                // keep dialog open and show error
                                tagError.visible = true;
                                // prevent Dialog from auto-closing
                                newTagDialog.open();
                                return;
                            }
                            // Call whichever API you exposed:
                            // If you registered a singleton: SnippetService.createSnippet(...)
                            // If you set a context property:  snippetService.createSnippet(...)
                            (typeof TagService !== "undefined" ? TagService : tagService).createTag(fTitle);
                        }

                        contentItem: ColumnLayout {
                            spacing: 10

                            Label {
                                id: tagError
                                text: "Title is required."
                                color: "#b00020"
                                visible: false
                                Layout.fillWidth: true
                            }

                            // Title
                            Basic.TextField {
                                id: tagTitleField
                                Layout.fillWidth: true
                                maximumLength: 30
                                placeholderText: "Title *"
                                text: newTagDialog.fTitle
                                onTextChanged: {
                                    newTagDialog.fTitle = text;
                                    tagError.visible = false;
                                }
                            }
                        }
                    }
                }
                Item { //spacer
                    Layout.fillWidth: true
                }

                Basic.Button {
                    id: reloadTagButton
                    implicitWidth: 45
                    implicitHeight: 22
                    padding: 0
                    Text {
                        text: "Reload"
                        anchors.centerIn: parent
                        font.pixelSize: 10     // <-- CHANGE TEXT SIZE HERE
                        color: "#222"
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        radius: 8
                        color: reloadTagButton.down ? '#797979' : (reloadTagButton.hovered ? '#969696' : '#b4b4b4')
                    }
                    onClicked: tagService.reload()
                }
            }
        }
    }

    Rectangle {
        id: search_rect
        x: 139
        y: 18
        width: 642
        height: 79
        radius: 12          // <- round the corners
        clip: true          // keeps children clipped to the rounded shape
        color: "#cfcfcf"

        FocusScope {
            x: 58
            y: 0
            width: 584
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
                anchors.rightMargin: 27
                anchors.topMargin: 0
                anchors.bottomMargin: 8
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
            y: 16
            width: 42
            height: 39
            display: AbstractButton.IconOnly
            padding: 0   // so the image centers nicely

            // custom content so we can control opacity
            contentItem: Item {
                anchors.fill: parent
                Image {
                    id: search_icon
                    anchors.centerIn: parent
                    source: "qrc:/resources/icons/search.png"
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: 1
                    width: 38
                    height: 32
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
            x: 599
            y: 29
            width: 36
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
            x: 8
            y: 56
            width: 61
            height: 18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: `${snippetGrid.count} results`
        }
    }

    Rectangle {
        id: sort_rect
        x: 541
        y: search_rect.y + search_rect.height + 8
        width: 240  // Increased width to fit both dropdowns
        height: 45
        radius: 8
        color: "#cfcfcf"

        // Function to apply the current sort
        function applyCurrentSort() {
            switch (sortCombo.currentIndex) {
            case 0:
                snippetService.sortByDateModified(false);
                break;
            case 1:
                snippetService.sortByDateModified(true);
                break;
            case 2:
                snippetService.sortByMostCopied(false);
                break;
            case 3:
                snippetService.sortByMostCopied(true);
                break;
            case 4:
                snippetService.sortByName(true);
                break;
            case 5:
                snippetService.sortByName(false);
                break;
            }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            anchors.leftMargin: 8
            anchors.rightMargin: 19
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            spacing: 12

            // Sort dropdown
            Label {
                text: "Sort:"
                font.pixelSize: 14
                color: "#333"
            }

            Basic.ComboBox {
                id: sortCombo
                Layout.preferredWidth: 180
                Layout.alignment: Qt.AlignVCenter

                model: ["Last Edited (Newest)", "Last Edited (Oldest)", "Most Popular", "Least Popular", "Name (A-Z)", "Name (Z-A)"]

                onActivated: function (index) {
                    sort_rect.applyCurrentSort();
                }
            }
        }
    }

    Basic.Button {
        id: reload_button
        x: 253
        y: 540
        width: 90
        height: 40
        text: "Reload"
        padding: 0
        background: Rectangle {
            radius: 12
            color: reload_button.down ? '#797979' : (reload_button.hovered ? '#969696' : '#cfcfcf')
        }
        onClicked: {
            snippetService.reload();
            sort_rect.applyCurrentSort(); //reapplies that previous sorting method
        }
    }

    Basic.Button {
        id: addSnippetBtn
        x: 149
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

                (typeof SnippetService !== "undefined" ? SnippetService : snippetService).createSnippet(fTitle, fDesc, fLang.length ? fLang : "txt", fCode, 0      // folderId (adjust as needed)
                , false   // favorite flag
                );

                snippetService.reload();
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
                    model: ["txt", "qml", "py", "js", "cpp"]
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

    // --- SETTINGS LOADER ---
    Loader {
        id: settingsLoader
        source: ""
        anchors.fill: parent
        visible: false
        onLoaded: {
            item.parentLoader = settingsLoader;
        }
    }
}
