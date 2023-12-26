#ifndef GAMELIBRARY_H
#define GAMELIBRARY_H

#include <QObject>

#include <QList>
#include <QQmlListProperty>

class Game;

class GameLibrary : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QQmlListProperty<Game> games READ games NOTIFY gamesChanged)
public:
    explicit GameLibrary(QObject *parent = nullptr);

    QQmlListProperty<Game> games();
    QList<Game *> gameList() const;

    void load(const QString &folder);
    void load();

signals:
    void gamesChanged();

private:
    QList<Game *> m_games;
};

#endif // GAMELIBRARY_H
