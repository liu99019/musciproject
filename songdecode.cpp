#include "songdecode.h"
#include<taglib/tag.h>
#include <taglib/mpegfile.h>
#include <taglib/tfile.h>
#include <taglib/audioproperties.h>

Songdecode::Songdecode(QObject *parent)
    : QObject{parent}
{

}

void Songdecode::getTag(QString url)
{
        QString surl=url.mid(7,-1);
        qDebug()<<surl;
        QByteArray ba=surl.toUtf8();
        const char *ch=ba.data();

        TagLib::MPEG::File *mpegfile=new TagLib::MPEG::File(ch,true,TagLib::AudioProperties::Average);

        m_songTag.clear();
        if(mpegfile->isOpen()){
           m_songTag["标题"]=mpegfile->tag()->title().toCString();
           m_songTag["歌手"]=mpegfile->tag()->artist().toCString();
           m_songTag["唱片集"]=mpegfile->tag()->album().toCString();
           m_songTag["注释"]=mpegfile->tag()->comment().toCString();
           m_songTag["日期"]=mpegfile->tag()->year();
           m_songTag["音轨号"]=mpegfile->tag()->track();
           m_songTag["流派"]=mpegfile->tag()->genre().toCString();
       }

}






const QVariantMap &Songdecode::songTag() const
{
    return m_songTag;
}

void Songdecode::setSongTag(const QVariantMap &newSongTag)
{
    if (m_songTag == newSongTag)
        return;
    m_songTag = newSongTag;
    emit songTagChanged();
}
