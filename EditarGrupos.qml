import QtQuick 2.0
import QtQuick.Controls 1.2
import Extensions 1.0
import ResolverIPName 1.0
import "misfunciones.js" as FuncPpal
import QtWebKit 3.0

Rectangle {
    id: ventanaEdGrp
    width: 455
    height: 441
    color: "#151518"
    radius: 2
    border.width: 2
    border.color: "#607D8B"

    property string miHostnameRed
    property string miIpAddrRed
    property string miidGrupo
    property string miObservaciones
    property string miurl

    ResolveIpName{id:funcIPName; }

    SQLiteModel { id: modelEdRed }

    function guardar(){
        FuncPpal.baseQuerySaveEdGrupo(textHostnameRed.text,textIpAddrRed.text,textObservaciones.text,miidGrupo);
    }

    MouseArea{ //drag window
        anchors.fill: parent
        drag.target: parent
        drag.axis: Drag.XandYAxis
    }

    BotonCerrar {
        onClicked: {ventanaEdGrp.visible=false}
    }

    Text {
        id: textEstado
        x: 8
        y: 412
        width: 439
        height: 15
        color: "#a69723"
        text: qsTr("")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Text {
        id: texturl
        x: 14; y: 313
        width: 427; height: 22
        color: "steelblue"
        text: "<html><a href='"+miurl+"'>Ver Mapa</a></html>"
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        font.pixelSize: 15
        MouseArea{
            anchors.fill: parent
            onClicked: {Qt.openUrlExternally(miurl)}
        }
    }

    CampoTexto {
        id: textHostnameRed
        x: 303
        y: 53
        anchors.rightMargin: 14
        anchors.bottomMargin: 358
        anchors.leftMargin: 14
        placeholderText: qsTr("Identificador")
        text:miHostnameRed
        horizontalAlignment: Text.AlignLeft
        onAccepted: {
            guardar()
        }
        onDisplayTextChanged: {
            FuncPpal.mensajeEstadoGrupo("Modificado")
        }
    }

    CampoTexto {
        id: textIpAddrRed
        x: 303
        y: 100
        anchors.rightMargin: 14
        anchors.bottomMargin: 311
        anchors.leftMargin: 14
        placeholderText: qsTr("IP Address")
        text:miIpAddrRed
        onAccepted: {
            guardar()
        }
        onDisplayTextChanged: {
            FuncPpal.mensajeEstadoGrupo("Modificado")
        }
    }

    TextArea {
        id: textObservaciones
        y: 144; z:4; height: 163
        anchors.right: parent.right; anchors.rightMargin: 14
        anchors.left: parent.left; anchors.leftMargin: 13
        font.bold: false
        text: miObservaciones
        focus: true
        activeFocusOnPress: true
        horizontalAlignment: Text.AlignJustify
        font.pixelSize: 10
        onTextChanged: {
            FuncPpal.mensajeEstadoGrupo("Modificado")
        }        
    }

    Boton {
        id: botonGuardar
        x: 287
        y: 323
        onClicked:  {
            guardar()
           console.log("boton guardar")
        }
    }
}

