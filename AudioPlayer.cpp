#include "AudioPlayer.h"
#include <QUrl>
#include <QAudioSource>
#include <QMediaFormat>
#include <QMediaRecorder>
#include <QMediaCaptureSession>

AudioPlayer::AudioPlayer(const QString &fname, QObject *parent)
{
    auto content = QUrl(fname);
//    QMediaResource resource = content->canonicalResource();

    QAudioFormat format;
    format.setSampleRate(44100);
    format.setChannelCount(2);
    format.setSampleFormat(QAudioFormat::Int32);

    QAudioSource *resource = new QAudioSource(format);
//    resource = content.fileName();
    QAudioDecoder* decoder = new QAudioDecoder(this);
    decoder->setAudioFormat(format);
    decoder->setSource(fname);
    qDebug() << "isvalide: " << format.isValid();

    _output = new QAudioSink(format, this);
    _buffer = new AudioBufferDevice(decoder, this);
    _buffer->open(QIODevice::ReadOnly);
}

void AudioPlayer::play()
{
   _output->start(_buffer);
}
