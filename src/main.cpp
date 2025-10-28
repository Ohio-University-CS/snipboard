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
#include <QUrl>
#include <QDebug>
#include <QQmlError>
#include <QQmlContext>
#include <QQmlEngine>
#include <QFile>

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
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/SnipBoard/src/gui/main.qml")));
}

// void loadModules(QQmlApplicationEngine& engine) {
//     engine.load(QUrl(QStringLiteral("qrc:/qt/qml/SnipBoard/src/gui/main.qml")));
//     /* WE WILL NEED TO KEEP ADDING THESE PATHS FOR EVERY .qml FILE WE CREATE */
//     // Try to load it using QRC
//     // const QUrl qmlUrl(QStringLiteral("qrc:/qt/qml/main.qml"));
//     // engine.load(qmlUrl);

//     // Ensure the QML module directory from the build is added first (helps different dev build layouts)
// #ifdef SNIPBOARD_QML_MODULE_DIR
//     engine.addImportPath(QStringLiteral(SNIPBOARD_QML_MODULE_DIR));
// #endif
//     // Also try a few runtime-relative locations which are common when launching from IDEs
//     engine.addImportPath(QCoreApplication::applicationDirPath() + "/../SnipBoard");
//     engine.addImportPath(QCoreApplication::applicationDirPath() + "/SnipBoard");
    
//     // Add import paths for Qt Creator's build directory structure
//     engine.addImportPath(QCoreApplication::applicationDirPath() + "/../../src/gui");
//     engine.addImportPath(QCoreApplication::applicationDirPath() + "/../..");

//     // Prefer loading the QML from the compiled resource (qrc)
//     engine.load(QUrl(QStringLiteral("qrc:/qt/qml/SnipBoard/src/gui/main.qml")));

//     // If qrc wasn't embedded for some reason (different generator/IDE layout),
//     // attempt to load directly from the generated module directory that CMake
//     // created at build time (we inject SNIPBOARD_QML_MODULE_DIR in CMakeLists).
// #ifdef SNIPBOARD_QML_MODULE_DIR
//     if (engine.rootObjects().isEmpty())
//         engine.load(QUrl::fromLocalFile(QStringLiteral(SNIPBOARD_QML_MODULE_DIR) + "/main.qml"));
// #endif

//     // Fallback to hardcoded resource paths
//     if (engine.rootObjects().isEmpty()) {
//         #ifdef _WIN32
//         // Try both Qt Creator's build path pattern and direct CMake build path
//         QString creatorPath = QCoreApplication::applicationDirPath() + "/../../src/gui/main.qml";
//         QString cmakePath = QCoreApplication::applicationDirPath() + "/../src/gui/main.qml";
        
//         // Check if the files exist before trying to load them
//         if (QFile::exists(creatorPath)) {
//             engine.load(QUrl::fromLocalFile(creatorPath));
//         }
//         if (engine.rootObjects().isEmpty() && QFile::exists(cmakePath)) {
//             engine.load(QUrl::fromLocalFile(cmakePath));
//         }
//         #elif __APPLE__
//         engine.load(QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/../Resources/main.qml"));
//         #else
//         std::cerr << "Unknown operating system and qrc load failed\n";
//         #endif
//     }

//     // If still empty, print the QML errors to help debugging at runtime
//     if (engine.rootObjects().isEmpty()) {
//         qWarning() << "Failed to load root QML object(s).";
//         qWarning() << "Tried paths:";
//         qWarning() << "  1. qrc:/qt/qml/SnipBoard/main.qml";
// #ifdef SNIPBOARD_QML_MODULE_DIR
//         qWarning() << "  2. " << SNIPBOARD_QML_MODULE_DIR << "/main.qml";
// #endif
//         qWarning() << "  3. " << QCoreApplication::applicationDirPath() + "/../../src/gui/main.qml";
//         qWarning() << "  4. " << QCoreApplication::applicationDirPath() + "/../src/gui/main.qml";
//         qWarning() << "Run the application from a terminal to see QML parser errors, or enable verbose QML logging (QML_IMPORT_TRACE=1).";
//     }
// }
