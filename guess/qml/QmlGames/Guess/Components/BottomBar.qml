import QtQuick 2.15

Item {
    id: theBottomBar
    width: 768
    height: Math.max(gameWindow.height * 0.15, 72)

    Rectangle {
        anchors.fill: parent
        color: "lightgray"
        visible: debugItemsGeometry
    }

    InputBar {
        id: theInputBar
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        visible: game.finished
        text: game.outcome == "win" ? "WIN!" : "LOSE!"
        anchors.fill: parent
        font.pixelSize: 72
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
