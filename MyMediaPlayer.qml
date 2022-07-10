
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
    //下一首的歌曲列表1是最近播放 0是网络搜索播放的列表
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
                if(currentNextflag==1){
                    console.log("当前在最近播放列表")
                    recent.recentListview.incrementCurrentIndex();
                    recent.startplay()}
                else{
                    console.log("当前在搜索列表")
                    songsearch.songListView.incrementCurrentIndex();
                    songsearch.startplay();
                }
            }else if(buttonItem.circulate){                
                myMediaPlayer.loops=-1
            }
            else{
                if(currentNextflag==1){
                var random1=Math.floor(Math.random()*(recent.recentListview-1))
                recent.recentListview.currentIndex=random1
                recent.startplay();}
                else{
                    var random2=Math.floor(Math.random()*(songsearch.songListView-1))
                    songsearch.songListView.currentIndex=random2
                    songsearch.startplay();
                }
            }
        }
    }

 }








