import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard

 Rectangle{
     id: rectangle1
     //TEMPORARY RECTANGLE - for designer
     height: 900
     width: 1100
     visible: true
    //DELETE RECTANGLE WHEN COMPLETE
    Page {
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        Layout.preferredHeight: 900
        Layout.preferredWidth: 1110

        Rectangle {
            id: backgroundRect
            anchors.fill: parent
            color: "#0f0d13"
        }

        ScrollView {
            id: scrollView
            x: 65
            y: 295
            width: 968
            height: 605

            Rectangle {
                id: rectangle2
                color: "#2b292f"
                radius: 4
                anchors.fill: parent
                anchors.bottomMargin: -294

                Column {
                    id: individualSettings
                    anchors.fill: parent
                    padding: 4

                    Item {
                        id: setting1
                        height: 100
                        anchors.left: parent.left
                        anchors.right: parent.right

                        Text {
                            id: text2
                            x: 29
                            color: "#e6e0e9"
                            text: qsTr("Auto-Save")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 16
                            font.styleName: "SemiBold"
                            font.family: "Montserrat"
                            anchors.verticalCenterOffset: -13
                        }

                        Switch {
                            id: switch1
                            x: 169
                            scale: 0.8
                            width: 47
                            height: 32
                            anchors.verticalCenter: parent.verticalCenter
                            checked: true
                            anchors.verticalCenterOffset: -14
                        }

                        Rectangle {
                            id: line
                            height: 2
                            color: "#a7201c25"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            anchors.bottomMargin: 0
                        }

                        Text {
                            id: text4
                            x: 29
                            y: 58
                            color: "#d6e1d8e4"
                            text: qsTr("When toggled, snippets will automatically save as you type")
                            font.pixelSize: 12
                        }
                    }

                    Item {
                        id: setting2
                        height: 100
                        anchors.left: parent.left
                        anchors.right: parent.right
                        Text {
                            id: text3
                            x: 30
                            color: "#e6e0e9"
                            text: qsTr("Default Save Location")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 16
                            font.styleName: "SemiBold"
                            font.family: "Montserrat"
                            anchors.verticalCenterOffset: -13
                        }

                        Rectangle {
                            id: rectangle3
                            x: 269
                            width: 413
                            height: 20
                            color: "#0d0c10"
                            radius: 2
                            anchors.verticalCenter: parent.verticalCenter
                            layer.smooth: true
                            anchors.verticalCenterOffset: -13

                            TextField {
                                id: textField
                                x: 8
                                y: 3
                                anchors.verticalCenter: parent.verticalCenter
                                placeholderTextColor: "#95e1d8e4"
                                anchors.verticalCenterOffset: 1
                                placeholderText: qsTr("~/Documents/SnipBoard")
                            }
                        }

                        Rectangle {
                            id: line1
                            x: 0
                            height: 2
                            color: "#a2201c25"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            anchors.bottomMargin: 0
                        }

                        Text {
                            id: text5
                            x: 30
                            y: 59
                            color: "#d6e1d8e4"
                            text: qsTr("The location of your saved snippets on your machine")
                            font.pixelSize: 12
                        }

                    }

                    Item {
                        id: setting3
                        height: 100
                        anchors.left: parent.left
                        anchors.right: parent.right
                        Text {
                            id: text6
                            x: 30
                            color: "#e6e0e9"
                            text: qsTr("Confirm Before Exit")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 16
                            font.styleName: "SemiBold"
                            font.family: "Montserrat"
                            anchors.verticalCenterOffset: -13
                        }

                        Rectangle {
                            id: line2
                            x: 0
                            height: 2
                            color: "#a2201c25"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            anchors.bottomMargin: 0
                        }

                        Text {
                            id: text7
                            x: 30
                            y: 59
                            color: "#d6e1d8e4"
                            text: qsTr("When toggled, prompt will appear before closing unsaved snippets")
                            font.pixelSize: 12
                        }

                        Switch {
                            id: switch2
                            x: 243
                            y: 216
                            scale: 0.8
                            width: 47
                            height: 32
                            anchors.verticalCenter: parent.verticalCenter
                            checked: true
                            anchors.verticalCenterOffset: -13
                        }
                    }

                    Item {
                        id: setting4
                        y: 304
                        height: 100
                        anchors.left: parent.left
                        anchors.right: parent.right
                        Text {
                            id: text8
                            x: 29
                            color: "#e6e0e9"
                            text: qsTr("Launch Behavior")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 16
                            font.styleName: "SemiBold"
                            font.family: "Montserrat"
                            anchors.verticalCenterOffset: -13
                        }

                        Rectangle {
                            id: line3
                            height: 2
                            color: "#a7201c25"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            anchors.bottomMargin: 0
                        }

                        Text {
                            id: text9
                            x: 29
                            y: 58
                            color: "#d6e1d8e4"
                            text: qsTr("Determines if SnipBoard opens on startup as window, minimized, or not at all")
                            font.pixelSize: 12
                        }

                        ComboBox {
                            id: comboBox
                            x: 220
                            y: 30
                            width: 169
                            height: 15
                            model: ["Open window", "Open minimized", "Do not open"]
                        }
                    }
                }
            }
        }


        Rectangle {
            id: rectangle
            y: 44
            width: 1035
            height: 156
            color: "#2b292f"
            radius: 4
            anchors.right: parent.right
            anchors.rightMargin: 0
            bottomRightRadius: 0
            topRightRadius: 0

            Text {
                id: generalText
                x: 92
                color: "#e6e0e9"
                text: qsTr("General")
                anchors.verticalCenter: parent.verticalCenter
                font.letterSpacing: 10
                font.pixelSize: 32
                anchors.verticalCenterOffset: 1
                font.weight: Font.ExtraBold
                font.family: "Montserrat"

            }
        }
    }

    Rectangle {
        id: settingsPanel
        x: -200
        y: 0
        width: 200
        height: 900
        color: "#18161c"
        smooth: true
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
                onClicked: {
                    stackView.replace("Settings/generalSettings.qml")
                    generalRect.color("#2b292f")
                }
                highlighted: false
                font.styleName: "Medium"
                font.hintingPreference: Font.PreferDefaultHinting
                font.family: "Montserrat"
                font.bold: false
                focusPolicy: Qt.ClickFocus
                flat: true
                display: AbstractButton.TextOnly
                Rectangle {
                    id: generalRect
                    color: "#2a2631"
                    anchors.fill: parent
                    z: -1
                }
                checkable: false
                Component.onCompleted: { onClicked() }
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
                onClicked: {
                    stackView.replace("Settings/appearanceSettings.qml")
                    appearanceRect.color("#2b292f")
                }
                highlighted: false
                font.styleName: "Medium"
                font.hintingPreference: Font.PreferDefaultHinting
                font.family: "Montserrat"
                font.bold: false
                focusPolicy: Qt.ClickFocus
                flat: true
                display: AbstractButton.TextOnly
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
                onClicked: {
                    stackView.replace("Settings/editorSettings.qml")
                    editorRect.color("#2b292f")
                }
                highlighted: false
                font.styleName: "Medium"
                font.hintingPreference: Font.PreferDefaultHinting
                font.family: "Montserrat"
                font.bold: false
                focusPolicy: Qt.ClickFocus
                flat: true
                display: AbstractButton.TextOnly
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
                onClicked: {
                    stackView.replace("Settings/exportImportSettings.qml")
                    exportImportRect.color("#2b292f")
                }
                highlighted: false
                font.styleName: "Medium"
                font.hintingPreference: Font.PreferDefaultHinting
                font.family: "Montserrat"
                font.bold: false
                focusPolicy: Qt.ClickFocus
                flat: true
                display: AbstractButton.TextOnly
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
                onClicked: {
                    stackView.replace("Settings/snippetManagementSettings.qml")
                    snippetManagementRect.color("#2b292f")
                }
                highlighted: false
                font.styleName: "Medium"
                font.hintingPreference: Font.PreferDefaultHinting
                font.family: "Montserrat"
                font.bold: false
                focusPolicy: Qt.ClickFocus
                flat: true
                display: AbstractButton.TextOnly
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
        Layout.preferredWidth: 330
        Layout.minimumWidth: 200
        Layout.maximumWidth: 500
        Layout.fillWidth: false
        Layout.fillHeight: true
    }

}
