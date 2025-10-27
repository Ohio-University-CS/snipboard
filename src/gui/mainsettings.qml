import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SnipBoard

Window {
    width: 1440 * Scaling.factor
    height: 900 * Scaling.factor
    visible: true
    title: "Application Settings"

    SplitView { //side by side resizeable panels
        anchors.fill: parent

        ListView{ //left side - fixed panel for setting panels
            model: ["general", "appearance", "exportImport", "editor", "snippetManagement"]
            width: 250
            Layout.minimumWidth: 200
            Layout.maximumWidth: 300

            delegate: ItemDelegate {
                text: modelData
                width: parent.width

                onClicked{
                    var pageName = modelData
                    var qmlSource = "qrc:/Settings/" + pageName + "Settings.qml"

                    settingsStack.clear()
                    settingsStack.push(qmlSource)
                }
            }

        }

        StackView{ //right side - changes based on setting tab clicked
            id: settingsStack
            Layout.fillWidth: true
            initialItem: "qrc:/qml/Settings/generalSettings.qml"
            pushTransition: Transition{}
        }




    }
}
