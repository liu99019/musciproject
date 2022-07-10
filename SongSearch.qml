/*此页面为歌曲搜索界面*/
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SearchSong 1.0
Item{
    property alias sc: sc
    property alias songListView: songListView

    SearchSong{
        id:sc
        onSongNameChanged: {addSongItem()}
        onUrlChanged: {
            //更新最近列表flag
            recent.flag=1
            recent.addsongflag=sc.singerName;
            startplay();
        }

    }

   ColumnLayout{
    Row {
        Layout.leftMargin: 380
        TextField {
            anchors.verticalCenter: parent.verticalCenter
            id:keyWord
            width: 170
            selectByMouse: true
            font.pointSize: 12
            placeholderText:qsTr("薛之谦")
            Layout.fillWidth: true
        }

        RoundButton{

           icon.width: 20
           icon.height: 20
           icon.source: "qrc:/icon/icon5.png"
           onClicked: {
               if(keyWord.text.length===0) {
                   keyWord.text=keyWord.placeholderText
                   sc.searchSong(keyWord.text);
               } else {
                   sc.searchSong(keyWord.text);
               }
           }

       }
    }

    RowLayout{
        id: row1
        Layout.fillWidth: true
        Layout.leftMargin: 20

        Text {
            Layout.preferredWidth: 200
            Layout.rightMargin: 40
            text: qsTr("歌曲名")
            font.pixelSize: 20
        }

        Text {
            Layout.preferredWidth: 200
            Layout.rightMargin: 40
            text: qsTr("歌手")
            font.pixelSize: 20
        }

        Text {
            Layout.preferredWidth: 200
            Layout.rightMargin: 40
            text: qsTr("专辑")
            font.pixelSize: 20
        }

        Text {
            Layout.preferredWidth: 200
            text: qsTr("时长")
            font.pixelSize: 20
        }
    }

    ListView{
        id: songListView
        Layout.preferredWidth:980
        Layout.preferredHeight: 580
        clip: true
        spacing: 5
        currentIndex: -1
        model:songListModel

        delegate:songListDeleget
        ScrollBar.vertical: ScrollBar {
            width: 12
            policy: ScrollBar.AlwaysOn
        }

        onCurrentIndexChanged: {
            sc.getSongUrl(currentIndex);
        }
    }

}
   ListModel{
    id:songListModel
   }

    Component{
    id:songListDeleget
    Rectangle{
        radius: 4
        width: songListView.width - 20
        height: 40
        focus: true
        color:ListView.isCurrentItem ? "lightgrey" : "white"
        RowLayout{
            id:sarchLayout
            Layout.fillWidth: true
            Text {
                text:song
                Layout.leftMargin: 20
                Layout.preferredWidth: 200
                Layout.rightMargin: 40
                elide: Text.ElideRight
                font.pixelSize:18
            }
            Text {
                text:singername
                Layout.preferredWidth: 200
                Layout.rightMargin: 40
                elide: Text.ElideRight
                font.pixelSize:18
            }
            Text {
                text: album
                Layout.preferredWidth: 200
                Layout.rightMargin: 40
                elide: Text.ElideRight
                font.pixelSize:18
            }
            Text {
                text: duration
                Layout.preferredWidth: 200
                Layout.rightMargin: 20
                font.pixelSize:18
            }
        }
        TapHandler{
            onDoubleTapped:{
                songListView.currentIndex=index;
                myMediaPlayer.currentNextflag=0;
             }
        }
    }

 }
    //将搜索到的歌曲添加到搜索列表当中
    function addSongItem(){
         var s,m;
         songListModel.clear()
         for(var i=0;i<sc.singerName.length;i++) {
             m=(sc.duration[i]-sc.duration[i]%60)/60
             s=sc.duration[i]-m*60
             if(s>=0&s<10) {
                  songListModel.append({"song":sc.songName[i],"singername":sc.singerName[i],"album":sc.albumName[i],"duration":m+":0"+s})
             } else {
                  songListModel.append({"song":sc.songName[i],"singername":sc.singerName[i],"album":sc.albumName[i],"duration":m+":"+s})
             }
         }
     }

    //歌曲播放
    function startplay(){
        myMediaPlayer.source=sc.url;
        musiclrc.beging()
        stackLayout.currentIndex=0;
        musiclrc.backimg.source=sc.image;
        buttonItem.songImg.source=sc.image;
        buttonItem.songName.text=sc.songName[songListView.currentIndex];
        buttonItem.songerName.text=sc.singerName[songListView.currentIndex];
    }

}
