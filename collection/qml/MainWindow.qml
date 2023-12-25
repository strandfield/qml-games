import QtQuick 2.15

Item {
    id: mainWindow

    width: 768
    height: 1024

    property real aspectRatio: mainWindow.width / mainWindow.height
    property bool debugItemsGeometry: false

    Rectangle {
        color: "goldenrod"
        anchors.fill: parent
    }

    Image {
        source: "qrc:/assets/QmlGames/Basketball/goal.svg"
        anchors.centerIn: parent
    }
}
