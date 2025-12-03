#pragma once

#include <QObject>
#include <QString>

#include "../models/Settings.h"

class SettingsService : public QObject {
    Q_OBJECT

public:
    explicit SettingsService(QObject* parent = nullptr);

    Q_INVOKABLE void load();
    Q_INVOKABLE void save();

    const Settings& settings() const { return m_settings; }

    Q_INVOKABLE void setTheme(int value);
    Q_INVOKABLE void setEditorFontSize(int value);
    Q_INVOKABLE void setEditorFontFamily(int value);
    Q_INVOKABLE void setLineNumbers(bool value);
    Q_INVOKABLE void setSyntaxHighlighting(bool value);
    Q_INVOKABLE void setWrapLines(bool value);
    Q_INVOKABLE void setConfirmBeforeDelete(bool value);
    Q_INVOKABLE void setTabSize(int value);
    Q_INVOKABLE void setDefaultLanguage(QString value);
    Q_INVOKABLE void setDefaultSortMethod(QString value);
    Q_INVOKABLE void setDefaultSnippetFolder(int value);
    Q_INVOKABLE void setExportLocation(QString value);
    Q_INVOKABLE void setExportFormat(QString value);
    Q_INVOKABLE void setImportLocation(QString value);
    Q_INVOKABLE void setConflictHandeling(QString value);

signals:
    void settingsChanged();

private:
    QString m_settingsPath;  
    Settings m_settings;
};
