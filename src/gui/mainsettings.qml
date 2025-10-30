import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard

Window {
    id: window
    width: 1440
    height: 900
    visible: true
    color: "#0f0d13"
    title: "Application Settings"

    minimumWidth: 800
    minimumHeight: 600

    RowLayout {
        id: rowLayout
        x: 0
        y: 0
        width: 1445
        height: 900
        uniformCellSizes: false
        spacing: 0


        Rectangle {
            id: settingsPanel
            width: 200
            height: 200
            color: "#18161c"
            smooth: true
            Layout.fillWidth: false
            Layout.fillHeight: true
            Layout.minimumWidth: 200
            Layout.preferredWidth: 330
            Layout.maximumWidth: 500

            Column {
                id: column
                y: 305
                height: 595
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 0
                anchors.rightMargin: 0

                Button {
                    id: generalButton
                    y: 4
                    height: 55
                    text: "General"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    font.hintingPreference: Font.PreferDefaultHinting
                    font.styleName: "Medium"
                    font.bold: false
                    font.family: "Montserrat"
                    focusPolicy: Qt.ClickFocus
                    display: AbstractButton.TextOnly
                    checkable: false
                    highlighted: false
                    flat: true

                    onClicked: {
                        stackView.replace("Settings/generalSettings.qml")
                        generalRect.color = "#453e51"
                    }

                    Rectangle {
                        id: generalRect
                        z: -1
                        color: "#2a2631"
                        anchors.fill: parent
                    }

                    Component.onCompleted: onClicked()
                }

                Button {
                    id: appearanceButton
                    y: 4
                    height: 55
                    text: "Appearance"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    highlighted: false
                    font.styleName: "Medium"
                    font.hintingPreference: Font.PreferDefaultHinting
                    font.family: "Montserrat"
                    font.bold: false
                    focusPolicy: Qt.ClickFocus
                    flat: true
                    display: AbstractButton.TextOnly

                    onClicked: {
                        stackView.replace("Settings/appearanceSettings.qml")
                        appearanceRect.color = "#453e51"
                    }

                    Rectangle {
                        id: appearanceRect
                        color: "#2a2631"
                        anchors.fill: parent
                        z: -1
                    }
                    checkable: false
                    background: "#211f24"
                }

                Button {
                    id: editorButton
                    y: 4
                    height: 55
                    text: "Editor"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    highlighted: false
                    font.styleName: "Medium"
                    font.hintingPreference: Font.PreferDefaultHinting
                    font.family: "Montserrat"
                    font.bold: false
                    focusPolicy: Qt.ClickFocus
                    flat: true
                    display: AbstractButton.TextOnly

                    onClicked: {
                        stackView.replace("Settings/editorSettings.qml")
                        editorRect.color = "#453e51"
                    }

                    Rectangle {
                        id: editorRect
                        color: "#2a2631"
                        anchors.fill: parent
                        z: -1
                    }
                    checkable: false
                    background: "#211f24"
                }

                Button {
                    id: exportImportButton
                    y: 4
                    height: 55
                    text: "Export / Import"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    highlighted: false
                    font.styleName: "Medium"
                    font.hintingPreference: Font.PreferDefaultHinting
                    font.family: "Montserrat"
                    font.bold: false
                    focusPolicy: Qt.ClickFocus
                    flat: true
                    display: AbstractButton.TextOnly

                    onClicked: {
                        stackView.replace("Settings/exportImportSettings.qml")
                        exportImportRect.color = "#453e51"
                    }

                    Rectangle {
                        id: exportImportRect
                        color: "#2a2631"
                        anchors.fill: parent
                        z: -1
                    }
                    checkable: false
                    background: "#211f24"
                }

                Button {
                    id: snippetManagementButton
                    y: 4
                    height: 55
                    text: "Snippet Management"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    highlighted: false
                    font.styleName: "Medium"
                    font.hintingPreference: Font.PreferDefaultHinting
                    font.family: "Montserrat"
                    font.bold: false
                    focusPolicy: Qt.ClickFocus
                    flat: true
                    display: AbstractButton.TextOnly

                    onClicked: {
                        stackView.replace("Settings/snippetManagementSettings.qml")
                        snippetManagementRect.color = "#453e51"
                    }

                    Rectangle {
                        id: snippetManagementRect
                        color: "#2a2631"
                        anchors.fill: parent
                        z: -1
                    }
                    checkable: false
                    background: "#211f24"
                }
            }

            Text {
                id: text1
                y: 20
                color: "#e6e0e9"
                text: qsTr("Settings")
                font.pixelSize: 28
                font.family: "Montserrat"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                id: homeButton
                x: 0
                y: 760
                height: 140
                text: "Home"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                highlighted: false
                font.styleName: "Medium"
                font.hintingPreference: Font.PreferDefaultHinting
                font.family: "Montserrat"
                font.bold: false
                focusPolicy: Qt.ClickFocus
                flat: true
                display: AbstractButton.TextOnly
                Rectangle {
                    id: generalRect1
                    color: "#2a2631"
                    anchors.fill: parent
                    z: -1
                }
                checkable: false
            }
        }
        StackView {
            id: stackView
            Layout.preferredHeight: 900
            clip: false
            Layout.preferredWidth: 1110
            Layout.fillHeight: true
            Layout.fillWidth: true

            initialItem: "Settings/generalSettings.qml"
        }
    }
}
