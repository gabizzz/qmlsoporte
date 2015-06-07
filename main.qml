import QtQuick 2.3
import QtQuick.Window 2.2
import Extensions 1.0
import ResolverIPName 1.0
import "misfunciones.js" as FuncPpal


Window {
    id: window1
    visible: true
    width: 600; height: 700
    color: "#151518"
    title: "Rocket Support v0.6"

    function funcionAccionPPal(argHost,argIP,id,argidred) //llama a ventana lista de acciones si resuelve IP
    {
        var ipantes=argIP;
        var idRedtmp;
        var ipdespues=funcIPName.resolverIPporNombre(argHost);
        if(ipdespues==="no ip address")
        {
            textMensajes.text="Equipo Inaccesible"
            rectangleMensajes.visible=true
            //createAnimation.start()
            //return
        }

        var ipfinal;
        if (ipantes!==ipdespues)
        {
            ipfinal=ipdespues;//resuelvo ip por hostname
        }else{
            ipfinal=ipantes;//resuelvo ip por hostname
        }
        idRedtmp=FuncPpal.funcionGetIDRed(ipfinal);
        if (idRedtmp!==argidred) //si son distintos los id de red actualiza
        {
            FuncPpal.baseQueryUpdatePPal(ipfinal,id,idRedtmp)
        }
        if(ipdespues!=="no ip address")
        {
            FuncPpal.createObjectsAcc(ipfinal) //llama a ventana de acciones
        }
    }


    SQLiteModel {id: model }
    SQLiteModel {id: modeloEtiquetas}

    Component.onCompleted: { FuncPpal.baseQueryPPal(textInputBuscar.text) }

    SQLiteModel{ id: queryGetIDRed }

    ResolveIpName{id:funcIPName }

    Component {
              id: highlightBar
              Rectangle { width: listView.width; height: 60; color: "#272935" }
          }

    Component {
            id: listDelegate
            Item {
                width: listView.width; height: 60
            MouseArea{
                anchors.fill: parent
                onClicked: { listView.currentIndex = index}
                onDoubleClicked: { funcionAccionPPal(name,ipaddr,id,idRed)}
            }
            Rectangle{
                color: "#b3a60241";height: 1;width: listView.width
                Row {
                    spacing: 4
                    Column {
                        width: 350
                        Text { text: 'IP Address: ' + ipaddr;color:"#FFA000" }
                        Text { text: 'Hostname: ' + name ;color:"#DA4939" }
                        Text { text: 'Identificador: ' + userid ;color:"#a0a0a0"}
                       }

                         Image {
                            id: itemBtn; anchors.verticalCenter: parent.verticalCenter;source: "red.png"
                            MouseArea {
                                 anchors.fill: parent;
                                 onEntered: {itemBtn.source="grey.png"; }
                                 onExited: { itemBtn.source="red.png";}
                                 onCanceled: {itemBtn.source="red.png";}
                                 onClicked:{
                                      listView.currentIndex = index;
                                      funcionAccionPPal(name,ipaddr,id,idRed)//paso hostname
                                 }
                               }
                           }
                         Image {
                            id: itemBtnEditar; anchors.verticalCenter: parent.verticalCenter; source: "yellow.png"
                            MouseArea {
                                 anchors.fill: parent;
                                 onEntered: {itemBtnEditar.source="red.png";}
                                 onExited: {itemBtnEditar.source="yellow.png"; }
                                 onCanceled: { itemBtnEditar.source="yellow.png";}
                                 onClicked:{
                                      listView.currentIndex = index;
                                      FuncPpal.createObjectsEdicion(name,ipaddr,userid,id);
                                 }
                               }
                           }

                         Image {
                            id: itemBtnEliminar; anchors.verticalCenter: parent.verticalCenter; source: "delete.png"
                            MouseArea {
                                 anchors.fill: parent;
                                 onEntered: { itemBtnEliminar.source="red.png"; }
                                 onExited: { itemBtnEliminar.source="delete.png"; }
                                 onCanceled: { itemBtnEliminar.source="delete.png";}
                                 onClicked:{ listView.currentIndex = index; FuncPpal.funcionEliminarPPal(id) }
                               }
                           }
                         Text { anchors.verticalCenter: parent.verticalCenter;text: lastdate;color:"#FFA000";fontSizeMode: Text.Fit; minimumPixelSize: 6; font.pixelSize: 10}
                         //----------etiquetas: tipo Repositorio
                                Repeater {
                                    model: FuncPpal.divideEtiqueta(id) //aca tiene que devolver catidad de etiquetas por item
                                    Rectangle {
                                        anchors.verticalCenter: parent.verticalCenter;
                                        color: "#b3a60241"
                                        width: texetiq.width+5; height: texetiq.height+5
                                        Text {id:texetiq; color:"#F8BBD0";text: FuncPpal.laetiqueta(index,id).toUpperCase();fontSizeMode: Text.Fit; minimumPixelSize: 8; font.pixelSize: 12;anchors.centerIn: parent }
                                    }
                                }
                         //------------------
                }
            }

            }
        }



Rectangle {
    id: rectangleFondoBusqueda
    x: 5; y: 314; height: 46; color: "#b3000000"; anchors.bottom: parent.bottom; anchors.bottomMargin: 0; z: 1
    anchors.left: parent.left; anchors.leftMargin: 0; anchors.right: parent.right; anchors.rightMargin: 0

    CampoTexto{
        id: textInputBuscar
        placeholderText: qsTr("Buscar...")
        onAccepted:  {
            rectangleMensajes.visible=false
            FuncPpal.baseQueryPPal(textInputBuscar.text)
        }
    }

    Text {
        id: text1; x: 432; y: 16
        width: 60; height: 15
        color: "#7d7474"; text: miOS
        horizontalAlignment: Text.AlignRight; anchors.right: parent.right; anchors.rightMargin: 8; font.pixelSize: 12
    }

    Image {
        id: imageSetting
        x: 8; y: 14
        source: "yellow.png"
        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            onClicked: {
                FuncPpal.createObjectsSetting();
            }
        }
    }

    Image {
        id: imageNUsuario
        y: 14
        anchors.left: imageSetting.right; anchors.leftMargin: 6
        anchors.bottom: parent.bottom; anchors.bottomMargin: 14
        source: "grey.png"
        MouseArea {
            id: mouseArea2
            anchors.fill: parent
            onClicked: {
                FuncPpal.createObjectsEdicion("","","","")
            }
        }
    }

    Image {
        id: imageRedes
        x: 60; y: 14; source: "green.png"
        MouseArea {
            id: mouseAreaRedes
            anchors.fill: parent
            onClicked: {
                FuncPpal.createObjectsGrupos();
            }
        }
    }
}

    ListView {
        id: listView
        anchors.bottomMargin: 47; anchors.topMargin: 38
        anchors.fill: parent; delegate: listDelegate
        highlight: highlightBar; highlightMoveDuration :0
        section {
            property:"nombre"
            criteria: ViewSection.FullString
            delegate: Rectangle{
                width: window1.width; height: textoSection.height+10
                color:"#33495f"
                Text {
                    id:textoSection
                    font.pointSize: 10; font.bold: true; color: "#B2DFDB"
                    text: section.toUpperCase();
                    width: parent.width; wrapMode: Text.WordWrap
                    anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 10
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        FuncPpal.createObjectsGrupos()
                    }
                }
            }
        }
    }


Rectangle {
    id: rectangleMensajes
    x: 292
    y: 479
    width: 200
    height: 57
    color: "#000000"
    radius: 5
    visible: false
    anchors.bottom: rectangleFondoBusqueda.top
    anchors.bottomMargin: 18
    anchors.right: parent.right
    anchors.rightMargin: 8
    border.width: 1


    transitions: Transition {
        NumberAnimation { properties: "opacity"; from: 0; to: 1;duration: 1000 }
        NumberAnimation { properties: "opacity"; from: 1; to: 0;duration: 1000 }
    }

    Text {
        id: textMensajes
        color: "#f0bd0b"
        text: qsTr("")
        visible: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: 16
    }

    Image {
        id: image2
        x: 180
        y: 4
        visible: true
        source: "delete.png"

        MouseArea {
            id: mouseArea3
            anchors.fill: parent
            onClicked: {
                //destroyAnimation.start()
                rectangleMensajes.visible=false
            }
        }
    }
}

    Rectangle {
        id: rectangleHeader
        height: 33
        color: "#b3000000"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Image {
            id: image1
            x: 405
            width: 80
            height: 80
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "logo.png"
        }

        Text {
            id: textHeader
            x: 293
            width: 105
            height: 15
            color: "#837878"
            text: qsTr("RocketSupport")
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.right: image1.left
            anchors.rightMargin: 6
            anchors.top: parent.top
            anchors.topMargin: 10
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }
    }
}
