import QtQuick 2.15

import Basketball.Game 1.0

Rectangle {
    color: "grey"

    property real value: 0
    property int padding: 8

    Rectangle {
        color: "black"

        x: padding
        y: padding
        width: parent.width - 2 * padding
        height: parent.height - 2 * padding

        Rectangle {
            color: "red"

            height: parent.height
            width: parent.width * Math.max(0, Math.min(value, 1))
        }
    }
}
