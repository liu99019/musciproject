#include "songdecode.h"
#include <fstream>
#include <iostream>

#include <taglib/mpegfile.h>
#include <taglib/tfile.h>
#include <taglib/audioproperties.h>
#include <taglib/attachedpictureframe.h>
#include <taglib/id3v2frame.h>
#include <taglib/id3v2header.h>
#include <taglib/id3v2tag.h>
#include <taglib/flacpicture.h>

#include <taglib/xiphcomment.h>
#include<taglib/tag.h>

Songdecode::Songdecode(QObject *parent)
    : QObject{parent}
{
}

void Songdecode::getTag(QString url)
{
        QString surl=url.mid(7,-1);
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
        //qDebug()<<m_songTag;
        TagLib::ID3v2::Tag *id3v2Tag=mpegfile->ID3v2Tag();
        if(id3v2Tag){
            TagLib::ID3v2::FrameList frameList = mpegfile->ID3v2Tag()->frameListMap()["APIC"];
            if(!frameList.isEmpty()){
                TagLib::ID3v2::AttachedPictureFrame *picFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame *> (frameList.front());
                    QString jpgFileName { "/tmp/cover.jpg"};
                    QByteArray by=jpgFileName.toUtf8();
                    const char *cr=by.data();
                    FILE *fd = std::fopen(cr, "wb");
                    if (fd != NULL) {
                        fwrite(picFrame->picture().data(), picFrame->picture().size(), 1, fd);
                        fclose(fd);
                    }
                    qDebug() <<" The album picture has been written to cover.jpg";
            }else{
                qDebug() <<"there seem to be no picture frames (APIC) frames in this audio file";
            }
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
