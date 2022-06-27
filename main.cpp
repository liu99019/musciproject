#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QAudioFormat>
//#include <QAudioDeviceInfo>
#include <QAudioDevice>
#include <QQuickView>
#include <QAudioInput>
#include "DataSource.h"

#include <QAudioDecoder>
#include <QAudioSource>

int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    QQuickView viewer;

    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

    viewer.setTitle(QStringLiteral("Audio Sample"));

    QAudioFormat formatAudio;
    formatAudio.setSampleRate(8000);
    formatAudio.setChannelCount(1);
//    formatAudio.setSampleSize(8);
//    formatAudio.setCodec("audio/pcm");
//    formatAudio.setByteOrder(QAudioFormat::LittleEndian);
//    formatAudio.setSampleType(QAudioFormat::UnSignedInt);
    formatAudio.setSampleFormat(QAudioFormat::UInt8);

//    QAudioDeviceInfo inputDevices = QAudioDeviceInfo::defaultInputDevice();
//    QAudioInput* m_audioInput = new QAudioInput(inputDevices,formatAudio);
    QAudioSource *m_audioSource=new QAudioSource(formatAudio);
    //m_audioInput.setAudioFormat(formatAudio);

    DataSource* dataSource = new DataSource();
    dataSource->open(QIODevice::WriteOnly);

    m_audioSource->start(dataSource);
    viewer.rootContext()->setContextProperty("dataSource", dataSource);

    viewer.setSource(QUrl("qrc:/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setColor(QColor("#404040"));
    viewer.show();

    return app.exec();
}
