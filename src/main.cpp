/**
 *        @file: main.cpp
 *      @author: Team SnipBoard
 *        @date: October 28, 2025
 *       @brief: Main file. Application entrypoint
 */

#include <QCoreApplication>  //needed for mac
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>

using namespace Qt::StringLiterals;

/**
 * @brief  loads the graphics modules depending on the operating system.
 *         need to add any other gui files to this function as they are made
 *
 * @param engine  the QQmlApplicationEngine
 */
void loadModules(QQmlApplicationEngine& engine);

int main(int argc, char* argv[]) {
    // Create app and engine
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Update this function with any new .qml paths
    loadModules(engine);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}

void loadModules(QQmlApplicationEngine& engine) {
    // Will need to add other QML files to this
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/SnipBoard/src/gui/main.qml")));
}
