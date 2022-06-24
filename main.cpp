#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQmlContext>
#include <QScreen>
#include <QRect>
#include "mylrc.h"
#include"searchsong.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<MyLrc>("MyLrc",1,0,"MyLrc");
    qmlRegisterType<SearchSong>("SearchSong",1,0,"SearchSong");

    const QUrl url(u"qrc:/lingTmusic/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
