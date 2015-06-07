import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

TextField {
    id: campoText
    y: 0
    height: 28
    anchors.right: parent.right
    anchors.rightMargin: 92
    anchors.left: parent.left
    anchors.leftMargin: 111
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 8
    font.bold: false
    focus: true
    activeFocusOnPress: true
    horizontalAlignment: Text.AlignHCenter
    font.pixelSize: 15

    style: TextFieldStyle {
        textColor: "black"
        background: Rectangle {
            radius: 5
            color: "#E3E4E6"
            implicitWidth: 100
            implicitHeight: 24
            border.color: "#333"
            border.width: 1
        }
    }
}
