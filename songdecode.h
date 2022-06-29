/*
 * 音频解析的c++实现文件
 * （利用第三方库解析歌曲的标题，封面等等信息）
*/

#ifndef SONGDECODE_H
#define SONGDECODE_H

#include <QObject>
#include <QVariantMap>
class Songdecode : public QObject
{
    Q_OBJECT
public:
    explicit Songdecode(QObject *parent = nullptr);
    Q_INVOKABLE void getTag(QString url);


    QVariantMap m_songTag;
    const QVariantMap &songTag() const;
    void setSongTag(const QVariantMap &newSongTag);

signals:

    void songTagChanged();
private:
    Q_PROPERTY(QVariantMap songTag READ songTag WRITE setSongTag NOTIFY songTagChanged)
};

#endif // SONGDECODE_H
