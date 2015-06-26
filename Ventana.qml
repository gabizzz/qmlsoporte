import QtQuick 2.0

Rectangle {
        id:root
        width: 300
        height: 300
        color: "#151518"
        radius: 2
        border.width: 2
        border.color: "#607D8B"

        property alias tituloCabecera: textTitulo.text

        MouseArea{ //drag window
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XandYAxis
        }

        Rectangle {
            id: rectCabecera
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
                id: textTitulo
                color: "#FFFFFF"
                text: "Titulo Ventana"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
            }
        }

        Rectangle {
            id: rectPie
            height: 30
            color: "#b3000000"
            radius: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
        }
}

