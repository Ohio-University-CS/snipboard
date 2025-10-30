/**
 *        @file: main.cpp
 *      @author: Team SnipBoard
 *        @date: October 13, 2025
 *       @brief: Main file. Application entrypoint
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>
#include <QCoreApplication> //needed for mac


using namespace Qt::StringLiterals;

/**
 * @brief  loads the graphics modules depending on the operating system. 
 *         need to add any other gui files to this function as they are made
 *
 * @param engine  the QQmlApplicationEngine
 */
void loadModules(QQmlApplicationEngine& engine);

int main(int argc, char *argv[])
{
    // Create app and engine
    std::cout<<"test1";
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    /* Update this function with any new .qml paths */
    loadModules(engine);
    std::cout<<"test2";
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}

void loadModules(QQmlApplicationEngine& engine) {
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/SnipBoard/src/gui/main.qml")));
}