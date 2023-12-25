import QtQuick 2.15
import QtQuick.Layouts 1.15

import Guess 1.0

Item {
    id: guessGrid

    property int nbGuessP1: game.guesses.length + 1
    property real availableVSpace: guessGrid.height - 2 * theContentColumn.padding - game.guesses.length * theContentColumn.spacing
    property real dotRadius: Math.floor(0.5 * availableVSpace / nbGuessP1)

    Rectangle {
        anchors.fill: parent
        color: "lightblue"
        visible: debugItemsGeometry
    }

    Column  {
        id: theContentColumn
        anchors.centerIn: parent
        spacing: 8
        padding: 16

        Repeater {
            model: game.guesses

            delegate: ColorGuessRow {
                guess: modelData
                colorDotRadius: dotRadius
            }
        }

        Item {
            width:revealRow.width
            height: revealRow.height

            ColorDotRow {
                id: revealRow
                model: game.colorCode
                colorDotRadius: dotRadius
            }

            Rectangle {
                anchors.fill: parent
                z: 1
                color: "grey"
                visible: !game.finished && !game.cheat
            }
        }
    }
}

