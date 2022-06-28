/*此界面为按钮组件*/
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
    property alias order: order
    property alias circulate: circulate
    property alias random: random

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
                    width: 120
                }
                Text {
                    id:songerName
                    text: qsTr("songerName")
                    width: 120
                }
            }

            RoundButton{
                icon.width: 32
                icon.height: 32
                icon.source: "qrc:/icon/wenjian.png"
                onPressed: {
                    recent.fileOpen.open()
                    console.log("open")
                }
            }

            RoundButton{
                icon.height: 32
                icon.width: 32
                icon.source: "qrc:/icon/stop-circle.png"
                onPressed: {
                    myMediaPlayer.stopMusic()
                }
            }

            RoundButton{

                icon.height: 32
                icon.width: 32
                icon.source: "qrc:/icon/shangyishou.png"
                onPressed: {
                    if(myMediaPlayer.currentNextflag===0){
                    songsearch.songListView.decrementCurrentIndex();
                    songsearch.startplay()
                    }else if(myMediaPlayer.currentNextflag===1){
                        recent.recentListview.decrementCurrentIndex();
                        recent.startplay()
                    }
                }
            }

            RoundButton{
                id:pause
                icon.height: 32
                icon.width: 32
                visible:false
                icon.source: "qrc:/icon/yunhang.png"
                icon.color: "green"
                onPressed: {
                    myMediaPlayer.playMusic()
                    paly.visible=true
                    pause.visible=false
                }

            }
            RoundButton{
                id:paly
                icon.height: 32
                icon.width: 32
                icon.source: "qrc:/icon/zanting.png"
                visible: true
                onPressed: {
                    myMediaPlayer.pauseMusic()

                    paly.visible=false
                    pause.visible=true

                }
            }


            RoundButton{
                icon.height: 32
                icon.width: 32
                icon.source: "qrc:/icon/xiayishou.png"
                onPressed: {
                    if(myMediaPlayer.currentNextflag===0){
                    songsearch.songListView.incrementCurrentIndex()
                    songsearch.startplay()
                    }else if(myMediaPlayer.currentNextflag===1){
                        recent.recentListview.incrementCurrentIndex();
                        recent.startplay();
                    }
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

                onPressedChanged: {
                    if (!pressed) {
                       //myMediaPlayer.seek(value)
                        myMediaPlayer.position=value
                    }
                }


                Timer {
                    id: timer
                    interval: 500
                    running: true
                    repeat: true
                    onTriggered: {
                        // 正在拖拽的时候不更新位置
                        if (!parent.pressed) {
                            parent.value = myMediaPlayer.position
                        }
                    }
                }



            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                //text:"00:00"
                text: Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(myMediaPlayer.duration / 60000), Math.round((myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))
            }


            RoundButton{
                id:noSound
                visible: true
                icon.height: 30
                icon.width: 30
                icon.source: "qrc:/icon/shengyin_shiti.png"
                onPressed: {
                    myMediaPlayer.volume=0
                    noSound.visible=false
                    haveSound.visible=true
                }
            }

            RoundButton{
                id:haveSound
                visible: false
                icon.height: 30
                icon.width: 30
                icon.source: "qrc:/icon/jingyin.png"
                onPressed: {
                    myMediaPlayer.volume=sliderV.value
                    noSound.visible=true
                    haveSound.visible=false
                }
            }

            Slider{
                anchors.verticalCenter: parent.verticalCenter
                id:sliderV
                from:0
                to:1
                value: 0.5
                 width: 100

                        onValueChanged: {
                            myMediaPlayer.volume=value
                        }

                        height: 20
                        stepSize: 0.01
            }


            RoundButton{
                id:order
                icon.source: "qrc:/icon/shunxubofang.png"
                icon.width: 28
                icon.height: 28
                visible: true
                onPressed: {
                    order.visible=false
                    circulate.visible=true
                    random.visible=false
                }
            }

            RoundButton{
                id:circulate
                icon.source: "qrc:/icon/danquxunhuan.png"
                icon.width: 28
                icon.height: 28
                visible: false
                onPressed: {
                    order.visible=false
                    circulate.visible=false
                    random.visible=true
                }
            }

            RoundButton{
                id:random
                icon.source: "qrc:/icon/suijibofang.png"
                visible: false
                icon.width: 28
                icon.height: 28

                onPressed: {
                    order.visible=true
                    circulate.visible=false
                    random.visible=false
                }
            }

            RoundButton{
                text:"词"
                width: 40
                height: 40
                onPressed: {
                    if(!gc.visible){
                        gc.visible=true
                    }else{
                        gc.visible=false
                    }
                }
            }

        }
     }
 }
    Window{
            id: gc
            visible: false
            width: 500
            height: 100
            title: qsTr("歌词")

            Text{
                id: mt
                anchors.centerIn: parent
                visible: true
                color: "blue"
                //text:"曾经年少爱追梦，一心只想往前飞。"
                text:musiclrc.lrclistModel.get(musiclrc.lrcListView.currentIndex).lrc
                font.pixelSize: 28
             }
        }


}

