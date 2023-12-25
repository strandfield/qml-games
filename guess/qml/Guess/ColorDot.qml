import QtQuick 2.15

Rectangle {
    property int colorIndex: -1

    color: colorIndex == -1 ? "grey" : game.colorSet[colorIndex]

    radius: 16

    width: radius*2
    height: radius*2
}
