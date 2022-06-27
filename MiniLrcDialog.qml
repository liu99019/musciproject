import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window{
    id:root
    width: 700
    height: 200
    visible: false
    flags: Qt.FramelessWindowHint
    //color: Qt.rgba(0,0,0,0)

    property alias musicStart: musicStart
    property alias musicPause:musicPause
    property alias miniText: miniText

    ColumnLayout{
        anchors.fill: parent
        RowLayout {
            anchors.top: parent.top
            id: toolRec
            height: 30
            visible: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            ToolButton {
                id:musicPrevious
                icon.source: "qrc:/icon/changge.png"
                onClicked: {

                }
            }
            ToolButton{
                id:musicStart
                //icon.source:"qrc:/image/play.png"
                visible: true
                onClicked: {
                }
            }
            ToolButton{
                id:musicPause
                visible: true
                //icon.source:"qrc:/image/pause.png"
                onClicked: {
                }
            }

            ToolButton {
                id:musicNext
               //icon.source:"qrc:/image/下一曲.png"
                onClicked: {
                    actions.nextAction.triggered()
                }
            }
            ToolButton {
                id:musicFastfowardfivescd
               // icon.source:"qrc:/image/快退.png"
                onClicked: {
                    actions.backfiveScdAction.triggered()
                }
            }
            ToolButton {
                id:musicBackfivescd
                //icon.source:"qrc:/image/快进.png"
                onClicked: {
                    actions.fastforwardfiveScdAction.triggered()
                }
            }
            ToolButton {
               // icon.source:"qrc:/image/close.png"
                onClicked: {
                    close()
                    content.musicPlayer.wordBackground.color = "transparent"
                    content.musicPlayer.wordFlag=false
                }
            }
        }
        Text {
            id: miniText
            Layout.fillHeight: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            opacity: 1
            color: "red"
            font.pixelSize:30
            text: musiclrc.lrclistModel.get(musiclrc.lrcListView.currentIndex).lrc
            MouseArea{
                anchors.fill: parent
                property point clickPos: "0,0"
                onPressed: {
                    clickPos = Qt.point(mouse.x, mouse.y)
                }
                onPositionChanged: {
                    var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                    root.x = root.x+delta.x
                    root.y = root.y+delta.y
                }
            }
        }
    }
}
