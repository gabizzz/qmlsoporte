#include "resolveipname.h"
#include <QDebug>
#include <QtQml>

ResolveIpName::ResolveIpName(QObject *parent) : QObject(parent)
{

}

ResolveIpName::~ResolveIpName()
{

}

QString ResolveIpName::resolverIPporNombre(QString arg)
{
    QHostInfo info = QHostInfo::fromName(arg);
    QString value;
    if (info.addresses().count()>0)
        value=info.addresses().at(0).toString();
    else
        value="no ip address";

    return QString(value);
}

QString ResolveIpName::resolverNombreporIP(QString arg)
{
    QHostInfo info = QHostInfo::fromName(arg);

    QString value=info.hostName();
    return QString(value);
}

void ResolveIpName::declareQML() {
    qmlRegisterType<ResolveIpName>("ResolverIPName", 1, 0, "ResolveIpName");
}
