#include "gamelibrary.h"

#include "game.h"

#include <QDir>
#include <QDirIterator>
#include <QFileInfo>

GameLibrary::GameLibrary(QObject *parent)
    : QObject{parent}
{}

QQmlListProperty<Game> GameLibrary::games()
{
    return QQmlListProperty<Game>(this, &m_games);
}

QList<Game *> GameLibrary::gameList() const
{
    return m_games;
}

void GameLibrary::load(const QString &folder)
{
    QList<Game *> gamelist;

    QDirIterator iterator{folder, QDir::Filter::Dirs};

    while (iterator.hasNext()) {
        QString n = iterator.next();
        QString m = n + "/manifest.ini";
        if (QFileInfo::exists(m)) {
            if (auto *game = Game::fromManifest(m))
                gamelist.append(game);
        }
    }

    qDeleteAll(m_games);
    m_games = gamelist;
    emit gamesChanged();
}

void GameLibrary::load()
{
    load(":/manifest/QmlGames");
}
