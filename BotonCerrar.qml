import QtQuick 2.0

Rectangle {
    id: rectangleCerrar
    x:6; y:6
    width: 27
    height: 27
    color: "#b3000000"
    radius: 14
    border.color: "#dd4814"
    border.width: 2

    signal clicked
    property alias textX: textX.text

    Text {
        id: textX
        color: "#a4a4a4"
        text: qsTr("X")
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    MouseArea {
        id: mouseAreaCerrar
        anchors.fill: parent
        onClicked: {rectangleCerrar.clicked()}
    }
}
