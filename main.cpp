#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>
#include <QRect>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQmlContext>
#include <QAudioFormat>
#include <QAudioSource>

#include "mylrc.h"
#include"searchsong.h"
#include"songdecode.h"
#include "datasource.h"



int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;


    QAudioFormat formatAudio;
    formatAudio.setSampleRate(8000);
    formatAudio.setChannelCount(1);
    formatAudio.setSampleFormat(QAudioFormat::UInt8);
    QAudioSource *m_audioSource=new QAudioSource(formatAudio);
    DataSource* dataSource = new DataSource();
    dataSource->open(QIODevice::WriteOnly);
    m_audioSource->start(dataSource);
    engine.rootContext()->setContextProperty("dataSource", dataSource);



    qmlRegisterType<MyLrc>("MyLrc",1,0,"MyLrc");
    qmlRegisterType<SearchSong>("SearchSong",1,0,"SearchSong");   
    qmlRegisterType<Songdecode>("Songdecode",1,0,"Songdecode");
    const QUrl url(u"qrc:/lingTmusic/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
