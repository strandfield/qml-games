import QtQuick 2.15

Row {
    property ColorGuessObject guess

    property alias colorDotRadius: dotRow.colorDotRadius
    spacing: 8
    padding: 0

    ColorDotRow {
        id: dotRow
        model: guess.colors
    }

    GuessFeedbackIndicator {
        id: feedbackIndicator
        guess: parent.guess
        height: dotRow.height
        anchors.verticalCenter: parent.verticalCenter
    }
}
