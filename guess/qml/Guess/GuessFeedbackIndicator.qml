import QtQuick 2.15

Item {
    id: theFeedbackIndicator

    property ColorGuessObject guess
    property var correctAnswer: game.colorCode
    property real padding: 3
    property real spacing: 6
    property real colorDotRadius: (theFeedbackIndicator.height - 2 * padding - spacing) / 4

    property bool gComplete: guess.complete
    property bool gSubmitted: guess.submitted

    onGCompleteChanged: update()
    onGSubmittedChanged: update()

    function update() {
        let dots = [guess1, guess2, guess3, guess4];

        if (!guess.submitted) {
            let color = guess.isComplete() ? "royalblue" : "gray";
            for (let i = 0; i < dots.length; i++) {
                dots[i].color = color;
            }
            return;
        }

        let result = game.verifyGuess(guess.colors, correctAnswer);

        for (let i = 0; i < dots.length; i++) {
            if (result[0] > 0) {
                result[0] -= 1;
                dots[i].color = "limegreen";
            } else if(result[1] > 0) {
                result[1] -= 1;
                dots[i].color = "yellow";
            } else {
                dots[i].color = "grey";
            }
        }
    }

    // width: 4*colorDotRadius + spacing
    // height: width
    width: height

    ColorDot {
        id: guess1
        color: "grey"
        radius: colorDotRadius
        anchors.margins: theFeedbackIndicator.padding
        anchors.left: parent.left
        anchors.top: parent.top
    }

    ColorDot {
        id: guess2
        color: "grey"
        radius: colorDotRadius
        anchors.margins: theFeedbackIndicator.padding
        anchors.top: parent.top
        anchors.right: parent.right
    }

    ColorDot {
        id: guess3
        color: "grey"
        radius: colorDotRadius
        anchors.margins: theFeedbackIndicator.padding
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    ColorDot {
        id: guess4
        color: "grey"
        radius: colorDotRadius
        anchors.margins: theFeedbackIndicator.padding
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }
}
