import QtQuick
import Qt.labs.settings 1.1

QtObject {
    // persisted theme name
    property string mode: settings.mode

    Settings {
        id: settings
        category: "appearance"
        property string mode: "light"   // "light" | "dark"
    }

    // Example: surface/background tokens
    readonly property color surface:
        mode === "dark" ? "#141218" : '#e1e1e1'
    readonly property color surfaceContainer:
        mode === "dark" ? "#1d1b20" : '#434343'
    readonly property color surfaceContainerHigh:
        mode === "dark" ? "#2b292f" : '#535353'
    readonly property color surfaceText:
        mode === "dark" ? "#e6e0e9" : "#000000"
    readonly property color surfaceTextVariant:
        mode === "dark" ? "#cac4cf" : "#545454"
    readonly property color outline:
        mode === "dark" ? "#49454e" : "#212121"
    readonly property color outlineVariant:
        mode === "dark" ? "#948f99" : "#cccccc"

    // keep your existing brand colors too
    property color primary: "#cfbdfe"
    property color primaryText:
        mode === "dark" ? "#cfbdfe" : "#36265d"
}
