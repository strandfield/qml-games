import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: mainWindow

    width: 768
    height: 1024

    property real aspectRatio: mainWindow.width / mainWindow.height
    property bool debugItemsGeometry: false

    ColumnLayout {
        visible: gameLoader.item == null
        spacing: 32
        anchors.centerIn: parent

        Text {
            color: "black"
            text: "Game Collection"
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 24
        }

        Column {
            spacing: 8
            Layout.alignment: Qt.AlignHCenter

            Repeater {
                model: gameLibrary.games

                delegate: Text {
                    text: modelData.name
                    color: "black"
                    font.pointSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: gameLoader.source = modelData.url
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
            height: 64
            width: 64
        }

        Text {
            color: "black"
            text: "Exit"
            font.pointSize: 24
            Layout.alignment: Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                onClicked: Qt.quit()
            }
        }
    }

    Loader {
        id: gameLoader
        anchors.fill: parent
    }

    Connections {
        target: gameLoader.item

        function onQuitRequested() {
            gameLoader.source = "";
        }
    }
}
