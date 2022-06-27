import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs


Item {

    property alias text1:text1
    property alias value:slider1.value
    property alias position:slider1.position
    property alias songImg:songImg
    property alias songName:songName
    property alias songerName:songerName

    anchors.fill: parent
    Rectangle{
        anchors.fill: parent
        color: "white"
        Item{
        Row{
            //anchors.margins: 3
            spacing: 5
            Image {
                id:songImg
                width: 80
                height: 60
                //source: "file:///root/QML/my_music/11111111111/music_3/images/22.webp"
                fillMode: Image.PreserveAspectFit
            }
            Column{

                Text {
                    id:songName
                    text: qsTr("songName")
                }
                Text {
                    id:songerName
                    text: qsTr("songerName")
                }
            }



            Rectangle{
                //visible: flase
                width: 60
                height: parent.height
                color: "white"
            }


            RoundButton{
                text:"open"
                width: 45
                height: 45
                onPressed: {
                    fileOpen.open()
                    console.log("open")
                }
            }

            RoundButton{
                text:"stop"
                width: 45
                height: 45
                //icon.source: "file:///root/QML/my_music/11111111111/mymuisc/icon_emoji/tingge.png"
                onPressed: {
                    myMediaPlayer.stopMusic()

                }
            }

            RoundButton{
                //text:"shangyishou"
                width: 45
                height: 45
                icon.source:":/icon/biaoqian.png"
                onPressed: {
                    recent.recentListview.decrementCurrentIndex();
                    recent.startplay()
                }
            }

            RoundButton{
                id:pause
                text:"pause"
                width: 45
                height: 45
                visible:false

                onPressed: {
                    myMediaPlayer.playMusic()
                    paly.visible=true
                    pause.visible=false
                }

            }
            RoundButton{
                id:paly
                text:"paly"
                width: 45
                height: 45
                visible: true
                onPressed: {
                    myMediaPlayer.pauseMusic()

                    paly.visible=false
                    pause.visible=true

                }
            }


            RoundButton{
                text:"xiayishou"
                width: 45
                height: 45
                onPressed: {
                   recent.recentListview.incrementCurrentIndex();
                   recent.startplay()
                }
            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                id:text1
                text:Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(slider1.position*myMediaPlayer.duration / 60000), Math.round((slider1.position*myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))
            }

            Slider{
                anchors.verticalCenter: parent.verticalCenter
                id:slider1
                from:0
                to:myMediaPlayer.duration
                value: 0
                width: 200

                onValueChanged: {




                   // myMediaPlayer.position=value
                        }

                Timer {
                    id: timer
                    interval: 500
                    running: true
                    repeat: true
                    onTriggered: {
                        // 正在拖拽的时候不更新位置
//                        if (!parent.pressed) {
//                            //parent.value = myMediaPlayer.position
//                        }
                    }
                }
            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                //text:"00:00"
                text: Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(myMediaPlayer.duration / 60000), Math.round((myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))
            }


            RoundButton{
                text:"音量"
                width: 45
                height: 45
                onPressed: {
                   // stopMusic()
                    //console.log("xiaoyishou")
                }
            }

            Slider{
                anchors.verticalCenter: parent.verticalCenter
                id:sliderV
                from:0
                to:1
                value: 0.5
                 width: 50

                        onValueChanged: {
                            myMediaPlayer.volume=value
                        }
                        //width: 600
                        height: 20
                        stepSize: 0.01
            }


            RoundButton{
                text:"循环播放方式"
                width: 45
                height: 45
                onPressed: {
                   // stopMusic()
                    //console.log("xiaoyishou")
                }
            }

            RoundButton{
                text:"歌词"
                width: 45
                height: 45
                onPressed: {
                   // stopMusic()
                    console.log("xiaoyishou")
                }
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

        recent.clearListModel();
        for(var i=0;i<arguments[0].length;i++){
            //filesModel.append({"picSrc":String (arguments[0][i])})
            //recent.playlistModel.append({"picSrc":String (arguments[0][i])})
            myMediaPlayer.source=String(arguments[0][i])
            myMediaPlayer.play()
            console.log(myMediaPlayer.source)
            //console.log(myMediaPlayer.metaData.stringValue(MediaMetaData.Title))
        }
    }





}

