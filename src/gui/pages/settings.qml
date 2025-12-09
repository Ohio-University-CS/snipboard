import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic as Basic

Item {
    id: settingsRoot
    property Loader parentLoader
    width: 800
    height: 600

    MouseArea {
        anchors.fill: parent
        z: 50
        hoverEnabled: true
    }

    Rectangle {
        id: settingsBg
        anchors.fill: parent
        visible: true
        z: 51
        color: "#f4f4f4"

        Row {
            anchors.fill: parent

            Rectangle {
                id: settingsMenu
                width: 124
                height: parent.height
                color: "#cfcfcf"

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
                        if (settingsRoot.parentLoader) {
                            settingsRoot.parentLoader.visible = false;
                            settingsRoot.parentLoader.source = "";
                        }
                    }
                }

                ColumnLayout {
                    x: 10
                    y: 134
                    width: 104
                    height: 140
                    spacing: 8

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
                        height: 30

                        background: Rectangle {
                            radius: 8
                            color: toAppearance.down ? '#bfbfbf' : (toAppearance.hovered ? '#d0d0d0' : '#c0c0c0')
                        }
                        onClicked: scroll.contentY = 0
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
                        height: 40

                        background: Rectangle {
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
                        height: 40

                        background: Rectangle {
                            radius: 8
                            color: toSnippetOrganization.down ? '#bfbfbf' : (toSnippetOrganization.hovered ? '#d0d0d0' : '#c0c0c0')
                        }
                        onClicked: scroll.contentY = snippetOrganizationColumn.y - 10
                    }
                }

                Image {
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
                        anchors.fill: parent
                        color: "#ffffff"
                        radius: 8
                    }

                    ColumnLayout {
                        id: parentColumn
                        width: 610
                        spacing: 0

                        Item {
                            height: 15
                            Layout.fillWidth: true
                        }

                        // APPEARANCE SECTION
                        ColumnLayout {
                            id: appearanceColumn
                            Layout.margins: 10
                            Layout.fillWidth: true
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Label {
                                    text: "Appearance"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "#000000"
                                }

                                Rectangle {
                                    height: 2
                                    color: "#cccccc"
                                    Layout.fillWidth: true
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                color: "#f9f9f9"
                                radius: 6
                                border.color: "#e0e0e0"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 0

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2

                                        Label {
                                            text: "Theme"
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#333333"
                                        }

                                        Label {
                                            text: "Changes the theme of the whole application"
                                            font.pixelSize: 11
                                            color: "#666666"
                                        }
                                    }

                                    Item { 
                                        Layout.fillWidth: true 
                                    }

                                    ComboBox {
                                        id: themeControl
                                        Layout.preferredWidth: 120
                                        model: ["Light", "Dark"]

                                        Component.onCompleted: currentIndex = settingsService.theme()
                                        onActivated: index => settingsService.setTheme(index)

                                        contentItem: Text {
                                            text: themeControl.displayText
                                            font: themeControl.font
                                            verticalAlignment: Text.AlignVCenter
                                            leftPadding: 10
                                            color: "#000000"
                                        }
                                    }
                                }
                            }
                        }

                        // SNIPPET BEHAVIOR SECTION
                        ColumnLayout {
                            id: snippetBehaviorColumn
                            Layout.fillWidth: true
                            Layout.margins: 10
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Label {
                                    text: "Snippet Behavior"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "#000000"
                                }

                                Rectangle {
                                    height: 2
                                    color: "#cccccc"
                                    Layout.fillWidth: true
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                color: "#f9f9f9"
                                radius: 6
                                border.color: "#e0e0e0"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 0

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2

                                        Label {
                                            text: "Confirm Before Delete"
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#333333"
                                        }

                                        Label {
                                            text: "When enabled, deleting snippets requires confirmation"
                                            font.pixelSize: 11
                                            color: "#666666"
                                        }
                                    }

                                    Item { 
                                        Layout.fillWidth: true 
                                    }

                                    Switch {
                                        id: confirmDeleteSwitch
                                        Component.onCompleted: checked = settingsService.confirmBeforeDelete()
                                        onClicked: settingsService.setConfirmBeforeDelete(checked)
                                    }
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                color: "#f9f9f9"
                                radius: 6
                                border.color: "#e0e0e0"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 0

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2

                                        Label {
                                            text: "Default Language"
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#333333"
                                        }

                                        Label {
                                            text: "Default language when creating a new snippet"
                                            font.pixelSize: 11
                                            color: "#666666"
                                        }
                                    }

                                    Item { 
                                        Layout.fillWidth: true 
                                    }

                                    ComboBox {
                                        id: languageControl
                                        Layout.preferredWidth: 100
                                        model: ["txt", "qml", "py", "js", "cpp"]

                                        Component.onCompleted: {
                                            var idx = find(settingsService.defaultLanguage());
                                            if (idx !== -1)
                                                currentIndex = idx;
                                        }

                                        contentItem: Text {
                                            text: languageControl.displayText
                                            color: "#000000"
                                            font: languageControl.font
                                            verticalAlignment: Text.AlignVCenter
                                            leftPadding: 10
                                        }

                                        onActivated: settingsService.setDefaultLanguage(currentText)
                                    }
                                }
                            }
                        }

                        // SNIPPET ORGANIZATION SECTION
                        ColumnLayout {
                            id: snippetOrganizationColumn
                            Layout.fillWidth: true
                            Layout.margins: 10
                            spacing: 12

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Label {
                                    text: "Snippet Organization"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "#000000"
                                }

                                Rectangle {
                                    height: 2
                                    color: "#cccccc"
                                    Layout.fillWidth: true
                                }
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 60
                                color: "#f9f9f9"
                                radius: 6
                                border.color: "#e0e0e0"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 10

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2

                                        Label {
                                            text: "Default Sort Method"
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: "#333333"
                                        }

                                        Label {
                                            text: "Controls the default sorting of snippets"
                                            font.pixelSize: 11
                                            color: "#666666"
                                        }
                                    }

                                    Item { 
                                        Layout.fillWidth: true 
                                    }

                                    ComboBox {
                                        id: defaultSortControl
                                        Layout.preferredWidth: 180
                                        model: ["Last Edited (Newest)", "Last Edited (Oldest)", "Most Popular", "Least Popular", "Name (A-Z)", "Name (Z-A)"]

                                        Component.onCompleted: {
                                            var idx = find(settingsService.defaultSortMethod());
                                            if (idx !== -1)
                                                currentIndex = idx;
                                        }

                                        contentItem: Text {
                                            text: defaultSortControl.displayText
                                            color: "#000000"
                                            font: defaultSortControl.font
                                            verticalAlignment: Text.AlignVCenter
                                            leftPadding: 10
                                        }

                                        onActivated: settingsService.setDefaultSortMethod(currentText)
                                    }
                                }
                            }

                            Item {
                                Layout.fillHeight: true
                                Layout.preferredHeight: 20
                            }
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: settingsService
        function onSettingsChanged() {
            themeControl.currentIndex = settingsService.theme();
            confirmDeleteSwitch.checked = settingsService.confirmBeforeDelete();

            var langIdx = languageControl.find(settingsService.defaultLanguage());
            if (langIdx !== -1)
                languageControl.currentIndex = langIdx;

            var sortIdx = defaultSortControl.find(settingsService.defaultSortMethod());
            if (sortIdx !== -1)
                defaultSortControl.currentIndex = sortIdx;

            console.log("Settings UI updated from backend");
        }
    }
}
