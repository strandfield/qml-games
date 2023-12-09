import QtQuick 2.15

Image {
    mipmap: true

    property real worldX
    property real worldY
    property real worldMinRadius: 0.05
    property real worldMaxRadius: 0.5
    property real worldMaxSize: 2 * worldMaxRadius
    property real strength: -1
    property bool thrown: false
    property real timeSinceThrown: 0
    property real defaultDirectionAngle: 75
    property vector2d defaultDirection: Qt.vector2d(
                                            Math.cos(defaultDirectionAngle * Math.PI / 180),
                                            Math.sin(defaultDirectionAngle * Math.PI / 180)
                                            )
    property vector2d initDirection: Qt.vector2d(1, 0)
    property vector2d initSpeed: initDirection.times(3 * (1 + 3 * strength))
    property vector2d initPos: Qt.vector2d(0, 0)
    property vector2d currentPos: Qt.vector2d(worldX, worldY)
    property vector2d previousPos: Qt.vector2d(0, 0)
    property bool expired: false
    property bool scored: false
    property real worldRadius: worldMinRadius + strength * (worldMaxRadius - worldMinRadius)
    visible: strength >= 0

    width: 2 * worldRadius * world.ppm
    height: width
    source: "qrc:/assets/ball.svg"
    x: worldX * world.ppm - 0.5 * width
    y: world.height - worldY * world.ppm - 0.5 * height

    /*
    NumberAnimation on worldRadius {
        from: 0.1
        to: 1
        duration: 2000
        loops: -1
    }*/

    NumberAnimation on opacity {
        id: fadeOutAnimation
        from: 1
        to: 0
        duration: 250
        running: false
        loops: 1
    }

    function setScored() {
        scored = true;
        fadeOutAnimation.start();
    }

    function throwBall(direction) {
        initPos = Qt.vector2d(worldX, worldY);
        initDirection = direction;
        thrown = true;
    }

    function updateMovement(delta_t) {
        previousPos = currentPos;
        timeSinceThrown += delta_t / 1000;
        let speedfactor = 0.2;
        //worldX += speedfactor * initDirection.x * strength;
        //worldY += speedfactor * initDirection.y * strength;
        let t = timeSinceThrown;
        let v = initSpeed;
        speedfactor = 3;
        worldX = v.x * t + initPos.x;
        worldY = -0.5 * world.gravity * Math.pow(t, 2) + v.y * t + initPos.y;
    }
}
