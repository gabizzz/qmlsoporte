#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "sqlitemodel.h"
#include <QQmlContext>
#include <QStringListModel>
#include <QDebug>
#include <QIcon>
#include <QtQml>
#include "qdeclarativeprocess.h"
#include "resolveipname.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/logo.png"));

    ResolveIpName::declareQML();
    SQLiteModel::declareQML();


    qmlRegisterType<QDeclarativeProcess>("com.components.processes", 1, 0, "Process");

    //qmlRegisterUncreatableType<QDeclarativeProcessEnums>("com.components.processes", 1, 0, "Processes");

    SQLiteModel pref;
    pref.setDatabase("equipos.sqlite");
    pref.setQuery("SELECT * FROM settings where id ='1'");

    QString mpbaUser;
    QString mpbaPass;
    if (pref.rowCount())
    {
        mpbaUser=pref.data(pref.index(0,1),0).toString();
        mpbaPass=pref.data(pref.index(0,2),0).toString();
    }

    QString OS;
#ifdef WIN32
    OS="Win";
#else
    OS="Linux";
#endif

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("miOS", OS);

    engine.rootContext()->setContextProperty("miMPBAUser", mpbaUser);
    engine.rootContext()->setContextProperty("miMPBAPass", mpbaPass);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
