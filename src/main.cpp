/**
 *        @file: main.cpp
 *      @author: Team SnipBoard
 *        @date: October 13, 2025
 *       @brief: Main file. Application entrypoint
 */

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

int main(int argc, char *argv[])
{
    // Create app and engine
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    /* Update this function with any new .qml paths */
    loadModules(engine);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}

void loadModules(QQmlApplicationEngine& engine) {
    /* WE WILL NEED TO KEEP ADDING THESE PATHS FOR EVERY .qml FILE WE CREATE */
    // Try to load it using QRC
    // const QUrl qmlUrl(QStringLiteral("qrc:/qt/qml/main.qml"));
    // engine.load(qmlUrl);

    //Lucas changed the load to this
    engine.load(QUrl(u"qrc:/qt/qml/SnipBoard/main.qml"_s));

    // Fallback to hardcoded resource paths
    if (engine.rootObjects().isEmpty()) {
        #ifdef _WIN32
        //Lucas changed the load to this
        engine.load(QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/../../src/gui/main.qml"));

        #elif __APPLE__
        engine.load(QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/../Resources/main.qml"));
        #else
        std::cerr << "Unknown operating system and qrc load failed\n";
        #endif
    }
}
