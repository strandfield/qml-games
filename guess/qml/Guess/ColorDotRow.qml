import QtQuick 2.15

Row {
    property alias model: repeater.model

    property real colorDotRadius: 16
    spacing: 8

    Repeater {
        id: repeater

        delegate: ColorDot {
            radius: colorDotRadius
            colorIndex: modelData
        }
    }
}
