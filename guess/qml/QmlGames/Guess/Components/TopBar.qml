import QtQuick 2.15

Item {
    id: theTopBar
    height: Math.max(gameWindow.height * 0.05, 36)

    Image {
        source: "qrc:/assets/QmlGames/Guess/exit.svg"
        height: newGameText.height
        width: height
        rotation: 180
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        mipmap: true

        MouseArea {
            anchors.fill: parent
            onClicked: {
                gameWindow.quitRequested();
            }
        }
    }

    Text {
        id: newGameText
        text: "NEW GAME"
        color: "lightgrey"
        anchors.centerIn: parent
        font.pixelSize: Math.floor(0.6*theTopBar.height)
        visible: game.current_guess_index > 0

        MouseArea {
            anchors.fill: parent

            onClicked: {
                gameWindow.restartGame();
            }
        }
    }
}
