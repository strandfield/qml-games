import QtQml 2.15

QtObject {
    id: theGameObject

    property var colorSet: ["red", "yellow", "green", "blue", "orange", "purple"]
    property var colorCode: generateRandomColorCode()
    property string outcome: ""
    property bool finished: outcome == "win" || outcome == "lose"
    property bool cheat: false

    property var guesses: initGuesses(10)
    property int current_guess_index: 0
    property ColorGuessObject currentGuess: current_guess_index < guesses.length ? guesses[current_guess_index] : null

    property Component guessComponent: Component {

        ColorGuessObject {

        }
    }

    function createGuess() {
        return guessComponent.createObject();
    }

    function initGuesses(n) {
        let guesses = [];

        for(let i = 0; i < n; i++) {
            guesses.push(createGuess());
        }

        return guesses;
    }

    function generateRandomColorCode() {
        let code = [];

        for (let i = 0; i < 4; i++) {
            let c = Math.floor(Math.random() * colorSet.length);
            code.push(c);
        }

        return code;
    }

    function restart() {
        outcome = "";
        current_guess_index = 0;
        colorCode = generateRandomColorCode();
        guesses = initGuesses(10);
    }

    function verifyGuess(guessColors, code = colorCode) {
        let correct = 0;
        let misplaced = 0;

        let counters = colorSet.map(e => 0);
        code.forEach(c => counters[c] += 1);

        // iterates a first time to count the correct colors
        for (let i = 0; i < guessColors.length; i++) {
            let c = guessColors[i];

            if (c == code[i]) {
                correct += 1;
                counters[c] -= 1;
            }
        }

        // iterates a second time to count the misplaced colors
        for (let i = 0; i < guessColors.length; i++) {
            let c = guessColors[i];

            if (c != code[i] && counters[c] > 0) {
                misplaced += 1;
                counters[c] -= 1;
            }
        }

        return [correct, misplaced];
    }

    function isGuessCorrect(g) {
        return verifyGuess(g.colors)[0] == colorCode.length;
    }
}
