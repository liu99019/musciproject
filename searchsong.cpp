#include "searchsong.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include<QFile>


SearchSong::SearchSong(QObject *parent) : QObject(parent)
{
    network_manager = new QNetworkAccessManager();
    network_request = new QNetworkRequest();
    connect(network_manager,&QNetworkAccessManager::finished,this,&SearchSong::replyFinished,Qt::DirectConnection);

    //发送请求一得到AlbumID和FileHash
     network_manager2 = new QNetworkAccessManager();
     network_request2 = new QNetworkRequest();
     network_request2->setRawHeader("Cookie","kg_mid=233");
     network_request2->setHeader(QNetworkRequest::CookieHeader,2333);
     connect(network_manager2, &QNetworkAccessManager::finished, this, &SearchSong::replyFinished2);

     //QObject::connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
}

void SearchSong::replyFinished(QNetworkReply *reply)
{
    //qDebug()<<"老二1先出来";
    //获取响应的信息，状态码为200表示正常
    //QVariant status_code = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    this->clear();


    if(reply->error() == QNetworkReply::NoError)
    {
        QByteArray bytes = reply->readAll();  //获取字节
        QString result=bytes;                //转化为字符串
         parseJson_getAlbumID(result);
    }
    else
    {
        qDebug()<<"搜索信息处理错误";
    }
    emit songNameChanged();

}

void SearchSong::replyFinished2(QNetworkReply *reply){
    if(reply->error() == QNetworkReply::NoError)
    {
        QByteArray bytes = reply->readAll();  //获取字节
        QString result(bytes);  //转化为字符串
        parseJson_getPlayUrl(result);  //自定义方法，解析歌曲数据
    }
}

void SearchSong::searchSong(QString str){
    //qDebug()<<str;
    QString KGAPISTR1 = QString("http://songsearch.kugou.com/song_search_v2?keyword=%1&page=&pagesize=40"
          "&userid=-1&clientver=&platform=WebFilter&tag=em&filter=2&iscorrection=1&privilege_filter=0").arg(str);
     network_request->setUrl(QUrl(KGAPISTR1));
     network_manager->get(*network_request);
}

void SearchSong::parseJson_getAlbumID(QString json){
    QByteArray ba=json.toUtf8();
    const char *ch=ba.data();

    QByteArray byte_array;
    QJsonParseError json_error;

    QJsonDocument parse_doucment =QJsonDocument::fromJson(byte_array.append(ch), &json_error);

        if(parse_doucment.isObject())
        {
            QJsonObject rootObj = parse_doucment.object();
            if(rootObj.contains("data"))
            {
                QJsonValue valuedata = rootObj.value("data");
                if(valuedata.isObject())
                {
                    QJsonObject valuedataObject = valuedata.toObject();
                    if(valuedataObject.contains("lists"))
                    {
                        QJsonValue valueArray = valuedataObject.value("lists");
                        if (valueArray.isArray())
                        {
                            QJsonArray array = valueArray.toArray();
                            int size = array.size();
                            for(int i = 0;i < size;i++)
                            {
                                QJsonValue value = array.at(i);
                                if(value.isObject())
                                {
                                    QJsonObject object = value.toObject();
                                    if(object.contains("AlbumID"))
                                    {
                                        QJsonValue AlbumID_value = object.take("AlbumID");
                                        if(AlbumID_value.isString())
                                        {
                                            album_idStr.push_back(AlbumID_value.toString());             //歌曲ID信息
                                        }
                                    }
                                    if(object.contains("FileHash"))
                                    {
                                        QJsonValue FileHash_value = object.take("FileHash");
                                        if(FileHash_value.isString())
                                        {
                                            hashStr.push_back(FileHash_value.toString());                //hash
                                        }
                                    }

                                    if(object.contains("SongName"))
                                    {
                                        QJsonValue SongName_value = object.take("SongName");
                                        if(SongName_value.isString())
                                        {
                                            m_songName.push_back(SongName_value.toString());
                                        }
                                        //JI.m_songName=this->scm_songName;
                                    }
                                    if(object.contains("AlbumName"))
                                    {
                                        QJsonValue AlbumName_value = object.take("AlbumName");
                                        if(AlbumName_value.isString())
                                        {
                                            m_albumName.push_back(AlbumName_value.toString());
                                        }
                                    }
                                    if(object.contains("SingerName"))
                                    {
                                        QJsonValue SingerName_value = object.take("SingerName");
                                        if(SingerName_value.isString())
                                        {
                                            m_singerName.push_back(SingerName_value.toString());
                                        }
                                    }
                                    if(object.contains("Duration"))
                                    {
                                        QJsonValue Duration_value = object.take("Duration");
                                        if(Duration_value.isDouble())
                                        {
                                            m_duration.push_back(Duration_value.toDouble());
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

    else
    {
        qDebug() << json_error.errorString();
    }

}

void SearchSong::parseJson_getPlayUrl(QString json){
    QByteArray ba=json.toUtf8();
    const char *ch=ba.data();

    QByteArray byte_array;
    QJsonParseError json_error;
    QJsonDocument parse_doucment =QJsonDocument::fromJson(byte_array.append(ch),&json_error);
    if(json_error.error == QJsonParseError::NoError)
    {
        if(parse_doucment.isObject())
        {
            QJsonObject rootObj = parse_doucment.object();
            if(rootObj.contains("data"))
            {
                QJsonValue valuedata = rootObj.value("data");
                if(valuedata.isObject())
                {
                    QJsonObject valuedataObject = valuedata.toObject();

                    if(valuedataObject.contains("lyrics"))                           //lrc
                    {
                        QJsonValue play_lyric_value = valuedataObject.take("lyrics");
                        if(play_lyric_value.isString())
                        {
                            QString play_lrcStr = play_lyric_value.toString();
                            if(play_lrcStr!="")
                            {
                                m_lyrics=play_lrcStr;

                            }
                        }
                    }
                    if(valuedataObject.contains("play_url"))
                    {
                        QJsonValue play_url_value = valuedataObject.take("play_url");
                        if(play_url_value.isString())
                        {
                            QString play_urlStr = play_url_value.toString();                    //歌曲的url
                            if(play_urlStr!="")
                            {
                                m_url=play_urlStr;

                            }

                        }
                    }
                    if(valuedataObject.contains("img"))
                    {
                        QJsonValue play_img_value = valuedataObject.take("img");
                        if(play_img_value.isString())
                        {
                            QString play_img = play_img_value.toString();                    //歌曲的url
                            if(play_img!="")
                            {
                                m_image=play_img;
                            }
                        }
                    }
                }
            }
        }
            emit urlChanged();
    }

    else
    {
        qDebug() << json_error.errorString();
    }

    qDebug() <<m_url;
    setlrc(m_lyrics);
}

void SearchSong::getSongUrl(int index)
{
    //通过歌曲ID发送请求，得到歌曲url和歌词
    QString KGAPISTR1 = QString("http://wwwapi.kugou.com/yy/index.php?r=play/getdata&hash=%1&album_id=%2").arg(hashStr[index]).arg(album_idStr[index]);
    network_request2->setUrl(QUrl(KGAPISTR1));
    network_manager2->get(*network_request2);

}

void SearchSong::clear(){
    album_idStr.clear();
    hashStr.clear();
    m_albumName.clear();
    m_songName.clear();
    m_singerName.clear();
    m_duration.clear();
}

void SearchSong::setlrc(QString lrc){

     QFile file("/root/test.lrc");
     if(!file.open(QIODevice::WriteOnly))
         qDebug()<<file.errorString();
     QByteArray lrcc=lrc.toUtf8();
     file.write(lrcc);
     file.close();     
}

const QList<QString> &SearchSong::albumName() const
{
    return m_albumName;
}

void SearchSong::setAlbumName(const QList<QString> &newAlbumName)
{
    if (m_albumName == newAlbumName)
        return;
    m_albumName = newAlbumName;
    emit albumNameChanged();
}

const QList<QString> &SearchSong::songName() const
{
    return m_songName;
}

void SearchSong::setSongName(const QList<QString> &newSongName)
{
    if (m_songName == newSongName)
        return;
    m_songName = newSongName;
    emit songNameChanged();
}

const QList<QString> &SearchSong::singerName() const
{
    return m_singerName;
}

void SearchSong::setSingerName(const QList<QString> &newSingerName)
{
    if (m_singerName == newSingerName)
        return;
    m_singerName = newSingerName;
    emit singerNameChanged();
}

const QList<double> &SearchSong::duration() const
{
    return m_duration;
}

void SearchSong::setDuration(const QList<double> &newDuration)
{
    if (m_duration == newDuration)
        return;
    m_duration = newDuration;
    emit durationChanged();
}

const QString &SearchSong::url() const
{
    return m_url;
}

void SearchSong::setUrl(const QString &newUrl)
{
    if (m_url == newUrl)
        return;
    m_url = newUrl;
    emit urlChanged();
}

const QString &SearchSong::image() const
{
    return m_image;
}

void SearchSong::setImage(const QString &newImage)
{
    if (m_image == newImage)
        return;
    m_image = newImage;
    emit imageChanged();
}

const QString &SearchSong::lyrics() const
{
    return m_lyrics;
}

void SearchSong::setLyrics(const QString &newLyrics)
{
    if (m_lyrics == newLyrics)
        return;
    m_lyrics = newLyrics;
    emit lyricsChanged();
}


