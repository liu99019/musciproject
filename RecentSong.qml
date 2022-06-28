import Songdecode 1.0
import QtQuick
import QtMultimedia
import QtQuick.Controls
import QtQuick.Dialogs
Item {

    //存取本地播放过的歌曲信息
    property var songurls_vec:[];
    property var songimgs_vec:[];
    property var songlrcs_vec:[];
    property var songname_vec:[];
    property var singername_vec:[];

    //判断是打开的是本地音乐还是网络音乐 0是本地 1是网络
    property int flag: -1
    property bool issave:true

    //判断歌曲添加
    property var addsongflag

    property alias songdecode: songdecode
    property alias fileOpen: fileOpen
    property alias recentListview: recentListview
    property alias playlistModel: playlistModel

    Songdecode{
        id:songdecode
    }
    ListView{

       id:recentListview

       anchors.fill: parent

       model: playlistModel
       delegate: playlistDelegate

       ScrollBar.vertical: ScrollBar {
           width: 12
           policy: ScrollBar.AlwaysOn
       }
    }

    ListModel{
        id:playlistModel
    }
    Component{
        id:playlistDelegate

        Text {
            text: songname
            color:ListView.isCurrentItem ? "gray" : "black"

            TapHandler{
                onDoubleTapped: {
                    recentListview.currentIndex=index
                    startplay()
                    stackLayout.currentIndex=0
                    myMediaPlayer.currentNextflag=1
                }
            }
        }
    }

    //打开文件对话框
    FileDialog {
        id: fileOpen
        title: "Select some songs files"
        fileMode: FileDialog.OpenFiles
        nameFilters: ["音乐文件 (*.mp3 *.wma *.flac *.ape)", "所有文件 (*)"]
        onAccepted: {

            setFile(fileOpen.currentFiles)
            musiclrc.mylrc.bendi(String(fileOpen.currentFiles[0]))
            musiclrc.beging();
        }
    }

    //文件的选择函数
    function setFile(){

        flag=0

        for(var i=0;i<arguments[0].length;i++){
            addsongflag=String (arguments[0][i])
            myMediaPlayer.source=String(arguments[0][i])
        }
    }



    onAddsongflagChanged: {

        if(flag===1){
            var i=0
            while(i<songurls_vec.length){
                if(songurls_vec[i]===songsearch.sc.url){
                    issave=false;
                    break;
                }
                else{
                    i++
                }
            }
            if(issave){
                playlistModel.append({"songname":songsearch.sc.songName[songsearch.songListView.currentIndex]+"-"+songsearch.sc.singerName[songsearch.songListView.currentIndex]})
            songurls_vec.push(songsearch.sc.url)
            songimgs_vec.push(songsearch.sc.image)
            songlrcs_vec.push(songsearch.sc.lyrics)

            songname_vec.push(songsearch.sc.songName[songsearch.songListView.currentIndex])
            singername_vec.push(songsearch.sc.singerName[songsearch.songListView.currentIndex])
            recentListview.currentIndex=songurls_vec.length-1
            }else{
                issave=true;
            }
        }
        else if(flag===0){
            while(i<songurls_vec.length){
                if(songurls_vec[i]===addsongflag){
                    issave=false;
                    break;
                }
                else{
                    i++
                }
            }
            if(issave){
                songurls_vec.push(addsongflag)
                playlistModel.append({"songname":addsongflag.toString().replace(/^.*[\\\/]/, '')})
                songimgs_vec.push("file:///run/media/root/study/qt/musicProject/project/lingTmusic/icon/yinle1.png")
                songlrcs_vec.push("null")

                songname_vec.push(addsongflag.toString().replace(/^.*[\\\/]/, ''))
                singername_vec.push("null")
                recentListview.currentIndex=songurls_vec.length-1
            }
        }else{
            console.log("error")
        }
    }


   function startplay(){

       musiclrc.mylrc.beginstr(songlrcs_vec[recentListview.currentIndex]);
       musiclrc.lrclistModel.clear();

       for(var i=0;i<musiclrc.mylrc.str.length;i++){
           musiclrc.lrclistModel.append({"lrc":musiclrc.mylrc.str[i]})
       }

       myMediaPlayer.source=songurls_vec[recentListview.currentIndex];
        buttonItem.songImg.source=songimgs_vec[recentListview.currentIndex];

       buttonItem.songName.text=songname_vec[recentListview.currentIndex];
       buttonItem.songerName.text=singername_vec[recentListview.currentIndex];
       musiclrc.backimg.source=songimgs_vec[recentListview.currentIndex];

       musiclrc.timer.start();

       myMediaPlayer.playMusic()

 }


}
