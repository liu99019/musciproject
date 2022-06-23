import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Universal
import QtQuick.Layouts
ApplicationWindow {

    property alias myMediaPlayer:myMediaPlayer
    property alias stackLaout: stackLayout
    id: window
    visible: true
    width: 990
    height: 620
    title: qsTr("聆听音乐播放器")

    //flags: Qt.FramelessWindowHint| Qt.Window

    Universal.theme: Universal.Light
    Universal.accent: Universal.Orange


    header: ToolBar {

        // ...
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text:"\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {              
                    drawer.open()                
            }
        }

        Label {
            text: "lingT"
            anchors.centerIn: parent
        }
        Button {
            id: exit
            height: parent.height
            width: 60
            anchors.top: parent.top
            anchors.right: parent.right
            //icon.source: "file:///run/media/root/study/University22/icon_emoji/shanchu.png"
            icon.color: "white"

            onClicked: {
                window.close()
            }
        }
    }


    Drawer {
        // ...
        id: drawer
        width: window.width * 0.2
        height: window.height*0.9
        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("musiclrc")
                width: parent.width
                onClicked: {
                    stackLaout.currentIndex=0
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr("songsearch")
                width: parent.width
                onClicked: {
                    stackLaout.currentIndex=1
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr("recentplaylist")
                width: parent.width
                onClicked: {
                    stackLaout.currentIndex=2
                    drawer.close()
                }
            }

        }

    }

    StackLayout {
        id: stackLayout
        width: window.width
        height: window.height*0.8
        currentIndex: 0

        MusicLrc{
            id:musiclrc
        }

        SongSearch{
            id:songsearch
        }

        RecentSong{
            id:recent
        }
    }
    Item {
        width: parent.width
        height: parent.height*0.105
        anchors.bottom: parent.bottom
        ButtonItem{
            id:buttonItem
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MyMediaPlayer{
        id:myMediaPlayer
        signal sendsongChange();
        Component.onCompleted: {
           myMediaPlayer.sendsongChange.connect(recent.onSendSongsignal);
        }
    }
}
