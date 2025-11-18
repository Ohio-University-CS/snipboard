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
    }
}