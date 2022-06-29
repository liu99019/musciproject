///*此界面为按钮组件*/
//import QtQuick
//import QtQuick.Controls
//import QtQuick.Dialogs
//Item {

//    property alias text1:text1
//    property alias value:slider1.value
//    property alias position:slider1.position
//    property alias songImg:songImg
//    property alias songName:songName
//    property alias songerName:songerName
//    property alias order: order
//    property alias circulate: circulate
//    property alias random: random

//    anchors.fill: parent
//    Rectangle{
//        anchors.fill: parent
//        color: "white"
//        Item{
//        Row{
//            //anchors.margins: 3
//            spacing: 5
//            Image {
//                id:songImg
//                width: 80
//                height: 60
//                fillMode: Image.PreserveAspectFit
//            }
//            Column{

//                Text {
//                    id:songName
//                    text: qsTr("songName")
//                    width: 120
//                    elide: Text.ElideRight
//                }
//                Text {
//                    id:songerName
//                    text: qsTr("songerName")
//                    width: 120
//                    elide: Text.ElideRight
//                }
//            }

//            RoundButton{
//                icon.width: 32
//                icon.height: 32
//                icon.source: "qrc:/icon/wenjian.png"
//                onPressed: {
//                    recent.fileOpen.open()
//                    console.log("open")
//                }
//            }

//            RoundButton{
//                icon.height: 32
//                icon.width: 32
//                icon.source: "qrc:/icon/stop-circle.png"
//                onPressed: {
//                    myMediaPlayer.stopMusic()
//                }
//            }

//            RoundButton{

//                icon.height: 32
//                icon.width: 32
//                icon.source: "qrc:/icon/shangyishou.png"
//                onPressed: {
//                    if(myMediaPlayer.currentNextflag===0){
//                    songsearch.songListView.decrementCurrentIndex();
//                    songsearch.startplay()
//                    }else if(myMediaPlayer.currentNextflag===1){
//                        recent.recentListview.decrementCurrentIndex();
//                        recent.startplay()
//                    }
//                }
//            }

//            RoundButton{
//                id:pause
//                icon.height: 32
//                icon.width: 32
//                visible:false
//                icon.source: "qrc:/icon/yunhang.png"
//                icon.color: "green"
//                onPressed: {
//                    myMediaPlayer.playMusic()
//                    paly.visible=true
//                    pause.visible=false
//                }

//            }
//            RoundButton{
//                id:paly
//                icon.height: 32
//                icon.width: 32
//                icon.source: "qrc:/icon/zanting.png"
//                visible: true
//                onPressed: {
//                    myMediaPlayer.pauseMusic()

//                    paly.visible=false
//                    pause.visible=true

//                }
//            }


//            RoundButton{
//                icon.height: 32
//                icon.width: 32
//                icon.source: "qrc:/icon/xiayishou.png"
//                onPressed: {
//                    if(myMediaPlayer.currentNextflag===0){
//                    songsearch.songListView.incrementCurrentIndex()
//                    songsearch.startplay()
//                    }else if(myMediaPlayer.currentNextflag===1){
//                        recent.recentListview.incrementCurrentIndex();
//                        recent.startplay();
//                    }
//                }
//            }


//            Text{
//                anchors.verticalCenter: parent.verticalCenter
//                id:text1
//                text:Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(slider1.position*myMediaPlayer.duration / 60000), Math.round((slider1.position*myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))
//            }

//            Slider{
//                anchors.verticalCenter: parent.verticalCenter
//                id:slider1
//                from:0
//                to:myMediaPlayer.duration
//                value: 0
//                width: 200

//                onPressedChanged: {
//                    if (!pressed) {
//                       //myMediaPlayer.seek(value)
//                        myMediaPlayer.position=value
//                    }
//                }


//                Timer {
//                    id: timer
//                    interval: 500
//                    running: true
//                    repeat: true
//                    onTriggered: {
//                        // 正在拖拽的时候不更新位置
//                        if (!parent.pressed) {
//                            parent.value = myMediaPlayer.position
//                        }
//                    }
//                }



//            }


//            Text{
//                anchors.verticalCenter: parent.verticalCenter
//                //text:"00:00"
//                text: Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(myMediaPlayer.duration / 60000), Math.round((myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))
//            }


//            RoundButton{
//                id:noSound
//                visible: true
//                icon.height: 30
//                icon.width: 30
//                icon.source: "qrc:/icon/shengyin_shiti.png"
//                onPressed: {
//                    myMediaPlayer.volume=0
//                    noSound.visible=false
//                    haveSound.visible=true
//                }
//            }

//            RoundButton{
//                id:haveSound
//                visible: false
//                icon.height: 30
//                icon.width: 30
//                icon.source: "qrc:/icon/jingyin.png"
//                onPressed: {
//                    myMediaPlayer.volume=sliderV.value
//                    noSound.visible=true
//                    haveSound.visible=false
//                }
//            }

//            Slider{
//                anchors.verticalCenter: parent.verticalCenter
//                id:sliderV
//                from:0
//                to:1
//                value: 0.5
//                 width: 100

//                        onValueChanged: {
//                            myMediaPlayer.volume=value
//                        }

//                        height: 20
//                        stepSize: 0.01
//            }


//            RoundButton{
//                id:order
//                icon.source: "qrc:/icon/shunxubofang.png"
//                icon.width: 28
//                icon.height: 28
//                visible: true
//                onPressed: {
//                    order.visible=false
//                    circulate.visible=true
//                    random.visible=false
//                }
//            }

//            RoundButton{
//                id:circulate
//                icon.source: "qrc:/icon/danquxunhuan.png"
//                icon.width: 28
//                icon.height: 28
//                visible: false
//                onPressed: {
//                    order.visible=false
//                    circulate.visible=false
//                    random.visible=true
//                }
//            }

//            RoundButton{
//                id:random
//                icon.source: "qrc:/icon/suijibofang.png"
//                visible: false
//                icon.width: 28
//                icon.height: 28

//                onPressed: {
//                    order.visible=true
//                    circulate.visible=false
//                    random.visible=false
//                }
//            }

//            RoundButton{
//                text:"词"
//                width: 40
//                height: 40
//                onPressed: {
//                    if(!gc.visible){
//                        gc.visible=true
//                    }else{
//                        gc.visible=false
//                    }
//                }
//            }

//        }
//     }
// }
//    Window{
//            id: gc
//            visible: false
//            width: 500
//            height: 100
//            title: qsTr("歌词")

//            Text{
//                id: mt
//                anchors.centerIn: parent
//                visible: true
//                color: "blue"
//                text:musiclrc.lrclistModel.get(musiclrc.lrcListView.currentIndex).lrc
//                font.pixelSize: 28
//             }
//        }


//}





import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

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
                anchors.verticalCenter: parent.verticalCenter
                id:songImg
                width: 80
                height: 60
                //source: "file:///root/QML/my_music/11111111111/music_3/images/22.webp"
                fillMode: Image.PreserveAspectFit
            }
            Column{

                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id:songName
                    text: qsTr("songName")
                    width: 120
                    elide: Text.ElideRight
                }
                Text {
                    id:songerName
                    text: qsTr("songerName")
                    width: 120
                    elide: Text.ElideRight
                }
            }

//            RoundButton{
//                icon.width: 32
//                icon.height: 32
//                icon.source: "qrc:/icon/wenjian.png"
//                onPressed: {
//                    recent.fileOpen.open()
//                    console.log("open")
//                }
//            }


            Button{
                id:wenj
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 32
                background: Rectangle{
                    color: wenj.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 32
                        height: 32
                        source: "qrc:/icon/wenjian.png"
                    }
                }
                onClicked: {
                    recent.fileOpen.open()
                    console.log("open")
                }
            }

            Button{
                id:stop
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 32
                background: Rectangle{
                    color: stop.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 32
                        height: 32
                        source: "qrc:/icon/icon02.png"
                    }
                }
                onClicked: {
                    myMediaPlayer.stopMusic()
                }
            }




            Button{
                id:sy
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 32
                background: Rectangle{
                    color: sy.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 32
                        height: 32
                        source: "qrc:/icon/shangyishou.png"
                    }
                }
                onClicked: {
                    if(myMediaPlayer.currentNextflag===0){
                    songsearch.songListView.decrementCurrentIndex();
                    songsearch.startplay()
                    }else if(myMediaPlayer.currentNextflag===1){
                        recent.recentListview.decrementCurrentIndex();
                        recent.startplay()
                    }
                }
            }





            Button{
                anchors.verticalCenter: parent.verticalCenter
                id:pause
                width: 32
                height: 32
                visible:false
                background: Rectangle{
                    color: pause.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 32
                        height: 32
                        source: "qrc:/icon/icon01.png"
                    }
                }
                onClicked: {
                    myMediaPlayer.playMusic()
                    paly.visible=true
                    pause.visible=false
                }
            }





            Button{
                anchors.verticalCenter: parent.verticalCenter
                id:paly
                width: 32
                height: 32
                background: Rectangle{
                    color: paly.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 32
                        height: 32
                        source: "qrc:/icon/icon03.png"
                    }
                }
                onClicked: {
                    myMediaPlayer.pauseMusic()

                    paly.visible=false
                    pause.visible=true
                }
            }







            Button{
                id:xy
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 32
                background: Rectangle{
                    color: xy.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 32
                        height: 32
                        source: "qrc:/icon/xiayishou.png"
                    }
                }
                onClicked: {
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

                height: 7

                onPressedChanged: {
                   myMediaPlayer.position=value
                       if(myMediaPlayer.mediaStatus==5)
                           myMediaPlayer.playMusic();
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
                                        //console.log("当前状态"+myMediaPlayer.mediaStatus)
                                    }
                                }

                background: Rectangle {
                   // radius: 40
                    id: barBg
                    x: 0
                    y: 0
                    implicitWidth: 40
                    implicitHeight: 2
                    width: parent.width
                    height: parent.height
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00
                            color: "#e3e5e2"
                        }
                        GradientStop {
                            position: 0.50
                            color: "#efe0e3"
                        }
                        GradientStop {
                            position: 1.00
                            color: "#e3e5e2"
                        }
                    }
                    border.width: 0
                    border.color: "#e0d6de"

                    // 进度条已完成部分
                    Rectangle {
            ///
            //radius: 40
                        id: readyBg
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: timeHandle.x + timeHandle.implicitWidth / 2
                        height: parent.height
                        LinearGradient {
                            anchors.fill: parent
                            start: Qt.point(parent.x, parent.y)
                            end: Qt.point(parent.x + parent.width, parent.y)
                            gradient: Gradient {
                                GradientStop {
                                    position: 0
                                    color: "#808080"
                                }
                                GradientStop {
                                    //position: readyBg.width / timeSlider.width
                                    color: "#8594a8"
                                }
                            }
                        }
                    }
                }

                // 按钮阴影
                Glow {
                    id: effect
                    anchors.fill: timeHandle
                    source: timeHandle
                    radius: 5
                    spread: 0.2
                    color: "#bbbbbb"
                    //samples: 11
                }

                // 进度条按钮
                handle: Rectangle {
                    id: timeHandle
                    x: parent.visualPosition * (parent.width - implicitWidth)
                    anchors.verticalCenter: parent.verticalCenter
                    implicitWidth: 14
                    implicitHeight: 14
                    radius: 7
                    color: parent.pressed ? "#e0e0e0" : "#ffffff"
                    border.width: 1
                    border.color: "#d0bfcc"
                }




            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                //text:"00:00"
                text: Qt.formatTime(new Date(0, 0, 0, 0, Math.floor(myMediaPlayer.duration / 60000), Math.round((myMediaPlayer.duration % 60000) / 1000)),qsTr("mm:ss"))
            }





            Button{
                anchors.verticalCenter: parent.verticalCenter
                id:noSound
                visible: true
                width: 29
                height: 29
                background: Rectangle{
                    color: noSound.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 28
                        height: 28
                        source: "qrc:/icon/icon9.png"
                    }
                }
                onClicked: {
                    myMediaPlayer.volume=0
                    noSound.visible=false
                    haveSound.visible=true
                }
            }






            Button{
                anchors.verticalCenter: parent.verticalCenter
                id:haveSound
                visible: false
                width: 29
                height: 29
                background: Rectangle{
                    color: haveSound.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 29
                        height: 29
                        source: "qrc:/icon/icon2.png"
                    }
                }
                onClicked: {
                    myMediaPlayer.volume=sliderV.value
                    noSound.visible=true
                    haveSound.visible=false
                }
            }



//            Slider{
//                anchors.verticalCenter: parent.verticalCenter
//                id:sliderV
//                from:0
//                to:1
//                value: 0.5
//                 width: 100

//                        onValueChanged: {
//                            myMediaPlayer.volume=value
//                        }

//                        height: 20
//                        stepSize: 0.01
//            }



            Slider{
                anchors.verticalCenter: parent.verticalCenter
                id:sliderV
                from:0
                to:1
                value: 0.5
                width: 100
                stepSize: 0.01
                height: 7

                onValueChanged: {
                myMediaPlayer.volume=value
                }
                // 进度条主体
                background: Rectangle {
                   // radius: 40
                    id: barBg2
                    x: 0
                    y: 0
                    implicitWidth: 40
                    implicitHeight: 2
                    width: parent.width
                    height: parent.height
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00
                            color: "#e3e5e2"
                        }
                        GradientStop {
                            position: 0.50
                            color: "#efe0e3"
                        }
                        GradientStop {
                            position: 1.00
                            color: "#e3e5e2"
                        }
                    }
                    border.width: 0
                    border.color: "#e0d6de"

                    // 进度条已完成部分
                    Rectangle {
            ///
            //radius: 40
                        id: readyBg2
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: timeHandle2.x + timeHandle2.implicitWidth / 2
                        height: parent.height
                        LinearGradient {
                            anchors.fill: parent
                            start: Qt.point(parent.x, parent.y)
                            end: Qt.point(parent.x + parent.width, parent.y)
                            gradient: Gradient {
                                GradientStop {
                                    position: 0
                                    color: "#808080"
                                }
                                GradientStop {
                                    //position: readyBg.width / timeSlider.width
                                    color: "#8594a8"
                                }
                            }
                        }
                    }
                }

                // 按钮阴影
                Glow {
                    id: effect2
                    anchors.fill: timeHandle2
                    source: timeHandle2
                    radius: 5
                    spread: 0.2
                    color: "#bbbbbb"
                    //samples: 11
                }

                // 进度条按钮
                handle: Rectangle {
                    id: timeHandle2
                    x: parent.visualPosition * (parent.width - implicitWidth)
                    anchors.verticalCenter: parent.verticalCenter
                    implicitWidth: 14
                    implicitHeight: 14
                    radius: 7
                    color: parent.pressed ? "#e0e0e0" : "#ffffff"
                    border.width: 1
                    border.color: "#d0bfcc"
                }




            }




            Button{
                anchors.verticalCenter: parent.verticalCenter
                id:order
                visible: true
                width: 28
                height: 28
                background: Rectangle{
                    color: order.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 28
                        height: 28
                        source: "qrc:/icon/icon6.png"
                    }
                }
                onClicked: {
                    order.visible=false
                    circulate.visible=true
                    random.visible=false
                }
            }





            Button{
                anchors.verticalCenter: parent.verticalCenter
                id:circulate
                visible: false
                width: 28
                height: 28

                background: Rectangle{
                    color: circulate.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 28
                        height: 28
                        source: "qrc:/icon/icon1.png"
                    }
                }
                onClicked: {
                    order.visible=false
                    circulate.visible=false
                    random.visible=true
                }
            }






            Button{
                anchors.verticalCenter: parent.verticalCenter
                id:random
                visible: false
                width: 28
                height: 28
                background: Rectangle{
                    color: random.hovered?"#B0C4DE":"white"
                    anchors.fill: parent
                    Image {
                        anchors.fill: parent
                        width: 28
                        height: 28
                        source: "qrc:/icon/suijibofang.png"
                    }
                }
                onClicked: {
                    order.visible=true
                    circulate.visible=false
                    random.visible=false
                }
            }







            Button{
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 32
                text:"词"
                onClicked: {
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

            //flags: Qt.FramelessWindowHint
            //color: Qt.rgba(0,0,0,0)

            Text{
                id: mt
                width: 300
                height: 50

                anchors.top: parent.top
                anchors.left: parent.left
                visible: true
                color: "green"
                //text:"曾经年少爱追梦，一心只想往前飞。"
                text:musiclrc.lrclistModel.get(musiclrc.lrcListView.currentIndex).lrc
                font.pixelSize: 28
             }

            Text{
                id: mt2
                width: 300
                height: 50
                anchors.top:mt.bottom
                anchors.right: parent.right
                visible: true
                color: "black"
                //text:"曾经年少爱追梦，一心只想往前飞。"
                text:musiclrc.lrclistModel.get(musiclrc.lrcListView.currentIndex+1).lrc
                font.pixelSize: 28
             }
        }


}

