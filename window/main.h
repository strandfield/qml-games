// Copyright (C) 2023 Vincent Chambrin
// This file is part of the 'qml-games' project
// For conditions of distribution and use, see copyright notice in LICENSE

#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickView>

#define GAME_MAIN \
    int main(int argc, char *argv[]) \
    { \
        QGuiApplication app{argc, argv}; \
        Q_INIT_RESOURCE(window); \
        QQuickView w; \
        w.engine()->addImportPath("qrc:/qml"); \
        w.engine()->rootContext()->setContextProperty("gameUrl", GAME_URL); \
        w.setSource(QUrl("qrc:/qml/MainWindow.qml")); \
        w.setResizeMode(QQuickView::SizeRootObjectToView); \
        w.show(); \
        QObject::connect(w.engine(), &QQmlEngine::quit, &app, &QGuiApplication::quit); \
        return app.exec(); \
    }
