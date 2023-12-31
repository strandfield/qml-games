import QtQuick 2.15

import QmlGames.Basketball.Components 1.0

Item {
    id: gameWindow

    clip: true


    FontLoader { id: scoreFont; source: "qrc:/assets/QmlGames/Basketball/Ruslandisplay-OwBO.ttf" }

    signal quitRequested

    Image {
        z: -2
        source: "qrc:/assets/QmlGames/Basketball/bg_0.jpg"
        mipmap: true
        height: parent.height
        width: sourceSize.width * height / sourceSize.height
        anchors.centerIn: parent
    }

    property GameItem game: null

    Component {
        id: gameComponent

        GameItem {
            z: -1
            anchors.fill: parent
        }
    }

    Text {
        id: gameRestart
        text: restartCounter
        font.family: scoreFont.name
        font.pixelSize: parent.height * 0.25
        color: "orange"
        style: Text.Outline; styleColor: "black"

        anchors.centerIn: parent

        property int restartCounter: 3
        visible: gameRestartTimer.running


        Timer {
            id: gameRestartTimer
            running: false
            interval: 1000
            repeat: true

            onTriggered: {
                gameRestart.restartCounter -= 1;

                if (gameRestart.restartCounter == 0) {
                    gameRestartTimer.stop();
                    game.start();
                }
            }
        }
    }

    function startNewGame() {
        if (game) game.destroy();
        game = gameComponent.createObject(gameWindow);
        gameRestart.restartCounter = 3;
        gameRestartTimer.start();
    }

    Column {
        anchors.centerIn: parent

        Text {
            text: game ? game.playerScore : ""
            font.family: scoreFont.name
            font.pixelSize: gameWindow.height * 0.25
            color: "orange"
            style: Text.Outline; styleColor: "black"
            visible: game && game.isGameFinished
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            visible: !game || (!game.isGameRunning && !gameRestartTimer.running) || game.isGameFinished

            color: "transparent"
            border.width: 1
            border.color: "orange"

            width: content.width
            height: content.height

            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                anchors.fill: parent
                opacity: 0.3
                color: "black"
            }

            Column {
                id: content
                padding: 16
                spacing: 8

                Text {
                    text: "Play"
                    font.family: scoreFont.name
                    font.pixelSize: gameWindow.height * 0.1
                    color: "orange"
                    style: Text.Outline; styleColor: "black"

                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            startNewGame();
                        }
                    }
                }

                Text {
                    text: "Exit"
                    font.family: scoreFont.name
                    font.pixelSize: gameWindow.height * 0.1
                    color: "orange"
                    style: Text.Outline; styleColor: "black"

                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            quitRequested();
                        }
                    }
                }
            }
        }
    }
}
