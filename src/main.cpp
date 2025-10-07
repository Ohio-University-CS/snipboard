#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    std::cout << "TESTING" << std::endl;
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl::fromLocalFile("../src/gui/main.qml"));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}