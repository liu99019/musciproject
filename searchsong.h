#ifndef SEARCHSONG_H
#define SEARCHSONG_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QMediaPlayer>
class SearchSong : public QObject
{
    Q_OBJECT
public:
    QMediaPlayer* player = new QMediaPlayer;

    explicit SearchSong(QObject *parent = nullptr);
    Q_INVOKABLE   void searchSong(QString str);
    void parseJson_getAlbumID(QString json);
    void parseJson_getPlayUrl(QString json);
    Q_INVOKABLE void getSongUrl(int index);
    void clear();
    Q_INVOKABLE void setlrc(QString lrc);

    const QList<QString> &albumName() const;
    void setAlbumName(const QList<QString> &newAlbumName);

    const QList<QString> &songName() const;
    void setSongName(const QList<QString> &newSongName);

    const QList<QString> &singerName() const;
    void setSingerName(const QList<QString> &newSingerName);

    const QList<double> &duration() const;
    void setDuration(const QList<double> &newDuration);

    const QString &url() const;
    void setUrl(const QString &newUrl);

    const QString &image() const;
    void setImage(const QString &newImage);

    const QString &lyrics() const;
    void setLyrics(const QString &newLyrics);

signals:


    void albumNameChanged();

    void songNameChanged();

    void singerNameChanged();

    void durationChanged();

    void textChanged();

    void urlChanged();

    void imageChanged();

    void lyricsChanged();
private:
    QNetworkAccessManager *network_manager;
    QNetworkRequest *network_request;

    QNetworkAccessManager *network_manager2;
    QNetworkRequest *network_request2;


    QList<QString> album_idStr;
    QList<QString> hashStr;
    QList<QString> m_albumName;
    QList<QString> m_songName;
    QList<QString> m_singerName;
    QList<double> m_duration;
    QString m_image;
    QString m_lyrics;
    QString m_url;
    Q_PROPERTY(QList<QString> albumName READ albumName WRITE setAlbumName NOTIFY albumNameChanged)

    Q_PROPERTY(QList<QString> songName READ songName WRITE setSongName NOTIFY songNameChanged)

    Q_PROPERTY(QList<QString> singerName READ singerName WRITE setSingerName NOTIFY singerNameChanged)

    Q_PROPERTY(QList<double> duration READ duration WRITE setDuration NOTIFY durationChanged)



    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)

    Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)

    Q_PROPERTY(QString lyrics READ lyrics WRITE setLyrics NOTIFY lyricsChanged)

private slots:
  void replyFinished(QNetworkReply *reply);
  void replyFinished2(QNetworkReply *reply);


};

#endif // SEARCHSONG_H
