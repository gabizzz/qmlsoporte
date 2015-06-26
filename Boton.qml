import QtQuick 2.0

Rectangle {
    id: recBotonGuardar
    width: 100
    height: 30
    color: "#428BCA"
    border.color: "#357EBD"
    border.width: 1
    radius: 3
    anchors.left: parent.left
    anchors.leftMargin: 111
    anchors.right: parent.right
    anchors.rightMargin: 109
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 50
    signal clicked


    Text {
        id: textGuardar
        x: 56
        y: 14
        color: "#ffffff"
        text: qsTr("Guardar")
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 14
    }

    MouseArea {
        id: mouseAreaGuardar
        anchors.fill: parent
        onClicked: {recBotonGuardar.clicked()}
    }
}
