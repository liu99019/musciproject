#ifndef AUDIOPLAYER_H
#define AUDIOPLAYER_H

#include <QObject>
#include <QAudioFormat>
#include <QAudioBuffer>
//#include <QMediaContent>
#include <QAudioDecoder>
#include <QAudioOutput>
#include "AudioBufferDevice.h"
#include <QResource>
#include <QAudioSink>
#include <QMediaPlayer>
#include <QAudioOutput>
class AudioPlayer : public QObject
{
    Q_OBJECT
public:
    explicit AudioPlayer(QString const& fname, QObject *parent = nullptr);
    void play();
    void setLowGain(float gain){_buffer->setLowGain(gain);}
    void setMidGain(float gain){_buffer->setMidGain(gain);}
    void setHighGain(float gain){_buffer->setHighGain(gain);}

signals:

public slots:

private:
//    QMediaPlayer *_output;
    QAudioSink *_output;
    AudioBufferDevice *_buffer;
};

#endif // AUDIOPLAYER_H
