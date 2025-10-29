import QtQuick

/*
How to access the scale factor in other files 

height: 550 * Scaling.factor
*/

QtObject {
    property real factor: 1.0
    property int baseWidth: 1440
    property int baseHeight: 900
}