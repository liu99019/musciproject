import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs
import QtQuick.Layouts
MediaPlayer{

        audioOutput:
        AudioOutput {
            id:audioUotput
            volume: 7
        }

         onPositionChanged: {
             //进度
             //progress.text=msecString(position)+progress.sDuration;
         }
         onDurationChanged: {
             //时长
             //progress.sDuration=" / "+msecString(duration);
         }

         function palyMusic()
         {
             myMediaPlayer.play();
         }

         onSourceChanged: {
             myMediaPlayer.sendsongChange();
         }
 }








