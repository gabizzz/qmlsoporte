import QtQuick 2.0
import Extensions 1.0
import "misfunciones.js" as FuncPpal

Rectangle {
    id:root
    width: 300
    height: 250
    color: "#110e0e"

    property var idEquipo

    Component.onCompleted: {
        FuncPpal.funcionTraeEtiquetas()
        FuncPpal.funcionTraeRelaciones(idEquipo)
    }
    SQLiteModel { id: modelEtiquetas }
    SQLiteModel { id: modelRelaciones }

    Component {
              id: highlightBar
              Rectangle { width: listViewEtiquetas.width; height: 40; color: "black" }
          }

    Component {
              id: highlightBarRela
              Rectangle { width: listViewRelacion.width; height: 40; color: "black" }
          }


    ListView {
        id: listViewEtiquetas
        x: 150; width: 143;        anchors.top: parent.top
        anchors.topMargin: 37
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 46
        anchors.right: parent.right
        anchors.rightMargin: 7
        highlight: highlightBar; highlightMoveDuration :0
        model: modelEtiquetas
        delegate: Item {
            width: parent.width; height: 20
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    listViewEtiquetas.currentIndex = index;
                    FuncPpal.funcionInsertaRela(idEquipo,id)
                    FuncPpal.funcionTraeRelaciones(idEquipo)
               }
            }
            Rectangle{
                color: "#b3a60241";height: 1;width: parent.width
                Text {text: descripcion; color: "white"}
            }
        }
    }

    ListView {
        id: listViewRelacion
        anchors.top: parent.top
        anchors.topMargin: 37
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 46
        anchors.right: parent.right
        anchors.rightMargin: 156
        anchors.left: parent.left
        anchors.leftMargin: 1
        highlight: highlightBar; highlightMoveDuration :0
        model: modelRelaciones
        delegate: Item {
            x: 5; width: parent.width; height: 20
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    listViewRelacion.currentIndex = index;
                    FuncPpal.funcionEliminaRela(idRela,idEquipo)
                }
            }
            Rectangle{
                color: "#b3a60241";height: 1;width: parent.width
                Text {text: descripcion; color: "white"}
            }
        }
    }

    Rectangle {
        id: footer
        y: 221
        height: 29
        color: "#b3000000"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

    Rectangle {
        id: header
        height: 29
        color: "#b3000000"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        Text {
            id: labels
            x: 124
            y: 8
            color: "#6d6464"
            text: qsTr("Etiquetas")
            font.bold: false
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
    }
}

