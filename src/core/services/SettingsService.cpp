#include "SettingsService.h"
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QJsonDocument>

SettingsService::SettingsService(QObject* parent)
    : QObject(parent)
{
    QString configDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(configDir);

    m_settingsPath = configDir + "/settings.json";

    load(); //load on startup
}

QString SettingsService::settingsFilePath() const
{
    //get the OS-standard config location
    QString dir = QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation);

    //ensure the directory exists
    QDir().mkpath(dir);

    //return full path to the JSON file
    return dir + "/settings.json";
}


void SettingsService::load() {
    QFile file(m_settingsPath);
    if (!file.exists()) {
        save(); //create default settings on first run
        return;
    }

    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to open settings file:" << m_settingsPath;
        return;
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    if (!doc.isObject()) {
        qWarning() << "Invalid settings JSON.";
        return;
    }

    m_settings = Settings::fromJson(doc.object());
    emit settingsChanged();
}

void SettingsService::save() {
    QJsonDocument doc(m_settings.toJson());

    QFile file(m_settingsPath);
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning() << "Failed to write settings file:" << m_settingsPath;
        return;
    }

    file.write(doc.toJson(QJsonDocument::Indented));
    file.close();
}

void SettingsService::setTheme(int value) {
    m_settings.theme = value;
    save();
    emit settingsChanged();
}

void SettingsService::setConfirmBeforeDelete(bool value) {
    m_settings.confirmBeforeDelete = value;
    save();
    emit settingsChanged();
}

void SettingsService::setDefaultLanguage(QString value) {
    m_settings.defaultLanguage = value;
    save();
    emit settingsChanged();
}

void SettingsService::setDefaultSortMethod(QString value) {
    m_settings.defaultSortMethod = value;
    save();
    emit settingsChanged();
}
