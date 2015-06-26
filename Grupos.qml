import QtQuick 2.0
import Extensions 1.0
import com.components.processes 1.0
import "misfunciones.js" as FuncPpal


Rectangle {
    id:root
    width: 320
    height: 500
    color: "#151518"
    radius: 6
    border.width: 2
    border.color: "#607D8B"

    function nuevoGrupo()
    {
        ventanaEdGrupo.miHostnameRed="";
        ventanaEdGrupo.miIpAddrRed="";
        ventanaEdGrupo.miidGrupo="";
        ventanaEdGrupo.miObservaciones="";
        ventanaEdGrupo.miurl="";
        ventanaEdGrupo.visible=true;
    }


    MouseArea{ anchors.fill: parent; drag.target: parent;  drag.axis: Drag.XandYAxis }

    SQLiteModel { id: modelRedes }
    SQLiteModel { id: modeloGetValueGrupo }

    Component.onCompleted: { FuncPpal.baseQueryListaGrupos(); }

    Process{
        id: process
        onError: resultLabel.text = "<font color='red'>" + qsTr("Error") + "</font>"
        onReadyRead: resultLabel.text = process.readAllStandardOutput()
    }

    ListView {
        id: listViewRedes
        clip: true
        anchors.bottomMargin: 56; anchors.topMargin: 50; anchors.fill: parent; anchors.margins: 5
        delegate: listRedesDelegate; focus: true
    }

    Component {
            id: listRedesDelegate
            Item {
            width: listViewRedes.width; height: 40; id:itemAcc
            Rectangle{
                color: "#b3a60241";height: 1;width: 262
            Row{
                spacing: 2
                Column{
                    width: 260
                    Text {id:textAcc;text: nombre;color:"#FFC107";width: 260;height: 20;wrapMode: Text.WordWrap;fontSizeMode: Text.Fit; minimumPixelSize: 6; font.pixelSize: 10 }
                    Text {text: direccionip;color:"#C5CAE9";fontSizeMode: Text.Fit; minimumPixelSize: 6; font.pixelSize: 10 }
                }
                Image{
                       id: itemBtnEdRedes
                       anchors.verticalCenter: parent.verticalCenter; source: "yellow.png"

                       MouseArea {
                           anchors.fill: parent;
                           onEntered: {
                               itemBtnEdRedes.source= "red.png"
                           }
                           onExited: {
                               itemBtnEdRedes.source= "yellow.png"
                           }
                           onCanceled: {
                               itemBtnEdRedes.source= "yellow.png"
                           }
                           onClicked:{
                               ventanaEdGrupo.miHostnameRed=nombre;
                               ventanaEdGrupo.miIpAddrRed=direccionip;
                               ventanaEdGrupo.miidGrupo=id;
                               ventanaEdGrupo.miObservaciones=FuncPpal.funcionGetObsGrupo(id)
                               ventanaEdGrupo.miurl=FuncPpal.funcionGetUrlGrupo(id)
                               ventanaEdGrupo.visible=true;
                           }
                       }
                }
                Text {text: canteq;anchors.verticalCenter: parent.verticalCenter;color:"white";fontSizeMode: Text.Fit; minimumPixelSize: 8; font.pixelSize: 12 }
            }
            }
            }
    }


    Rectangle {
        id: rectangleFondoCerrar
        y: 368
        height: 33
        color: "#b3000000"
        radius: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5

        Image {
            id: imageNGrupo
            x: 8
            y: 8
            source: "grey.png"

            MouseArea {
                id: mouseAreaNGrupo
                anchors.fill: parent
                onClicked: {nuevoGrupo()}
            }
        }
    }

    Rectangle {
        id: rectangleFondoHeader
        width: 320
        height: 33
        color: "#b3000000"
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 8

        Text {
            id: textheader
            color: "#FFFFFF"
            text: "Grupos"
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 16
        }

        BotonCerrar {
            onClicked: {root.destroy()}
        }
    }

    EditarGrupos{
        id:ventanaEdGrupo
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onVisibleChanged: {
            FuncPpal.baseQueryListaGrupos();
        }
    }
    CampoTexto{
        id: textInputBuscar
        y: 464
        anchors.leftMargin: 92
        placeholderText: qsTr("Buscar...")
        onAccepted:  {
            FuncPpal.baseQueryArgGrupos(textInputBuscar.text)
        }
    }
}

