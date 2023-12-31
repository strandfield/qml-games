#ifndef GAME_H
#define GAME_H

#include <QObject>

#include <QUrl>

class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QUrl url READ url WRITE setUrl NOTIFY urlChanged)
public:
    explicit Game(QObject *parent = nullptr);

    const QString &name() const;
    void setName(const QString &name);

    const QUrl &url() const;
    void setUrl(const QUrl &url);

    static Game *fromManifest(const QString &manifestPath, QObject *parent = nullptr);

signals:
    void nameChanged();
    void urlChanged();

private:
    QString m_name;
    QUrl m_url;
};

#endif // GAME_H
