#include <QApplication>
#include <QAudioDecoder>
#include <QAudioOutput>
#include <QUrl>
#include <QBuffer>
#include "AudioPlayer.h"
#include "EQWidget.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    EQWidget widget("file://root/run/media/root/study/tmp/Justin Timberlake-Five Hundred Miles.mp3");
    widget.show();

    return a.exec();
}
