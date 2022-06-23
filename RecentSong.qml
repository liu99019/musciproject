import QtQuick
import QtMultimedia
Item {

    //property alias playlistModel: playlistModel

    id:recentsongPage
    //property var songurls:[];
    //property var songimgs:[];
    //anchors.fill: parent
    ListView{
       anchors.fill: parent
       model: playlistModel
       delegate: playlistDelegate
    }

    ListModel{
        id:playlistModel
    }
    Component{
        id:playlistDelegate
        Text {
            text: songnamae
        }
    }

   function onSendSongsignal(){
           playlistModel.append({"songnamae":songsearch.sc.songName[songsearch.songListView.currentIndex]+"-"+songsearch.sc.singerName[songsearch.songListView.currentIndex]})
   }

   function clearListModel()
   {
       playlistModel.clear();
   }

//   function apendModel(QString str)
//   {
//       //playlistModel.append("songnamae":str)
//   }

}

