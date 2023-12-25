TEMPLATE = app
TARGET = collection

QT += quick qml svg

SOURCES += main.cpp

RESOURCES += collection.qrc \
  ../basketball/basketball.qrc \
  ../guess/guess.qrc

QML_IMPORT_PATH = qml
