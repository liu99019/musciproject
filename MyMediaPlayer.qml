
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs
import QtQuick.Layouts
MediaPlayer{

    id:myMediaPlayer
    property alias volume:audioUotput.volume
    property alias position:myMediaPlayer.position
    property alias duration:myMediaPlayer.duration
    property int currentNextflag: -1
    audioOutput:
    AudioOutput {
        id:audioUotput
        volume: 7
    }

    //播放 暂停  停止音乐的函数
    function playMusic()
    {
        myMediaPlayer.play();
    }


    function pauseMusic()
    {

        myMediaPlayer.pause()
    }

    function stopMusic()
    {

        myMediaPlayer.stop()

    }


    onMediaStatusChanged: {
        if(mediaStatus===MediaPlayer.EndOfMedia){
            if(buttonItem.order.visible){

                    console.log("播放完")
                    recent.recentListview.incrementCurrentIndex();
                    recent.startplay()
            }


//                }else if(buttonItem.circulate.visible){
//                  if(myMediaPlayer.position>myMediaPlayer.duration)
//                  {
//                       recent.startplay()
//                  }
//              }
//              else if(buttonItem.random.visible){
//                  if(myMediaPlayer.position>myMediaPlayer.duration)
//                  {

//                  }
//              }
        }
    }

    onPositionChanged: {
            buttonItem.value=myMediaPlayer.position
        }

 }








