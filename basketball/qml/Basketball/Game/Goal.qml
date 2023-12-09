import QtQuick 2.15

Item {
    id: goal

    property real worldX
    property real worldY

    property real worldWidth: 2.5
    property real worldHeight: worldWidth * goalImage.aspectRatio

    property rect worldGoalRect: Qt.rect(
                                     worldX - 0.5 * worldWidth * goalImage.goalRelRect.width,
                                     worldY - 0.5 * worldHeight * goalImage.goalRelRect.height,
                                     goalImage.goalRelRect.width * worldWidth,
                                     goalImage.goalRelRect.height * worldHeight
                                     )

    x: worldX * world.ppm
    y: world.height - worldY * world.ppm

    Image {
        id: goalImage
        mipmap: true
        source: "qrc:/assets/goal.svg"

        //anchors.centerIn: parent

        property real aspectRatio: sourceSize.height > 0 ? (sourceSize.width / sourceSize.height) : 1

        x: -worldWidth * (goalRelRect.x + 0.5 * goalRelRect.width) * world.ppm
        y: -worldHeight * ((1-goalRelRect.y-goalRelRect.height) + 0.5 * goalRelRect.height) * world.ppm
        width: Math.round(worldWidth * world.ppm)
        height: Math.round(width * aspectRatio)

        property rect goalRelRect: Qt.rect(0.3169, 0.44, 0.4072, 0.0328)

    }

    /*
    Rectangle {
        color: "red"
        width: 8
        height: 8
        anchors.centerIn: parent
    }
    */

    property int pScore: playerScore
    onPScoreChanged: {
        if (pScore == 3) {
            anim1.start();
        } else if (pScore == 7) {
            anim1.stop();
            anim2.start();
        }
    }

    SequentialAnimation {
        id: anim1
        running: false
        loops: -1
        NumberAnimation { target: goal; property: "worldY"; to: 4; duration: 4000 }
        NumberAnimation { target: goal; property: "worldY"; to: 1; duration: 4000 }
    }

    ParallelAnimation {
        id: anim2
        running: false
        loops: -1

        SequentialAnimation {
            NumberAnimation { target: goal; property: "worldX"; to: 0.5 * world.worldWidth; duration: 2000 }
            NumberAnimation { target: goal; property: "worldX"; to: world.worldWidth - 0.6* worldWidth; duration: 2000 }
            NumberAnimation { target: goal; property: "worldX"; to: 0.5 * world.worldWidth; duration: 2000 }
            NumberAnimation { target: goal; property: "worldX"; to: 0.6* worldWidth; duration: 2000 }
        }

        SequentialAnimation {
            NumberAnimation { target: goal; property: "worldY"; to: 4; duration: 2000 }
            NumberAnimation { target: goal; property: "worldY"; to: 1; duration: 4000 }
            NumberAnimation { target: goal; property: "worldY"; to: 0.5 * (4+1); duration: 2000 }

        }
    }
}
