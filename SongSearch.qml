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

            myMediaPlayer.source=sc.url;
            musiclrc.beging()

            stackLayout.currentIndex=0;
            musiclrc.backimg.source=sc.image;

            buttonItem.songImg.source=sc.image;
            buttonItem.songName.text=sc.songName[songListView.currentIndex];
            buttonItem.songerName.text=sc.singerName[songListView.currentIndex];

        }
    }

   ColumnLayout{
    Row {
        TextField {
            id:keyWord
            selectByMouse: true
            font.pointSize: 12
            placeholderText:qsTr("薛之谦")
            Layout.fillWidth: true
        }
         RoundButton{

            //icon.source: "qrc:/icon_emoji/sousuo.png"
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
        Layout.leftMargin: 5
        Text {
            Layout.preferredWidth: 160
            Layout.rightMargin: 40
            text: qsTr("歌曲名")
            font.pixelSize: 15
        }
        Text {
            Layout.preferredWidth: 120
            Layout.rightMargin: 40
            text: qsTr("专辑")
            font.pixelSize: 15
        }
        Text {
            Layout.preferredWidth: 80
            text: qsTr("时长")
            font.pixelSize: 15
        }
    }

    ListView{
        id: songListView
        Layout.preferredWidth:640
        Layout.preferredHeight: 380
        clip: true
        spacing: 5
        currentIndex: -1
        model:songListModel

        delegate:songListDeleget
        ScrollBar.vertical: ScrollBar {
            width: 12
            policy: ScrollBar.AlwaysOn
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
            Text {
                text:song
                Layout.preferredWidth: 160
                Layout.rightMargin: 40
                elide: Text.ElideRight
            }
            Text {
                text: album
                Layout.preferredWidth: 120
                Layout.rightMargin: 40
                elide: Text.ElideRight
            }
            Text {
                text: duration
                Layout.preferredWidth: 80
                Layout.rightMargin: 20
            }
        }
        TapHandler{
            onDoubleTapped:{
                songListView.currentIndex=index;
                sc.getSongUrl(index);
             }
        }
    }

 }
    function addSongItem(){
         var s,m;
         songListModel.clear()
         for(var i=0;i<sc.singerName.length;i++) {
             m=(sc.duration[i]-sc.duration[i]%60)/60
             s=sc.duration[i]-m*60
             if(s>=0&s<10) {
                  songListModel.append({"song":sc.singerName[i]+"-"+sc.songName[i],"album":sc.albumName[i],"duration":m+":0"+s})
             } else {
                  songListModel.append({"song":sc.singerName[i]+"-"+sc.songName[i],"album":sc.albumName[i],"duration":m+":"+s})
             }
         }
     }

}
