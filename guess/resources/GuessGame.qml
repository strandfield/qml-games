import QtQuick 2.15
import QtQuick.Layouts 1.15

import QmlGames.Guess.Components 1.0

Item {
    id: gameWindow

    clip: true

    signal quitRequested

    property GuessGameObject game: GuessGameObject {
    }

    function restartGame() {
        game.restart();
    }

    function submitGuess(g) {
        if (!g.isComplete()) return;
        g.submitted = true;
    }

    function submitCurrentGuess() {
        if (game.finished) return;

        let g = game.currentGuess;
        submitGuess(g);

        if (game.isGuessCorrect(g)) {
            game.outcome = "win";
            return;
        }

        game.current_guess_index += 1;

        if (game.current_guess_index == game.guesses.length) {
            game.outcome = "lose";
        }
    }


    function inputColor(color_id) {
        if (game.finished) return;

        let g = game.currentGuess;
        let i = g.colors.indexOf(-1);

        if (i == -1) return;
        g.setColor(i, color_id);
    }

    function eraseLastInput() {
        if (game.finished) return;

        let g = game.currentGuess;
        let last_index = -1;

        for (let i = 0; i < g.colors.length; i++) {
            if(g.colors[i] != -1) {
                last_index = i;
            }
        }

        if (last_index != -1) {
            g.clearColor(last_index);
        }
    }

    ColumnLayout {

        height: parent.height
        width: parent.width
        spacing: 0

        TopBar {
            id: topBar
            //width: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: Math.max(gameWindow.height * 0.05, 36)
        }

        GuessGrid {
            id: guessGrid

            Layout.alignment: Qt.AlignHCenter

            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        BottomBar {
            id: bottomBar
            //width: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: Math.max(gameWindow.height * 0.2, 72)
        }
    }

}
