import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    id:root
    width: 320
    height: 300
    color: "#151518"
    radius: 6
    border.width: 2
    border.color: "#607D8B"


    MouseArea{ //drag window
        anchors.fill: parent
        drag.target: parent
        drag.axis: Drag.XandYAxis
    }
}

