#-------------------------------------------------
#
# Project created by QtCreator 2017-11-15T16:51:38
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = GuiWork
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    subwindow.cpp \
    objwindow.cpp \
    algorithm.cpp \
    addfuction.cpp \
    effects.cpp \
    exposure.cpp \
    encryption.cpp

HEADERS  += mainwindow.h \
    subwindow.h \
    objwindow.h \
    algorithm.h \
    addfuction.h \
    effects.h \
    exposure.h \
    encryption.h

FORMS    += mainwindow.ui \
    subwindow.ui \
    objwindow.ui \
    algorithm.ui \
    addfuction.ui \
    effects.ui \
    exposure.ui \
    encryption.ui

INCLUDEPATH+=D:/opencv/build/include\
             D:/opencv/build/include/opencv\
             D:/opencv/build/include/opencv2

LIBS+=D:/opencv/compile/lib/libopencv_*

RESOURCES += \
    image.qrc \
    temp.qrc \
    temp1.qrc

CONFIG+=C++11

CONFIG += resources_big
