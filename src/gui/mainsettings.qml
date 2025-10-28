import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard

Window {
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
            id: rectangle
            width: 200
            height: 200
            color: "#18161c"
            Layout.fillHeight: true
            Layout.minimumWidth: 200
            Layout.preferredWidth: 350
            Layout.maximumWidth: 500

            Column {
                id: column
                y: 257
                height: 400
                anchors.left: parent.left
                anchors.right: parent.right

                Button {
                    id: generalButton
                    y: 4
                    height: 50
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
                    flat: false
                }

                Button {
                    id: generalButton1
                    y: 15
                    height: 50
                    text: "General"
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
                    flat: false
                    display: AbstractButton.TextOnly
                    checkable: false
                }
            }
        }
        StackView {
            id: stackView
            clip: false
            Layout.preferredWidth: 0
            Layout.fillHeight: true
            Layout.fillWidth: true

            ScrollView {
                id: scrollView
                anchors.fill: parent
            }
        }
    }
    /*
    SplitView { //side by side resizeable panels
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            color: "#0f0d13"
            z: -4
        }

        ListView{//left side - fixed panel for setting panels
            id: listView
            model: ["general", "appearance", "exportImport", "editor", "snippetManagement"]
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            Layout.minimumWidth: 250
            Layout.maximumWidth: 350


            Rectangle{
                                anchors.fill: parent
                id: background
                z: -1
                color: "#1d1b20"
            }

            delegate: ItemDelegate {
                text: modelData
                width: parent.width

                onClicked: {
                    var pageName = modelData;
                    var qmlSource = "qrc:/Settings/" + pageName + "Settings.qml";

                    settingsStack.clear();
                    settingsStack.push(qmlSource);
                }
            }

        }

        StackView{ //right side - changes based on setting tab clicked
            id: settingsStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: "qrc:/qml/Settings/generalSettings.qml"
            pushEnter: Transition{}
        }




    }
*/
}
