import QtQuick
import QtQuick.Controls
Item {
    anchors.fill: parent
    Rectangle{
        anchors.fill: parent
        color: "white"
        Item{
        Row{
            //anchors.margins: 3
            spacing: 5
            Image {
                width: 80
                id: image
                //source: "file:///root/QML/my_music/11111111111/music_3/images/22.webp"
                //fillMode: Image.PreserveAspectFit
            }
            Column{
                Text {
                    text: qsTr("songName")
                }
                Text {
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
                //text:"pasue"

                width: 45
                height: 45
                icon.source: "file:///root/QML/my_music/11111111111/mymuisc/icon_emoji/tingge.png"
                onPressed: {
                    //playMusic()
                    console.log("pasue")
                }
            }

            RoundButton{
                text:"shangyishou"
                width: 45
                height: 45
                //icon.name: "document-new"
                onPressed: {
                    //pauseMusic()
                    console.log("shouyishou")
                }
            }

            RoundButton{
                text:"paly"
                width: 45
                height: 45
                onPressed: {
                   // stopMusic()
                    console.log("play")
                }
            }

            RoundButton{
                text:"xiayishou"
                width: 45
                height: 45
                onPressed: {
                   // stopMusic()
                    console.log("xiaoyishou")
                }
            }


            Text{
                anchors.verticalCenter: parent.verticalCenter

                id:text1
                text:"00:00"
            }

            Slider{
                anchors.verticalCenter: parent.verticalCenter
                id:slider
                from:0
                //to:myMediaPlayer.duration
                value: 0
                width: 130

//                        onValueChanged: {
//                            text1.text=Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(slider.position*myMediaPlayer.duration / 60000), Math.round((slider.position*myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))


//                            myMediaPlayer.position=value
//                        }
            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                text:"00:00"
//                            text: Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(myMediaPlayer.duration / 60000), Math.round((myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))
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
                //id:sliderV
                //from:0
                //to:myMediaPlayer.duration
                //value: 0
                //anchors.verticalCenter: parent.verticalCenter
                 width: 130

//                        onValueChanged: {
//                            text1.text=Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(slider.position*myMediaPlayer.duration / 60000), Math.round((slider.position*myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))


//                            myMediaPlayer.position=value
//                        }
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
}

