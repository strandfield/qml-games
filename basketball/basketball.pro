TEMPLATE = app
TARGET = basketball

include(../window/window.pri)

SOURCES += main.cpp
RESOURCES += basketball.qrc

QML_IMPORT_PATH = $$PWD/qml
