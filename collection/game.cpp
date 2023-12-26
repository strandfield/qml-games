#include "game.h"

#include <QSettings>

Game::Game(QObject *parent)
    : QObject{parent}
{}

const QString &Game::name() const
{
    return m_name;
}

void Game::setName(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

const QUrl &Game::url() const
{
    return m_url;
}

void Game::setUrl(const QUrl &url)
{
    if (m_url != url) {
        m_url = url;
        emit urlChanged();
    }
}

Game *Game::fromManifest(const QString &manifestPath, QObject *parent)
{
    QSettings manifest{manifestPath, QSettings::IniFormat};

    QString name = manifest.value("name").toString();
    QString url = manifest.value("gameUrl").toString();

    if (name.isEmpty() || url.isEmpty()) {
        return nullptr;
    }

    auto *g = new Game(parent);
    g->setName(name);
    g->setUrl(QUrl(url));
    return g;
}
