import QtQuick 2.15

Item {
    id: mainWindow

    width: 768
    height: 1024

    property real aspectRatio: mainWindow.width / mainWindow.height
    property bool debugItemsGeometry: false

    Component.onCompleted: {
        console.log("creating game " + gameUrl);
        let component = Qt.createComponent(gameUrl);
        if (component.status == Component.Ready) {
            var game_container = component.createObject(mainWindow);

            if(game_container.quitRequested) {
                console.log("connecting quitRequested() signal to Qt.quit()");
                game_container.quitRequested.connect(Qt.quit);
            }
        }
    }
}
