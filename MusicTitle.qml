import QtQuick

Item {



    Text{
        id:title
        width: 20
        height: 30
        text:myMediaPlayer.title+"    "+myMediaPlayer.author
    }

    Text{
        id:author
        width: 20
        height: 30
        anchors.top:title.bottom
        //text:myMediaPlayer.author
    }

    Timer {
        id: timer2
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            console.log(myMediaPlayer.title)
            console.log(myMediaPlayer.author)
            console.log("22222")
            timer2.stop()
        }
    }

    function timerStart()
    {
        timer2.start()
    }

}
