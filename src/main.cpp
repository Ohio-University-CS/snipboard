/**
 *        @file: main.cpp
 *      @author: SnipBoard
 *        @date: October 05, 2025
 *       @brief: Main file
*/

#include <QApplication>
#include "gui/mainwindow.h"

int main(int argc, char *argv[]) {
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}