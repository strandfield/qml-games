import QtQuick 2.15

Item {
    id: world

    property real worldHeight: 5
    property real worldWidth: 8
    property real ppm: height / worldHeight
    property real gravity: 9.81

    width: worldWidth * ppm

    /*
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "yellow"
        border.width: 1
    }
    */

    Goal {
        id: goal
        worldX: 0.5 * world.worldWidth
        worldY: world.worldHeight - worldHeight
    }

    /*
    Ball {
        //worldX: world.worldWidth / 2
        //worldY: world.worldHeight / 2
        worldX: worldMaxRadius
        worldY: worldMaxRadius
    }*/

    Component {
        id: ballComponent

        Ball {
            worldX: worldMaxRadius
            worldY: worldMaxRadius
        }
    }

    property var balls: []

    function createBall() {
        let ball = ballComponent.createObject(world);
        balls.push(ball);
        return ball;
    }

    function isBallOutOfWorld(b) {
        return b.worldY + b.worldRadius < -2; // two meters below the ground
    }

    function rectContainsPoint(rectangle, point) {
        return point.x >= rectangle.left && point.x <= rectangle.right
        && point.y >= rectangle.top && point.y <= rectangle.bottom;
    }

    function isBallInGoal(b) {
        let middlepos = b.currentPos.plus(b.previousPos).times(0.5)
        return rectContainsPoint(goal.worldGoalRect, b.currentPos)
        || rectContainsPoint(goal.worldGoalRect, b.previousPos)
        || rectContainsPoint(goal.worldGoalRect, middlepos);
    }

    function updateWorld(dt) {

        let any_ball_destroyed = false;

        for (let b of balls) {
            if (b.thrown) {
                b.updateMovement(dt);
                if (isBallOutOfWorld(b) || b.opacity == 0) {
                    b.expired = true;
                    b.destroy();
                    any_ball_destroyed = true;
                } else if (!b.scored && isBallInGoal(b)) {
                    b.setScored();
                    playerScore += 1;
                }
            }
        }

        if (any_ball_destroyed) {
            balls = balls.filter(b => !b.expired);
        }
    }

    function update(dt = 16) {
        updateWorld(dt);
    }

    /*
    Rectangle {
        color: "blue"
        opacity: 0.5
        height: goal.worldGoalRect.height * ppm
        width: goal.worldGoalRect.width * ppm
        x: goal.worldGoalRect.x * ppm
        y: world.height - goal.worldGoalRect.y * ppm - height
    }*/
}
