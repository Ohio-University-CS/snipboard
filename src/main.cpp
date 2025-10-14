#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    std::cout << "TESTING" << std::endl;
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    #ifdef _WIN32
        engine.load(QUrl::fromLocalFile("../src/gui/main.qml"));
    #elif __APPLE__
        engine.load(QUrl::fromLocalFile(QCoreApplication::applicationDirPath() + "/../Resources/main.qml"));
    #else
        std::cout << "Unkown operating system" << std::endl;
    #endif

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}