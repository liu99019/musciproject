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
    property var albumname_vec:[];

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
            text: index+1+".      "+songname
            color:ListView.isCurrentItem ? "green" : "black"

            font.pixelSize: 23

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
        }
    }

    //文件的选择函数
    function setFile(){

        flag=0

        for(var i=0;i<arguments[0].length;i++){
            songdecode.getTag(arguments[0][i])
            addsongflag=String (arguments[0][i])
            //myMediaPlayer.source=String(arguments[0][i])
        }
    }



    onAddsongflagChanged: {

        if(flag===1){
            var i=0
            while(i<songurls_vec.length){
                if(songurls_vec[i]===songsearch.sc.url){
                    recentListview.currentIndex=i
                    issave=false;
                    break;                    
                }
                else{
                    i++
                }
            }
            if(issave){
                playlistModel.append({"songname":songsearch.sc.songName[songsearch.songListView.currentIndex]+"-"+songsearch.sc.singerName[songsearch.songListView.currentIndex]})
            //将网络歌曲的信息通过容器添加当中
            songurls_vec.push(songsearch.sc.url)
            songimgs_vec.push(songsearch.sc.image)
            songlrcs_vec.push(songsearch.sc.lyrics)
            albumname_vec.push(songsearch.sc.albumName[songsearch.songListView.currentIndex])
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
                //将本地音乐添加最近播放列表当中
                songurls_vec.push(addsongflag)
                playlistModel.append({"songname":songdecode.songTag["标题"]})
                songimgs_vec.push("file:///tmp/cover.jpg")
                songname_vec.push(songdecode.songTag["标题"])
                singername_vec.push(songdecode.songTag["歌手"])
                albumname_vec.push(songdecode.songTag["唱片集"])
                recentListview.currentIndex=songurls_vec.length-1
            }
        }else{
            console.log("error")
        }
        setsongInfomation();
    }


    //播放歌曲
   function startplay(){

       if(flag==1){
       musiclrc.mylrc.beginstr(songlrcs_vec[recentListview.currentIndex]);
       musiclrc.lrclistModel.clear();
       for(var i=0;i<musiclrc.mylrc.str.length;i++){
           musiclrc.lrclistModel.append({"lrc":musiclrc.mylrc.str[i]})
       }
       }else if(flag==0){
           musiclrc.mylrc.bendi(String(songurls_vec[recentListview.currentIndex]))
           musiclrc.beging();
       }else{
           console.log("error")
       }


       myMediaPlayer.source=songurls_vec[recentListview.currentIndex];

       buttonItem.songImg.source=songimgs_vec[recentListview.currentIndex];

       buttonItem.songName.text=songname_vec[recentListview.currentIndex];

       buttonItem.songerName.text=singername_vec[recentListview.currentIndex];
       musiclrc.backimg.source=songimgs_vec[recentListview.currentIndex];
       musiclrc.timer.start();
       myMediaPlayer.playMusic()
 }

   //显示歌曲信息
   function setsongInfomation(){
       songinfo.cover.source=songimgs_vec[recentListview.currentIndex]
       songinfo.titleInput.text=songname_vec[recentListview.currentIndex]
       songinfo.artistInput.text=singername_vec[recentListview.currentIndex]
       songinfo.albumInput.text=albumname_vec[recentListview.currentIndex]
       if(flag==0){
       songinfo.trackInput.text=songdecode.songTag["音轨号"]
       songinfo.yearInput.text=songdecode.songTag["日期"]
       songinfo.generInput.text=songdecode.songTag["流派"]
       songinfo.annotationInput.text=songdecode.songTag["注释"]
       }
   }

}
