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
                color: "#ffffff"
                visible: true

                Label {
                    x: 21
                    y: 29
                    text: "Settings"
                    font.pixelSize: 24
                    font.bold: true
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

                    ColumnLayout {
                        id: parentColumn
                        Layout.margins: 10
                        Layout.fillWidth: true

                        ColumnLayout {
                            id: appearanceColumn
                            Layout.margins: 10
                            Layout.fillWidth: true
                            Label {
                                text: "Appearance"
                                font.pixelSize: 18
                                font.styleName: "Bold"
                            }

                            RowLayout {
                                spacing: 8
                                Layout.leftMargin: 10
                                Layout.preferredHeight: 40

                                Label {
                                    text: "Theme:"
                                }
                                ComboBox {
                                    width: 100
                                    height: 25
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    model: ["Light", "Dark"]
                                    currentIndex: 0
                                }
                            }
                            RowLayout {
                                spacing: 8
                                Layout.leftMargin: 10
                                Layout.preferredHeight: 40

                                Label {
                                    text: "Font size:"
                                }

                                Slider {
                                    id: fontSlider
                                    from: 0
                                    to: 100
                                    value: 50
                                    stepSize: 1
                                    width: 200
                                    height: 30

                                    onValueChanged: console.log("Opacity:", value)
                                }

                                Label {
                                    text: "                               " + Math.round(fontSlider.value) + "%"

                                }
                            }
                            RowLayout {
                                spacing: 8
                                Layout.leftMargin: 10
                                Layout.preferredHeight: 40

                                Label {
                                    text: "Line numbers:"
                                }

                                Switch {
                                    id: lineNumbersSwitch
                                    checked: true

                                    onCheckedChanged: {
                                        console.log("Line numbers toggled:", checked)

                                    }
                                }
                            }
                            RowLayout {
                                spacing: 8
                                Layout.leftMargin: 10
                                Layout.preferredHeight: 40

                                Label {
                                    text: "Syntax highlighting:"
                                }

                                Switch {
                                    id: syntaxHighlightingSwitch
                                    checked: true

                                    onCheckedChanged: {
                                        console.log("Syntax highlighting:", checked)

                                    }
                                }
                            }
                        }
                        ColumnLayout {
                            id: editorColumn
                            Layout.fillWidth: true
                            Layout.margins: 10
                            Label {
                                text: "Editor"
                                font.pixelSize: 18
                                font.styleName: "Bold"
                            }

                            RowLayout {
                                spacing: 8
                                Layout.leftMargin: 10
                                Layout.preferredHeight: 40

                                Label {
                                    text: "Theme:"
                                }
                                ComboBox {
                                    width: 100
                                    height: 25
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    model: ["Light", "Dark"]
                                    currentIndex: 0
                                }
                            }
                        }


                        Item {
                            id: exportImportSettings

                            Column {
                                id: exportImportColumn
                            }
                        }
                        Item {
                            id: snippetManagerSettings

                            Column {
                                id: snippetManagerColumn
                            }
                        }
                    }
                }
            }
            

        }
        
        
        
    }
    
}
