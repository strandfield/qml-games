TEMPLATE = app
TARGET = collection

QT += quick qml svg

SOURCES += main.cpp \
    game.cpp \
    gamelibrary.cpp

RESOURCES += collection.qrc \
  ../basketball/basketball.qrc \
  ../guess/guess.qrc

QML_IMPORT_PATH = $$PWD/qml

HEADERS += \
    game.h \
    gamelibrary.h
