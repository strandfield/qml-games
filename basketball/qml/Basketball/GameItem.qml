import QtQuick 2.15

import Basketball.Game 1.0

Item {
    id: gameItem

    property int playerScore: 0

    property Ball currentBall: null
    property var currentBallStrength: currentBall ? currentBall.strength : null

    property bool isGameStarted: false
    property bool isGameRunning: updateTimer.running
    property int elapsedTime: 0
    property int gameDuration: 90 * 1000
    property int remainingTime: Math.max(gameDuration - elapsedTime, 0)
    property bool isGameFinished: remainingTime <= 0

    signal gameFinished

    function gameUpdate() {
        if (inputMouseArea.containsPress && currentBall && !currentBall.thrown) {
            currentBall.strength = Math.min(currentBall.strength + 0.015, 1);
        }

        world.update(updateTimer.interval);
        elapsedTime += updateTimer.interval;

        if (remainingTime <= 0) {
            gameFinished();
        }
    }

    Timer {
        id: updateTimer
        running: false
        interval: 16
        repeat: true

        onTriggered: {
            gameUpdate();
        }
    }

    function start() {
        isGameStarted = true;
        resume();
    }

    function pause() {
        updateTimer.stop();
    }

    function resume() {
        if (!updateTimer.running) {
            updateTimer.start();
        }
    }

    WorldItem {
        id: world
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height - (bottomBar.height - playerScoreText.height)
    }

    Item {
        id: inputSurface

        x: 0
        y: world.y
        width: parent.width
        height: world.height


        Rectangle {
            id: fingerPosRectangle

            width: Math.round((0.1 + (currentBallStrength ?? 0) * 0.1) * gameWindow.height)
            height: width
            color: "white"
            radius: width / 2

            visible: inputMouseArea.containsPress

            x: inputMouseArea.mouseX - width / 2
            y: inputMouseArea.mouseY - width / 2
        }

        MouseArea {
            id: inputMouseArea
            anchors.fill: parent
            enabled: isGameRunning
            acceptedButtons: Qt.LeftButton

            property point pressPosition

            onPressed: {
                if (!isGameFinished) {
                    pressPosition = Qt.point(mouse.x, mouse.y);
                    currentBall = world.createBall();
                    currentBall.strength = 0;
                }
            }

            onReleased: {
                let start = Qt.vector2d(pressPosition.x, -pressPosition.y);
                let end = Qt.vector2d(mouse.x, -mouse.y);
                let move = end.minus(start);

                if (move.length() > 16) {
                    move = move.normalized();
                } else {
                    move = currentBall.defaultDirection;
                }

                currentBall.throwBall(move);
            }
        }
    }

    Text {
        id: remainingTimeText
        anchors.top: parent.top
        anchors.topMargin: gameItem.height * 0.02
        text: (remainingTime / 1000).toFixed(0)
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: scoreFont.name
        font.pointSize: 24
        color: "orange"
        style: Text.Outline; styleColor: "black"
    }

    Column {
        id: bottomBar
        width: world.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        visible: !isGameFinished
        bottomPadding: gameItem.height * 0.02

        Text {
            id: playerScoreText
            text: playerScore
            anchors.right: parent.right
            font: remainingTimeText.font
            color: "orange"
            style: Text.Outline; styleColor: "black"
        }

        StrengthBar {
            width: parent.width
            height: gameItem.height * 0.1
            value: currentBall ? currentBall.strength : 0
        }
    }
    
}
