import QtQuick 2.0
import Extensions 1.0
import "misfunciones.js" as FuncPpal

Ventana {
    id: ventanaEdAcc
    width: 320
    height: 300
    tituloCabecera: "Accion"

    property alias textAccName: textAccName
    property alias textAccProgram: textAccProgram
    property alias textAccParam: textAccParam
    property alias idAcc: idAcc

    function guardar()
    {
        FuncPpal.baseQuerySaveEdAcc(textAccName.text,textAccProgram.text,textAccParam.text,idAcc.text);
    }

    Text {
        id: idAcc
        visible: false
    }

    SQLiteModel { id: modelEdAccion }

    CampoTexto {
        id: textAccName
        x: 303
        y: 54
        anchors.rightMargin: 24
        anchors.bottomMargin: 216
        anchors.leftMargin: 24
        placeholderText: qsTr("Acc Name")
        onAccepted: {
            guardar()
        }
    }

    CampoTexto {
        id: textAccProgram
        x: 303
        y: 98
        anchors.rightMargin: 24
        anchors.bottomMargin: 172
        anchors.leftMargin: 24
        placeholderText: qsTr("Program")
        onAccepted: {
            guardar()
        }
    }

    CampoTexto {
        id: textAccParam
        x: 303
        y: 141
        anchors.rightMargin: 24
        anchors.bottomMargin: 129
        anchors.leftMargin: 24
        placeholderText: qsTr("Parametros")
        onAccepted: {
            guardar()
        }
    }

    onClicked: {ventanaEdAcc.visible=false}

    Boton {
        id: botonGuardar
        x: 287
        y: 323
        onClicked: {guardar()}
    }
}

