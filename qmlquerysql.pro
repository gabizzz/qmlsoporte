TEMPLATE = app

QT += qml quick sql

SOURCES += main.cpp \
    sqlitemodel.cpp \
    qdeclarativeprocess.cpp \
    resolveipname.cpp

RESOURCES += qml.qrc \
    recursos.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    sqlitemodel.h \
    qdeclarativeprocess.h \
    resolveipname.h
