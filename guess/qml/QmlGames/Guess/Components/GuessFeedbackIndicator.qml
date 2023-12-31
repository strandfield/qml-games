import QtQuick 2.15

Item {
    id: theFeedbackIndicator

    property ColorGuessObject guess
    property var correctAnswer: game.colorCode
    property real padding: 3
    property real spacing: 6
    property real pegSize: (theFeedbackIndicator.height - 2 * padding - spacing) / 2

    property bool gComplete: guess.complete
    property bool gSubmitted: guess.submitted

    onGCompleteChanged: update()
    onGSubmittedChanged: update()

    property string svgResInactive: "qrc:/assets/QmlGames/Guess/greydot.svg"
    property string svgResPending: "qrc:/assets/QmlGames/Guess/bluedot.svg"
    property string svgResCorrect: "qrc:/assets/QmlGames/Guess/checkmark_green_on.svg"
    property string svgResMisplaced: "qrc:/assets/QmlGames/Guess/checkmark_yellow.svg"
    property string svgResMmmh: ""

    function update() {
        let dots = [guess1, guess2, guess3, guess4];

        if (!guess.submitted) {
            let src = guess.isComplete() ? svgResPending : svgResInactive;
            for (let i = 0; i < dots.length; i++) {
                dots[i].source = src;
            }
            return;
        }

        let result = game.verifyGuess(guess.colors, correctAnswer);

        for (let i = 0; i < dots.length; i++) {
            if (result[0] > 0) {
                result[0] -= 1;
                dots[i].source = svgResCorrect;
            } else if(result[1] > 0) {
                result[1] -= 1;
                dots[i].source = svgResMisplaced;
            } else {
                dots[i].source = svgResMmmh;
            }
        }
    }

    width: height

    Image {
        id: guess1
        source: svgResInactive
        width: pegSize
        height: width
        mipmap: true
        anchors.margins: theFeedbackIndicator.padding
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Image {
        id: guess2
        source: svgResInactive
        width: pegSize
        height: width
        mipmap: true
        anchors.margins: theFeedbackIndicator.padding
        anchors.top: parent.top
        anchors.right: parent.right
    }

    Image {
        id: guess3
        source: svgResInactive
        width: pegSize
        height: width
        mipmap: true
        anchors.margins: theFeedbackIndicator.padding
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    Image {
        id: guess4
        source: svgResInactive
        width: pegSize
        height: width
        mipmap: true
        anchors.margins: theFeedbackIndicator.padding
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }
}
