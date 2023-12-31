import QtQuick 2.15

Row {
    id: theInputBar

    visible: !game.finished

    padding: 16
    spacing: 24
    property real buttonRadius: Math.floor(0.5 * (theInputBar.height - 2 * padding) / 2)

    Flow {
        id: theFlow
        spacing: 12
        padding: 0
        width: Math.ceil(0.5 * game.colorSet.length) * 2 * buttonRadius + spacing * (Math.ceil(0.5 * game.colorSet.length) - 1)

        Repeater {
            model: game.colorSet.length

            delegate: ColorDot {
                color: game.colorSet[index]
                radius: buttonRadius
                enabled: game.currentGuess && !game.currentGuess.complete
                opacity: enabled ? 1 : 0.3

                MouseArea {
                    anchors.fill: parent
                    enabled: parent.enabled

                    onClicked: {
                        gameWindow.inputColor(index);
                    }
                }
            }
        }

    }

    Column {
        spacing: theFlow.spacing
        padding: 0

        Image {
            id: submitButton
            source: enabled ? "qrc:/assets/QmlGames/Guess/checkmark_green_on.svg" : "qrc:/assets/QmlGames/Guess/checkmark_off.svg"
            height: buttonRadius*2
            width: height
            enabled: game.currentGuess && game.currentGuess.complete
            mipmap: true

            MouseArea {
                anchors.fill: parent
                enabled: submitButton.enabled

                onClicked: {
                    gameWindow.submitCurrentGuess();
                }
            }
        }


        Image {
            id: eraseButton
            source: enabled ? "qrc:/assets/QmlGames/Guess/cancel_orange_on.svg" : "qrc:/assets/QmlGames/Guess/cancel_off.svg"
            height: buttonRadius*2
            width: height
            enabled: game.currentGuess && !game.currentGuess.empty
            mipmap: true

            MouseArea {
                anchors.fill: parent
                enabled: eraseButton.enabled

                onClicked: {
                    gameWindow.eraseLastInput();
                }

                onPressAndHold: {
                    gameWindow.eraseCurrentLine();
                }
            }
        }
    }

}
