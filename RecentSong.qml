import QtQuick
import QtMultimedia
import QtQuick.Controls
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

    property alias recentListview: recentListview
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
                }
            }
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
            recentListview.currentIndex=songurls_vec.length
            }else{
                issave=true;
            }
        }
        else if(flag===0){

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

