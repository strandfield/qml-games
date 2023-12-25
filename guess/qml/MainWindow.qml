import QtQuick 2.15

Item {
    id: mainWindow

    width: 768
    height: 1024

    property real aspectRatio: mainWindow.width / mainWindow.height
    property bool debugItemsGeometry: false

    GuessGame {
        anchors.fill: parent
        onQuitRequested: {
            Qt.quit();
        }
    }
}
