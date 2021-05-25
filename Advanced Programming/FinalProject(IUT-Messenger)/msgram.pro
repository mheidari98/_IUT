#-------------------------------------------------
#
# Project created by QtCreator 2018-07-05T03:05:41
#
#-------------------------------------------------

QT       += core gui network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = msgram
TEMPLATE = app


SOURCES += main.cpp \
    chat.cpp \
    chat_list.cpp \
    chatroom.cpp \
    join_create.cpp \
    login.cpp \
    logout.cpp \
    message_list.cpp \
    network.cpp \
    profile_show.cpp \
    register.cpp \
    screen.cpp \
    set_background.cpp

HEADERS  += \
    chat.h \
    chat_list.h \
    chatroom.h \
    join_create.h \
    login.h \
    message_list.h \
    network.h \
    profile_show.h \
    register.h \
    screen.h \
    logout.h \
    set_background.h

FORMS    += mainwindow.ui

RESOURCES += \
    myfiles.qrc
