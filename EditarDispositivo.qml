import QtQuick 2.0
import Extensions 1.0
import ResolverIPName 1.0
import "misfunciones.js" as FuncPpal

Ventana {
    id: ventanaEdDisp
    width: 300; height: 557
    tituloCabecera: "Dispositivo"

    property var miHostname
    property var miIpAddr
    property var miUserName
    property var miidEquipo
    property string miRedname

    ResolveIpName{id:funcIPName;}

    SQLiteModel {id: modelEdEquipo}

    SQLiteModel {id: modelVinGrupo}

    function guardar(){
        FuncPpal.baseQuerySaveEdEq(textHostname.text,textUserName.text,textIpAddr.text,miidEquipo,textIDRed.text);
    }

    BotonCerrar {
        onClicked: {
            ventanaEdDisp.destroy()
            FuncPpal.baseQueryPPal(textHostname.text)
        }
    }

    CampoTexto{
        id:textHostname
        y: 54
        anchors.rightMargin: 13
        anchors.bottomMargin: 473
        anchors.leftMargin: 13
        placeholderText: qsTr("Host Name")
        text: miHostname
        onAccepted: {
            guardar()
        }
        onDisplayTextChanged: {
           FuncPpal.mensajeEstadoEdEq("Modificado")
        }
    }

    CampoTexto{
        id:textIpAddr
        y: 95
        anchors.rightMargin: 13
        anchors.bottomMargin: 432
        anchors.leftMargin: 13
        placeholderText: qsTr("IP Address")
        text: miIpAddr
        onAccepted: {
            guardar()
        }
        onDisplayTextChanged: {
           FuncPpal.mensajeEstadoEdEq("Modificado")
           FuncPpal.funcionAsociaRed(textIpAddr.text)
        }
    }

    CampoTexto{
        id:textUserName
        y: 137
        anchors.rightMargin: 13
        anchors.bottomMargin: 390
        anchors.leftMargin: 13
        placeholderText: qsTr("Identificador")
        text: miUserName
        onAccepted: {
            guardar()
        }
        onDisplayTextChanged: {
           FuncPpal.mensajeEstadoEdEq("Modificado")
        }
    }

    Image {
        id: imageResuelveIP
        x: 264
        y: 101
        z: 6
        source: "green.png"

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            onClicked: {
                textIpAddr.text=funcIPName.resolverIPporNombre(textHostname.text)
            }
        }
    }

    Image {
        id: imageResuelveHostName
        x: 262
        y: 59
        z: 5
        source: "green.png"

        MouseArea {
            id: mouseArea2
            anchors.fill: parent
            onClicked: {
                textHostname.text=funcIPName.resolverNombreporIP(textIpAddr.text)
            }
        }
    }

    Text {
        id: textIDRed
        x: 14; y: 485
        width: 32
        height: 15
        font.pixelSize: 12;color:"#00000000"
    }

    Text {
        id: textNombreRed
        x: 13; y: 176
        width: 274; height: 46
        color:"#FFA000"; horizontalAlignment: Text.AlignHCenter; styleColor: "#323544"; wrapMode: Text.WordWrap;font.pixelSize: 12;
    }

    Text {
        id: textIPRed
        x: 14; y: 228
        width: 273; height: 23
        color:"#FFA000"; horizontalAlignment: Text.AlignHCenter;font.pixelSize: 12
    }

    Text {
        id: textEstado
        y: 527
        height: 15
        color: "#e88c1c"
        text: qsTr("...")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 3
        anchors.left: parent.left
        anchors.leftMargin: 4
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Etiquetas{
        y: 257
        height: 202
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 101
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.right: parent.right
        anchors.rightMargin: 13
        idEquipo: miidEquipo
    }



    Boton {
        id: botonGuardar
        x: 287
        y: 323
        onClicked: {guardar()}
    }

    Component.onCompleted: {
         FuncPpal.funcionAsociaRed(textIpAddr.text)
    }

}
