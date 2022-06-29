import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
Item {

    property alias cover: cover
    property alias titleInput:titleInput
    property alias artistInput:artistInput
    property alias albumInput:albumInput
    property alias trackInput:trackInput
    property alias yearInput:yearInput
    property alias generInput:generInput
    property alias annotationInput:annotationInput


  Rectangle{

    id:rec1
    width: parent.width*0.5
    height: parent.height

    border.color: "black"
    border.width: 1
    Column{
    Item{
        width: rec1.width
        height: 50
    Text {
        text: qsTr("专辑封面")
        anchors.centerIn: parent
        font.pixelSize:20
     }}
    Item{
        width: rec1.width
        height: rec1.height-50
        Image {
            id:cover
            //source: "file:///tmp/cover.jpg"
            anchors.centerIn: parent
            width:parent.width*0.85
            height: parent.height*0.85
        }
    }
  }
 }
   Rectangle{
       border.color: "black"
       border.width: 1
       id:rec2
       anchors.right:parent.right
       width: parent.width*0.4
       height: parent.height
       Column{
           Item{
               //.color: "black"
               //border.width: 1
               width: rec2.width
               height: 50
               Text {
                   anchors.centerIn: parent
                   text: qsTr("音频信息")
                   font.pixelSize:20
               }
           }

       Column{

           Item{
               width: parent.width
               height: 50
               Text {
                   id:title
                   text: qsTr("标   题: ")
               }
               TextField{
                   id: titleInput
                   anchors.left: title.right
                   Layout.fillWidth: true
                   focus: true
               }
           }







           Row{
               Text {
                   id:artist
                   text: qsTr("艺术家:")
               }
               TextField{
                   id: artistInput
                   Layout.fillWidth: true

               }
           }
           Row{
               Text {
                   id:album
                   text: qsTr("唱片集:")
               }
               TextField{
                   id: albumInput
                   Layout.fillWidth: true
               }
           }
           RowLayout{
               Layout.fillWidth: true
               RowLayout{
                   Layout.fillWidth: true
                   RowLayout{
                       Layout.fillWidth: true
                       Text {
                           id:track
                           text: qsTr("音轨号:")
                       }
                       TextField{
                           id: trackInput
                           Layout.fillWidth: true
                           validator: RegularExpressionValidator{regularExpression: /[0-9]+/}
                       }
                   }
                   RowLayout{
                       Layout.fillWidth: true
                       Text {
                           id:year
                           text: qsTr("日 期:")
                       }
                       TextField{
                           id: yearInput
                           Layout.fillWidth: true
                           validator: RegularExpressionValidator{regularExpression: /[0-9]+/}
                       }
                   }
               }
           }

           Row{
               Text {
                   id: gener
                   text: qsTr("流 派：")
               }
               TextField{
                   id:generInput
                   Layout.fillWidth: true

               }
           }
           Row{
               Text {
                   id: annotation
                   text: qsTr("注 释：")
               }
               TextField{
                   id: annotationInput
                   Layout.fillWidth: true
               }
           }

       }

    }
      }

  }

