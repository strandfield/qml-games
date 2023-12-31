// Copyright (C) 2023 Vincent Chambrin
// This file is part of the 'qml-games' project
// For conditions of distribution and use, see copyright notice in LICENSE

#include "game.h"
#include "gamelibrary.h"

#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickView>

int main(int argc, char* argv[])
{
    QGuiApplication app{ argc, argv };

    QQuickView w;

    qmlRegisterType<GameLibrary>("QmlGames.Library", 1, 0, "GameLibrary");
    qmlRegisterType<Game>("QmlGames.Library", 1, 0, "Game");

    auto *library = new GameLibrary(&app);
    library->load();
    w.engine()->rootContext()->setContextProperty("gameLibrary", library);

    w.engine()->addImportPath("qrc:/qml");
    w.setSource(QUrl("qrc:/qml/CollectionMainWindow.qml"));
    w.setResizeMode(QQuickView::SizeRootObjectToView);
    w.show();

    QObject::connect(w.engine(), &QQmlEngine::quit, &app, &QGuiApplication::quit);

    return app.exec();
}
