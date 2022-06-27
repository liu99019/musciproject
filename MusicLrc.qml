import QtQuick
import QtCore
import QtQuick.Window
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs
import QtQuick.Layouts
import MyLrc 1.0

Item {

    property alias backimg: backimg
    property alias mylrc: mylrc
    property alias lrclistModel: lrclistModel
    property alias timer: timer
    property alias lrcListView:lrcListView



//    FileDialog {
//        id: fileOpen
//        title: "Select some picture files"
//        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
//        fileMode: FileDialog.OpenFiles
//        nameFilters: [ "Song files (*.mp3)" ]
//        onAccepted: {
//            //console.log(fileOpen.selectedFiles)
//            myMediaPlayer.source=fileOpen.selectedFiles[0]
//        }
//    }

    Image {
        id:backimg
        anchors.fill: parent
        opacity: 0.5
    }


    ListView {

        id:lrcListView
        anchors.horizontalCenter: parent.horizontalCenter
        //width: 180; height: 400
        width: parent.width
        height: parent.height*0.9
        highlightRangeMode:ListView.ApplyRange
        preferredHighlightBegin:height/3+30
        preferredHighlightEnd: height/3+60

        focus: true
        highlight: Rectangle{
            //color: "lightblue"
            opacity: 0
        }


        model: lrclistModel

        delegate: Text {
            id:textGc
            //focus: true
            width: lrcListView.width
            color:ListView.isCurrentItem ? "green" : "black"
            font.pixelSize: ListView.isCurrentItem ? 25 : 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: lrc
           TapHandler{
               onTapped: {
                    lrcListView.currentIndex=index;
                   //console.log(lrcListView.currentIndex)
               }

           }
        }
    }



    ListModel{
        id:lrclistModel
    }

    MyLrc{
        id:mylrc
        fileUrl: "/root/tmp/海阔天空.lrc"
    }



Timer{
    id:timer
    interval: 1000
    repeat: true
    onTriggered: {
//        console.log( Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(myMediaPlayer.position / 60000), Math.round((myMediaPlayer.position % 60000) / 1000)),qsTr("mm:ss")))

//       console.log( mylrc.pisotionChange(Math.floor(myMediaPlayer.position / 60000), Math.round((myMediaPlayer.position % 60000) / 1000))  )
////console.log(Math.floor(myMediaPlayer.position / 60000)+":"+ Math.round((myMediaPlayer.position % 60000) / 1000))

lrcListView.currentIndex=mylrc.pisotionChange(Math.floor(myMediaPlayer.position / 60000), Math.round((myMediaPlayer.position % 60000) / 1000))

    }
}


function beging()
{


    if(recent.flag==1)
    mylrc.beginstr(songsearch.sc.lyrics);


    lrclistModel.clear();
    for(var i=0;i<mylrc.str.length;i++){
        lrclistModel.append({"lrc":mylrc.str[i]})
    }
    timer.start();
    myMediaPlayer.playMusic()
}


}
