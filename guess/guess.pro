TEMPLATE = app
TARGET = guess

include(../window/window.pri)

SOURCES += main.cpp
RESOURCES += guess.qrc

QML_IMPORT_PATH = $$PWD/qml
