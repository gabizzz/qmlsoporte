var component;

function baseQueryPPal(arg) //ventana principal
{
    model.setDatabase("equipos.sqlite");
    //model.setQuery("select * from maquinas where name like '%"+arg+"%' or userid like '%"+arg+"%'  or ipaddr like '%"+arg+"%'")
    //model.setQuery("select maquinas.name, maquinas.userid, maquinas.ipaddr,maquinas.id, maquinas.lastdate,enlaces.nombre,maquinas.idred from maquinas inner join enlaces on (enlaces.id=maquinas.idRed) where maquinas.name like '%"+arg+"%' or maquinas.userid like '%"+arg+"%'  or maquinas.ipaddr like '%"+arg+"%'   or enlaces.nombre like '%"+arg+"%' order by enlaces.nombre")
    model.setQuery("select maquinas.name, maquinas.userid, maquinas.ipaddr,maquinas.id, maquinas.lastdate,enlaces.nombre,maquinas.idred from maquinas inner join enlaces on (enlaces.id=maquinas.idRed) left join rela_maq_etiq on (rela_maq_etiq.idmaq=maquinas.id) left join etiquetas on (etiquetas.id = rela_maq_etiq.idetq) where maquinas.name like '%"+arg+"%' or maquinas.userid like '%"+arg+"%'  or maquinas.ipaddr like '%"+arg+"%'   or enlaces.nombre like '%"+arg+"%' or etiquetas.descripcion like '%"+arg+"%'  group by maquinas.id  order by enlaces.nombre")
    listView.model = model;
}

function baseQueryUpdatePPal(argIP,argID,argIDRed)//ip, id Actualiza equipo de la ppal si cambio IP
{
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();

    if(dd<10) {
        dd='0'+dd
    }

    if(mm<10) {
        mm='0'+mm
    }

    today = mm+'-'+dd+'-'+yyyy;

    model.setDatabase("equipos.sqlite");
    model.setQuery("UPDATE maquinas SET ipaddr='"+ argIP + "',lastdate='"+today+"', idRed='"+argIDRed+"' WHERE id='"+argID+"'")
    baseQueryPPal(textInputBuscar.text)
}

function funcionEliminarPPal(arg) //elimina equipo de la ppal
{
    model.setDatabase("equipos.sqlite");
    model.setQuery("delete from maquinas where id='"+arg+"'");
    baseQueryPPal(textInputBuscar.text)
}

//*******************EQUIPOS

function funcionGetIDRed(argIP)
{
    var str=argIP.slice(0,argIP.lastIndexOf("."));
    queryGetIDRed.setDatabase("equipos.sqlite");
    queryGetIDRed.setQuery("SELECT * FROM enlaces  where direccionip like '%"+str+"%' order by direccionip asc limit 1");
    var idRed=queryGetIDRed.get(0).id;
    if (typeof idRed === 'undefined')
    {
        idRed="12" //Grupo equipos que no responden o ip NaN
    }
    return idRed
}

function funcionAsociaRed(argIP)
{
    var str=argIP.slice(0,argIP.lastIndexOf("."));
    modelVinGrupo.setDatabase("equipos.sqlite");
    modelVinGrupo.setQuery("SELECT * FROM enlaces  where direccionip like '%"+str+"%' order by direccionip asc limit 1");
    var idRed=modelVinGrupo.get(0).id;
    if (typeof idRed === 'undefined')
    {
        idRed="12";
        createObjectsNuevoGrupo(argIP);
        //Equipo sin grupo o sin respuesta, sugiere creacion de grupo?
        //guardar automaticamente el cambio de red
    }else{
        textNombreRed.text=modelVinGrupo.get(0).nombre;
        textIPRed.text=modelVinGrupo.get(0).direccionip;
    }
        textIDRed.text=idRed;
}

function createObjectsEdicion(argHostname,argIpAddr,argUserName,argIdEq) //Creo objeto
{
    var component = Qt.createComponent("EditarDispositivo.qml");
    if (component.status === Component.Ready)
    {
        component.createObject(window1, {"x": (window1.width/2)-160, "y": 100, "miHostname": argHostname,"miIpAddr": argIpAddr, "miUserName": argUserName, "miidEquipo": argIdEq});
    }
}

function baseQuerySaveEdEq(argHostname,argUserName,argIP,argID,argIDRed) //update o insert desde ventana EditarEquipos
{
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();

    if(dd<10) {
        dd='0'+dd
    }

    if(mm<10) {
        mm='0'+mm
    }

    today = mm+'-'+dd+'-'+yyyy;

    modelEdEquipo.setDatabase("equipos.sqlite");
    if(argID==="")
    {
        modelEdEquipo.setQuery("INSERT INTO maquinas (name,userid,ipaddr,lastdate,idRed) VALUES ('" + argHostname + "', '"+ argUserName + "', '"+ argIP + "', '"+ today + "','"+ argIDRed + "')")
    }else{
        modelEdEquipo.setQuery("UPDATE maquinas SET idRed='" + argIDRed + "',name='" + argHostname + "', userid='"+ argUserName + "', ipaddr='"+ argIP + "',lastdate='"+today+"' WHERE id='"+argID+"'")
    }
    mensajeEstadoEdEq("Guardado")
}

function mensajeEstadoEdEq(arg) //mensaje ventana
{
    textEstado.text=arg
}

//************************ACCIONES
function createObjectsAcc(argHostname) //Creo objeto
{
    var component = Qt.createComponent("Acciones.qml");
    if (component.status === Component.Ready)
    {
        component.createObject(window1, {"x": (window1.width/2)-160, "y": 100, "mihostnameAcc": argHostname});
    }
}


function baseQuerySaveEdAcc(argAccname,argAccProg,argAccparam,argAccid) //update desde ventana Editar Accion
{
    modelEdAccion.setDatabase("equipos.sqlite");
    modelEdAccion.setQuery("UPDATE servicios SET nombreservicio='" + argAccname + "', ubicacion='"+ argAccProg + "', parametroprecedente='"+ argAccparam + "'  WHERE id='"+argAccid+"'")
}

function baseQueryListaAcciones() //ventana lista de acciones
{
    modelAcciones.setDatabase("equipos.sqlite");
    modelAcciones.setQuery("SELECT * FROM servicios where "+miOS+" ='true'")
    listViewVAcciones.model = modelAcciones;
}

//**********************SETTINGS
function createObjectsSetting() //Creo objeto
{
    var component = Qt.createComponent("Preferencias.qml");
    if (component.status === Component.Ready)
    {
        component.createObject(window1, {"x": (window1.width/2)-160, "y": 100});
    }
}

function baseQueryUpdateSettings(argMPBAusuario,argMPBAPass)
{
    modelSettings.setDatabase("equipos.sqlite");
    modelSettings.setQuery("UPDATE settings SET mpbauser='" + argMPBAusuario + "', mpbapass='"+ argMPBAPass + "' WHERE id='1'")
}
//*********************G R U P O S

function createObjectsGrupos() //Creo objeto
{
    var component = Qt.createComponent("Grupos.qml");
    if (component.status === Component.Ready)
    {
        component.createObject(window1, {"x": (window1.width/2)-160, "y": 100});
    }
}

function createObjectsNuevoGrupo(argIP) //Creo objeto
{
    var component = Qt.createComponent("EditarGrupos.qml");
    if (component.status === Component.Ready)
    {
        component.createObject(window1, {"x": (window1.width/2)-160, "y": 100, "miIpAddrRed": argIP});
    }
}

function baseQueryArgGrupos(argValue)
{
    //select enlaces.nombre,enlaces.direccionip, enlaces.id, COUNT(maquinas.idred) as canteq from maquinas  inner join enlaces on (enlaces.id=maquinas.idred)  where enlaces.nombre like '%colo%' or enlaces.observaciones like '%colo%' group by maquinas.idred
    modelRedes.setDatabase("equipos.sqlite");
    modelRedes.setQuery("select enlaces.nombre,enlaces.direccionip, enlaces.id, COUNT(maquinas.idred) as canteq from maquinas  inner join enlaces on (enlaces.id=maquinas.idred)  where enlaces.nombre like '%"+argValue+"%' or enlaces.observaciones like '%"+argValue+"%' group by maquinas.idred")
    listViewRedes.model = modelRedes;
}


function baseQueryListaGrupos() //ventana lista de acciones
{
    modelRedes.setDatabase("equipos.sqlite");
    modelRedes.setQuery("select enlaces.nombre,enlaces.direccionip, enlaces.id, COUNT(maquinas.idred) as canteq from maquinas  inner join enlaces on (enlaces.id=maquinas.idred)  group by maquinas.idred")
    listViewRedes.model = modelRedes;
}

function baseQuerySaveEdGrupo(argHostnameRed,argIPRed,argObserv,argIDGrupo) //update o insert desde ventana EditarRedes
{
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();

    if(dd<10) {
        dd='0'+dd
    }

    if(mm<10) {
        mm='0'+mm
    }

    today = mm+'-'+dd+'-'+yyyy;

    modelEdRed.setDatabase("equipos.sqlite");
    if(argIDGrupo==="")
    {
        modelEdRed.setQuery("INSERT INTO enlaces (nombre,direccionip,observaciones,lastdate) VALUES ('" + argHostnameRed + "', '"+ argIPRed + "','"+ argObserv + "', '"+ today + "')")
    }else{
        modelEdRed.setQuery("UPDATE enlaces SET nombre='" + argHostnameRed + "', direccionip='"+ argIPRed + "',observaciones='"+ argObserv + "',lastdate='"+today+"' WHERE id='"+argIDGrupo+"'")
    }
    mensajeEstadoGrupo("Guardado")
}

function mensajeEstadoGrupo(arg) //mensaje ventana
{
    textEstado.text=arg
}

function funcionGetObsGrupo(argID)
{
    modeloGetValueGrupo.setDatabase("equipos.sqlite");
    modeloGetValueGrupo.setQuery("SELECT observaciones FROM ENLACES WHERE id='"+argID+"'")
    return modeloGetValueGrupo.get(0).observaciones
}
function funcionGetUrlGrupo(argID)
{
    modeloGetValueGrupo.setDatabase("equipos.sqlite");
    modeloGetValueGrupo.setQuery("SELECT url FROM ENLACES WHERE id='"+argID+"'")
    return modeloGetValueGrupo.get(0).url
}

//***********etiquetas
function funcionTraeEtiquetas()
{
    modelEtiquetas.setDatabase("equipos.sqlite");
    modelEtiquetas.setQuery("Select * from etiquetas")
}

function funcionTraeRelaciones(argIdMaq)
{
    modelRelaciones.setDatabase("equipos.sqlite");
    modelRelaciones.setQuery("SELECT etiquetas.descripcion,etiquetas.id, rela_maq_etiq.id as idRela  FROM maquinas inner join rela_maq_etiq on (rela_maq_etiq.idmaq=maquinas.id) inner join etiquetas on (etiquetas.id=rela_maq_etiq.idetq) where maquinas.id='"+argIdMaq+"'")
}

function funcionInsertaRela(argidMaq,argidEt)
{
    modelRelaciones.setDatabase("equipos.sqlite");
    modelRelaciones.setQuery("insert into rela_maq_etiq (idmaq,idetq) VALUES ('"+argidMaq+"','"+argidEt+"')")
}

function funcionEliminaRela(argIdRela,argIdMaq)
{
    modelRelaciones.setDatabase("equipos.sqlite");
    modelRelaciones.setQuery("delete from rela_maq_etiq where id='"+argIdRela+"'")
    funcionTraeRelaciones(argIdMaq)
}

//*******traigo etiquetas main
function divideEtiqueta(id){
    modeloEtiquetas.setDatabase("equipos.sqlite");
    modeloEtiquetas.setQuery("SELECT count(etiquetas.descripcion) as cantidad FROM maquinas inner join rela_maq_etiq on (rela_maq_etiq.idmaq=maquinas.id) inner join etiquetas on (etiquetas.id=rela_maq_etiq.idetq) where maquinas.id='"+id+"'")
    return modeloEtiquetas.get(0).cantidad
}

function laetiqueta(argindex,id)
{
    modeloEtiquetas.setDatabase("equipos.sqlite");
    modeloEtiquetas.setQuery("SELECT etiquetas.descripcion as eti FROM maquinas inner join rela_maq_etiq on (rela_maq_etiq.idmaq=maquinas.id) inner join etiquetas on (etiquetas.id=rela_maq_etiq.idetq) where maquinas.id='"+id+"'")
    return modeloEtiquetas.get(argindex).eti
}
