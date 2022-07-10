#ifndef MYLRC_H
#define MYLRC_H
#include <QObject>
#include <QtQml>
#include <string>
#include<vector>
#include<fstream>
#include<iostream>
#include<algorithm>
#include"common.h"
using std::ifstream;
using std::string;
using std::wstring;
using std::vector;



class MyLrc : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MyLrc(QObject *parent = nullptr);
    const QString &fileUrl() const;
    void setFileUrl(const QString &newFileUrl);

private:
    QString m_fileUrl;    //文件路径变量
    QString m_fileTi;		//歌词中的ti标签
    QString m_fileAr;
    QString m_fileAl;
    QString m_fileBy;

    QList<QString> m_str;   //歌词注册为qml类型
    //QList<int> m_time;     //歌词对应的时间

    Q_PROPERTY(QString fileUrl READ fileUrl WRITE setFileUrl NOTIFY fileUrlChanged)



    //
    vector<Lyric> m_lyrics;		//储存拆分的每一句歌词（包含时间标签和文本）
    vector<string> m_lyrics_str;	//储存未拆分时间标签的每一句歌词
    string m_ti;		//歌词中的ti标签
    string m_ar;
    string m_al;
    string m_by;

    int m_offset;    //这个变量目前还没有注册到qml中

    string m_url;//文件路径

    void DivideLyrics();    //将歌词文件拆分成若干句歌词，并保存在m_lyrics_str中
    void DivideLyrics(QString lyrics);

    void DisposeLyric();		//获得歌词中的时间标签和歌词文本


    //转换QString和string
    void change();
    //转换string和QString
    void changeTi();

    Q_PROPERTY(QString fileTi READ fileTi WRITE setFileTi NOTIFY fileTiChanged)

    Q_PROPERTY(QString fileAr READ fileAr WRITE setFileAr NOTIFY fileArChanged)


    Q_PROPERTY(QString fileAl READ fileAl WRITE setFileAl NOTIFY fileAlChanged)

    Q_PROPERTY(QString fileBy READ fileBy WRITE setFileBy NOTIFY fileByChanged)



    Q_PROPERTY(QList<QString> str READ str WRITE setStr NOTIFY strChanged)

public:

    Q_INVOKABLE void beginurl();

    Q_INVOKABLE void beginstr(QString lrc);
    Q_INVOKABLE int pisotionChange(int m,int s);

    Q_INVOKABLE void  bendi(QString  name);





    const QString &fileTi() const;
    void setFileTi(const QString &newFileTi);

    const QString &fileAr() const;
    void setFileAr(const QString &newFileAr);


    const QString &fileAl() const;
    void setFileAl(const QString &newFileAl);

    const QString &fileBy() const;
    void setFileBy(const QString &newFileBy);


    const QList<QString> &str() const;
    void setStr(const QList<QString> &newStr);

signals:

    void fileUrlChanged();
    void fileTiChanged();
    void fileArChanged();
    void fileAlChanged();
    void fileByChanged();
    void strChanged();
    void str2Changed();
};

#endif // MYLRC_H
