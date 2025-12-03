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

void SettingsService::setEditorFontSize(int value) {
    m_settings.editorFontSize = value;
    save();
    emit settingsChanged();
}

void SettingsService::setEditorFontFamily(int value) {
    m_settings.editorFontFamily = value;
    save();
    emit settingsChanged();
}

void SettingsService::setLineNumbers(bool value) {
    m_settings.lineNumbers = value;
    save();
    emit settingsChanged();
}

void SettingsService::setSyntaxHighlighting(bool value) {
    m_settings.syntaxHighlighting = value;
    save();
    emit settingsChanged();
}

void SettingsService::setWrapLines(bool value) {
    m_settings.wrapLines = value;
    save();
    emit settingsChanged();
}

void SettingsService::setConfirmBeforeDelete(bool value) {
    m_settings.confrimBeforeDelete = value;
    save();
    emit settingsChanged();
}

void SettingsService::setTabSize(int value) {
    m_settings.tabSize = value;
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

void SettingsService::setDefaultSnippetFolder(int value) {
    m_settings.defaultSnippetFolder = value;
    save();
    emit settingsChanged();
}

void SettingsService::setExportLocation(QString value) {
    m_settings.exportLocation = value;
    save();
    emit settingsChanged();
}

void SettingsService::setExportFormat(QString value) {
    m_settings.exportFormat = value;
    save();
    emit settingsChanged();
}

void SettingsService::setImportLocation(QString value) {
    m_settings.importLocation = value;
    save();
    emit settingsChanged();
}

void SettingsService::setConflictHandeling(QString value) {
    m_settings.conflictHandeling = value;
    save();
    emit settingsChanged();
}