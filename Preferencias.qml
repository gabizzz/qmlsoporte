import QtQuick 2.0
import Extensions 1.0
import "misfunciones.js" as FuncPpal

Ventana {
    id: ventanaEdPref
    width: 320; height: 300
    tituloCabecera: "Preferencias"
    onClicked: {ventanaEdPref.destroy()}

    SQLiteModel {id: modelSettings }

    function guardar()
    {
        FuncPpal.baseQueryUpdateSettings(textMPBAusuario.text,textMPBApass.text);
    }


    CampoTexto{
        id: textMPBAusuario
        y: 58
        placeholderText: qsTr("MPBA Usuario")
        text:miMPBAUser
        anchors.rightMargin: 8
        anchors.bottomMargin: 214
        anchors.leftMargin: 8
        onAccepted:  {
            guardar();
        }
    }

    CampoTexto{
        id: textMPBApass
        y: 108
        placeholderText: qsTr("MPBA Password")
        text:miMPBAPass
        anchors.rightMargin: 8
        anchors.bottomMargin: 164
        anchors.leftMargin: 8
        echoMode: TextInput.PasswordEchoOnEdit
        onAccepted:  {
            guardar();
        }
    }

    Boton {
        id: botonGuardar
        x: 287; y: 323
        onClicked: {guardar()}
    }

}

