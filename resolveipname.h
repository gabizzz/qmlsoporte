#ifndef RESOLVEIPNAME_H
#define RESOLVEIPNAME_H

#include <QHostInfo>
#include <QObject>

class ResolveIpName : public QObject
{
    Q_OBJECT
public:
    explicit ResolveIpName(QObject *parent = 0);
    ~ResolveIpName();

    static void declareQML();

signals:

public slots:
    Q_INVOKABLE QString resolverNombreporIP(QString arg);
    Q_INVOKABLE QString resolverIPporNombre(QString arg);
};

#endif // RESOLVEIPNAME_H
