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

        Rectangle {
            id: submitButton
            color: "white"
            radius: buttonRadius
            height: radius*2
            width: height
            enabled: game.currentGuess && game.currentGuess.complete
            opacity: enabled ? 1 : 0.3
            border.width: 2
            border.color: enabled ? "green" : "black"

            Image {
                source: "qrc:/assets/QmlGames/Guess/checkmark.svg"
                width: 0.6 * parent.width
                height: width
                anchors.centerIn: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent
                enabled: submitButton.enabled

                onClicked: {
                    gameWindow.submitCurrentGuess();
                }
            }
        }


        Rectangle {
            id: eraseButton
            color: "transparent"
            radius: buttonRadius
            height: radius*2
            width: height
            enabled: game.currentGuess && !game.currentGuess.empty
            opacity: enabled ? 1 : 0.3
            border.width: 2
            border.color: "orange"

            Rectangle {
                anchors.centerIn: parent
                rotation: 45
                color: "orange"
                width: 0.6 * parent.width
                height: 0.1 * parent.height
            }

            Rectangle {
                anchors.centerIn: parent
                rotation: 90 + 45
                color: "orange"
                width: 0.6 * parent.width
                height: 0.1 * parent.height
            }

            MouseArea {
                anchors.fill: parent
                enabled: eraseButton.enabled

                onClicked: {
                    gameWindow.eraseLastInput();
                }
            }
        }
    }

}
