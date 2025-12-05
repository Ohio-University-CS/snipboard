/**
 *        @file: main.cpp
 *      @author: Team SnipBoard
 *        @date: October 28, 2025
 *       @brief: Main file. Application entrypoint
 */

#include <QCoreApplication>  //needed for mac
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>
// #include "src/core/models"
#include "src/core/objects/SnippetObject.h"
#include "src/core/objects/SnippetListModel.h"
#include "src/core/objects/TagListModel.h"
#include "src/core/objects/TagObject.h"
#include "src/core/services/SnippetService.h"
#include "src/core/services/TagService.h"
#include "src/core/utils/ClipboardHelper.h"
#include "src/core/services/SettingsService.h"


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
    std::cout<<"test1";
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<SnippetObject>("SnipBoard", 1, 0, "SnippetObject");

    // Register the singleton (Qt 6+)
    static ClipboardHelper clipboardSingleton; // must outlive the engine
    qmlRegisterSingletonInstance<ClipboardHelper>(
        "SnipBoard", 1, 0, "Clipboard", &clipboardSingleton);
    
    SnippetService snippetService;
    engine.rootContext()->setContextProperty("snippetService", &snippetService);

    TagService tagService;
    engine.rootContext()->setContextProperty("tagService", &tagService);
    
    // SettingsService
    SettingsService settingsService;
    engine.rootContext()->setContextProperty("settingsService", &settingsService);
    
    // Update this function with any new .qml paths
    loadModules(engine);
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}

void loadModules(QQmlApplicationEngine& engine) {
    // Will need to add other QML files to this

    // commented out the main to add the testing file
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/SnipBoard/src/gui/main.qml")));
    // engine.load(QUrl(QStringLiteral("qrc:/qt/qml/SnipBoard/src/gui/pages/home.qml")));
}
