import QtQuick 2.15

import QmlGames.Basketball.Components 1.0

Item {
    id: mainWindow

    width: 1024
    height: 768

    Rectangle {
        anchors.fill: parent
        color: "grey"
    }

    property real aspectRatio: mainWindow.width / mainWindow.height
    property real maxAspectRatio: 1023/418
    property bool tooLarge: aspectRatio > maxAspectRatio
    property bool tooTall: aspectRatio < 8/5
    property real idealAspectRatio: 16/9

    BasketballGame {
        anchors.centerIn: parent
        width: !tooLarge ? parent.width : (mainWindow.height * maxAspectRatio)
        height: !tooTall ? parent.height : (width / idealAspectRatio)
        onQuitRequested: {
            Qt.quit();
        }
    }
}
