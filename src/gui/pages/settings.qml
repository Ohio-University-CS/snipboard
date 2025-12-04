import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard 1.0  // for SnippetObject and ClipboardHelper type if needed
import QtQuick.Controls.Basic as Basic   // <-- add this

Item {
    id: settingsRoot
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
        id: settingsBg
        x: 0
        y: 0
        width: 800
        height: 600
        visible: true
        z: 51

        Row {
            id: row
            x: 0
            y: 0
            width: 800
            height: 600
            
            Rectangle {
                id: settingsMenu
                width: 124
                height: parent.height
                color: "#cfcfcf"
                visible: true
                // Home
                Basic.Button {
                    id: home_button
                    x: 36
                    y: 533
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
                        if(settingsRoot.parentLoader) {
                            settingsRoot.parentLoader.visible = false
                            settingsRoot.parentLoader.source = null
                        }
                    }
                }
                
                ColumnLayout {
                    id: columnLayout
                    x: 10
                    y: 134
                    width: 104
                    height: 320
                    
                    Basic.Button {
                        id: toAppearance
                        text: "Appearance"
                        contentItem: Text {
                                text: toAppearance.text
                                color: "#333333"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                        }
                        Layout.fillWidth: true
                        height: 25

                        background: Rectangle{
                            radius: 8
                            color: toAppearance.down ? '#bfbfbf' : (toAppearance.hovered ? '#d0d0d0' : '#c0c0c0')
                        }
                        onClicked: scroll.contentY = 0
                    }
                    Basic.Button {
                        id: toEditorAppearance
                        text: "Editor\nAppearance"
                        contentItem: Text {
                                text: toEditorAppearance.text
                                color: "#333333"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                        }
                        Layout.fillWidth: true
                        height: 25

                        background: Rectangle{
                            radius: 8
                            color: toEditorAppearance.down ? '#bfbfbf' : (toEditorAppearance.hovered ? '#d0d0d0' : '#c0c0c0')
                        }
                        onClicked: scroll.contentY = editorAppearanceColumn.y - 10
                    }
                    Basic.Button {
                        id: toSnippetBehavior
                        text: "Snippet\nBehavior"
                        contentItem: Text {
                                text: toSnippetBehavior.text
                                color: "#333333"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                        }
                        Layout.fillWidth: true
                        height: 25

                        background: Rectangle{
                            radius: 8
                            color: toSnippetBehavior.down ? '#bfbfbf' : (toSnippetBehavior.hovered ? '#d0d0d0' : '#c0c0c0')
                        }
                        onClicked: scroll.contentY = snippetBehaviorColumn.y - 10
                    }
                    Basic.Button {
                        id: toSnippetOrganization
                        text: "Snippet\nOrganization"
                        contentItem: Text {
                                text: toSnippetOrganization.text
                                color: "#333333"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                        }
                        Layout.fillWidth: true
                        height: 25

                        background: Rectangle{
                            radius: 8
                            color: toSnippetOrganization.down ? '#bfbfbf' : (toSnippetOrganization.hovered ? '#d0d0d0' : '#c0c0c0')
                        }
                        onClicked: scroll.contentY = snippetOrganizationColumn.y - 10
                    }
                    Basic.Button {
                        id: toExportOptions
                        text: "Export\nOptions"
                        contentItem: Text {
                                text: toExportOptions.text
                                color: "#333333"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                        }
                        Layout.fillWidth: true
                        height: 25

                        background: Rectangle{
                            radius: 8
                            color: toExportOptions.down ? '#bfbfbf' : (toExportOptions.hovered ? '#d0d0d0' : '#c0c0c0')
                        }
                        onClicked: scroll.contentY = snippetOrganizationColumn.y - 10
                    }
                    Basic.Button {
                        id: toImportOptions
                        text: "Import\nOptions"
                        contentItem: Text {
                                text: toImportOptions.text
                                color: "#333333"
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                        }
                        Layout.fillWidth: true
                        height: 25

                        background: Rectangle{
                            radius: 8
                            color: toImportOptions.down ? '#bfbfbf' : (toImportOptions.hovered ? '#d0d0d0' : '#c0c0c0')
                        }
                        onClicked: scroll.contentY = snippetOrganizationColumn.y - 10
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
                id: settingsOptions
                width: parent.width - settingsMenu.width
                height: parent.height
                color: "#f4f4f4"
                visible: true

                Label {
                    x: 21
                    y: 29
                    text: "Settings"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#000000"
                }

                    Flickable {
                        id: scroll
                        x: 31
                        y: 76
                        width: 615
                        height: 487
                        contentHeight: parentColumn.implicitHeight
                        contentWidth: width
                        clip: true
                        
                        Rectangle {
                            id: scrollRectangle
                            anchors.fill: parent
                            color: "#ffffff"
                            radius: 8
                        }
                        ColumnLayout {
                            id: parentColumn
                            x: 0
                            y: 0
                            width: 610
                            height: 678
                            Layout.margins: 10
                            //Layout.fillWidth: true
    
                            Item{
                                id: appearanceSpacer
                                height: 2
                                Layout.fillWidth: true
                            }
                            ColumnLayout {
                                id: appearanceColumn
                                Layout.margins: 10
                                Layout.fillWidth: true

                                RowLayout {
                                    spacing: 8
                                

                                    Label {
                                        color: "#000000"
                                        text: "Appearance"
                                        font.pixelSize: 18
                                        font.styleName: "Bold"
                                    }
                                    
                                    Rectangle{ 
                                        id: sectionSeparator
                                        height: 2
                                        color: "#212121"
                                        Layout.fillWidth: true
                                        Layout.alignment: AlignVCenter
                                    }
                                }
    
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
                                    
                                    Label {
                                        color: "#545454"
                                        text: "Theme:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    ComboBox {
                                        id: themeControl
                                        width: 100
                                        height: 25
                                        model: ["Light", "Dark"]
                                        currentIndex: settingsService.theme()
                                        contentItem: Text {
                                                text: themeControl.displayText
                                                color: "#000000"
                                                font: themeControl.font
                                                verticalAlignment: Text.AlignVCenter
                                        }
                                        Layout.rightMargin: 50

                                        onCurrentIndexChanged: settingsService.setTheme(currentIndex)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Changes the theme of the whole application"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                            }
                            ColumnLayout {
                                id: editorAppearanceColumn
                                Layout.margins: 10
                                Layout.fillWidth: true
                                RowLayout {
                                    spacing: 8
                                
                                    Label {
                                        color: "#000000"
                                        text: "Editor Appearance"
                                        font.pixelSize: 18
                                        font.styleName: "Bold"
                                    }
                                    Rectangle{ 
                                        id: sectionSeparator2
                                        height: 2
                                        color: "#212121"
                                        Layout.fillWidth: true
                                        Layout.alignment: AlignVCenter
                                    }
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
                                    
                                    Label {
                                        color: "#545454"
                                        text: "Editor font size:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    Slider {
                                        id: fontSlider
                                        from: 10
                                        to: 24
                                        value: 14
                                        stepSize: 1
                                        width: 200
                                        height: 30
    
                                        onValueChanged: settingsService.setEditorFontSize(value)
                                    }
                                    
                                    Label {
                                        color: "#545454"
                                        text: Math.round(fontSlider.value) + "px"
                                        Layout.rightMargin: 60
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls font size in the editor"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Editor font family:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    ComboBox {
                                        id: fontControl
                                        width: 100
                                        height: 25
                                        model: ["Consolas", "JetBrains Mono", "Fira Code", "Source Code Pro"]
                                        currentIndex: 0
                                        contentItem: Text {
                                                text: fontControl.displayText
                                                color: "#000000"
                                                font: fontControl.font
                                                verticalAlignment: Text.AlignVCenter
                                        }
                                        Layout.rightMargin: 50

                                        onCurrentIndexChanged: settingsService.setEditorFontFamily(currentIndex)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls font style in the editor"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
                                    
                                    Label {
                                        color: "#545454"
                                        text: "Line numbers:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    Switch {
                                        id: lineNumbersSwitch
                                        checked: true
    
                                        onCheckedChanged: settingsService.setLineNumbers(checked)
                                        Layout.rightMargin: 50
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Enables/Disables line numbers in the editor"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Syntax highlighting:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
    
                                    Switch {
                                        id: syntaxHighlightingSwitch
                                        checked: true
    
                                        onCheckedChanged: settingsService.setSyntaxHighlighting(checked)

                                        Layout.rightMargin: 50
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Enables/Disables syntax highlighting in the editor"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                
                            }
                            ColumnLayout {
                                id: snippetBehaviorColumn
                                Layout.fillWidth: true
                                Layout.margins: 10
                                RowLayout {
                                    spacing: 8
                                    Label {
                                        color: "#000000"
                                        text: "Snippet Behavior"
                                        font.pixelSize: 18
                                        font.styleName: "Bold"
                                    }
                                    Rectangle{ 
                                        id: sectionSeparator3
                                        height: 2
                                        color: "#212121"
                                        Layout.fillWidth: true
                                        Layout.alignment: AlignVCenter
                                    }
                                }
    
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Wrap lines:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    Switch {
                                        id: wrapLinesSwitch
                                        checked: false
    
                                        onCheckedChanged: settingsService.setWrapLines(checked)
                                        
                                        Layout.rightMargin: 50
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         When enabled, automatically wrap long lines in the snippet editor"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Confirm before delete:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    Switch {
                                        id: confirmDeleteSwitch
                                        checked: true
    
                                        onCheckedChanged: settingsService.setConfirmBeforeDelete(checked)
                                        
                                        Layout.rightMargin: 50
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         When enabled, deleting snippets required confirmation"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                
                                
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Tab size:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    ComboBox {
                                        id: tabControl
                                        width: 100
                                        height: 25
                                        model: ["2", "4", "8"]
                                        currentIndex: 1
                                        contentItem: Text {
                                                text: tabControl.displayText
                                                color: "#000000"
                                                font: tabControl.font
                                                verticalAlignment: Text.AlignVCenter
                                        }
                                        Layout.rightMargin: 50

                                        onCurrentIndexChanged: settingsService.setTabSize(currentIndex)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls size of tabs in the editor"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Default language:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    ComboBox {
                                        id: languageControl
                                        width: 100
                                        height: 25
                                        model: ["cpp", "py", "cs", "java", "js", "ts"]
                                        currentIndex: 0
                                        contentItem: Text {
                                                text: languageControl.displayText
                                                color: "#000000"
                                                font: languageControl.font
                                                verticalAlignment: Text.AlignVCenter
                                        }
                                        Layout.rightMargin: 50

                                        onCurrentIndexChanged: settingsService.setDefaultLanguage(currentText)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls the default language selected when creating a new snippet"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                            }
                            ColumnLayout {
                                id: snippetOrganizationColumn
                                Layout.fillWidth: true
                                Layout.margins: 10
                                RowLayout {
                                    spacing: 8
                                    Label {
                                        color: "#000000"
                                        text: "Snippet Organization"
                                        font.pixelSize: 18
                                        font.styleName: "Bold"
                                    }
                                    Rectangle{ 
                                        id: sectionSeparator4
                                        height: 2
                                        color: "#212121"
                                        Layout.fillWidth: true
                                        Layout.alignment: AlignVCenter
                                    }
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Default sort method:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    ComboBox {
                                        id: defaultSortControl
                                        width: 100
                                        height: 25
                                        model: ["Alphabetical", "Last modified", "Last created", "Favorites first"]
                                        currentIndex: 1
                                        contentItem: Text {
                                                text: defaultSortControl.displayText
                                                color: "#000000"
                                                font: defaultSortControl.font
                                                verticalAlignment: Text.AlignVCenter
                                        }
                                        Layout.rightMargin: 50

                                        onCurrentIndexChanged: settingsService.setDefaultSortMethod(currentText)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls the default sorting of snippets"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Default snippet folder:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    ComboBox {
                                        id: defaultFolderControl
                                        width: 100
                                        height: 25 
                                        model: ["Folder1", "Folder2", "Another folder", "My folder"]
                                        currentIndex: 3
                                        contentItem: Text {
                                                text: defaultFolderControl.displayText
                                                color: "#000000"
                                                font: defaultFolderControl.font
                                                verticalAlignment: Text.AlignVCenter
                                        }
                                        Layout.rightMargin: 50

                                        onCurrentIndexChanged: settingsService.setDefaultSnippetFolder(currentIndex)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls the default snippet folder when creating a new snippet"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                            }
                            
                            ColumnLayout {
                                id: exportOptionsColumn
                                Layout.fillWidth: true
                                Layout.margins: 10
                                RowLayout {
                                    spacing: 8
                                    Label {
                                        color: "#000000"
                                        text: "Export Options"
                                        font.pixelSize: 18
                                        font.styleName: "Bold"
                                    }
                                    Rectangle{ 
                                        id: sectionSeparator5
                                        height: 2
                                        color: "#212121"
                                        Layout.fillWidth: true
                                        Layout.alignment: AlignVCenter
                                    }
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Export location:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    TextField {
                                        id: exportFolderField
                                        placeholderText: "Enter folder path"
                                        text: ""             // current value
                                        width: 300
                                        onEditingFinished: {
                                            console.log("User export folder:", text)
                                        }
                                        Layout.rightMargin: 50

                                        onTextChanged: settingsService.setExportLocation(text)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls where on your computer snippets are saved to"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Export format:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    ComboBox {
                                        id: exportFormat
                                        width: 100
                                        height: 25
                                        model: [".json", ".txt", ".csv"]
                                        currentIndex: 0
                                        contentItem: Text {
                                            text: exportFormat.displayText
                                            color: "#000000"
                                            font: exportFormat.font
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        Layout.rightMargin: 50

                                        onCurrentIndexChanged: settingsService.setExportFormat(currentText)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls the export format of snippets"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                
                            }
                            ColumnLayout {
                                id: importOptionsColumn
                                Layout.fillWidth: true
                                Layout.margins: 10
                                RowLayout {
                                    spacing: 8
                                    Label {
                                        color: "#000000"
                                        text: "Import Options"
                                        font.pixelSize: 18
                                        font.styleName: "Bold"
                                    }
                                    Rectangle{ 
                                        id: sectionSeparator6
                                        height: 2
                                        color: "#212121"
                                        Layout.fillWidth: true
                                        Layout.alignment: AlignVCenter
                                    }
                                }
                                
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Import location:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    TextField {
                                        id: importFolderField
                                        placeholderText: "Enter folder path"
                                        text: ""             // current value
                                        width: 300
                                        onEditingFinished: {
                                            console.log("User import folder:", text)
                                        }
                                        Layout.rightMargin: 50

                                        onTextChanged: settingsService.setImportLocation(text)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Controls where on your computer snippets are loaded from"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                                RowLayout {
                                    height: 34
                                    spacing: 8
                                    Layout.leftMargin: 10
                                    Layout.preferredHeight: 40
    
                                    Label {
                                        color: "#545454"
                                        text: "Conflict handling:"
                                    }
                                    Item {
                                        Layout.fillWidth: true
                                    }
                                    ComboBox {
                                        id: conflictControl
                                        width: 100
                                        height: 25
                                        model: ["Replace old snippet with incoming", "Keep both / Rename incoming", "Ignore incoming"]
                                        currentIndex: 1
                                        contentItem: Text {
                                            text: conflictControl.displayText
                                            color: "#000000"
                                            font: conflictControl.font
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        Layout.rightMargin: 50

                                        onCurrentIndexChanged: settingsService.setConflictHandling(currentText)
                                    }
                                }
                                Label {
                                    color: "#979797"
                                    text: "         Determines outcome of adding a snippet with an already used ID/Name"
                                    font.pixelSize: 10
                                    font.styleName: "Regular Italic"
                                }
                            }
    
    
                            
                        }
                    }
                
            }
            

        }
        
        
        
    }
    
}