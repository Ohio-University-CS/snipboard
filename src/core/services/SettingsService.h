#pragma once

#include <QObject>
#include <QString>

#include "../models/Settings.h"

class SettingsService : public QObject {
    Q_OBJECT

public:
    explicit SettingsService(QObject* parent = nullptr);

    QString settingsFilePath() const;
    Q_INVOKABLE void load();
    Q_INVOKABLE void save();

    const Settings& settings() const { return m_settings; }

    //setters
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

    //getters
    Q_INVOKABLE int getTheme(){return m_settings.theme;}
    Q_INVOKABLE int getEditorFontSize(){return m_settings.editorFontSize;}
    Q_INVOKABLE int getEditorFontFamily(){return m_settings.editorFontFamily;}
    Q_INVOKABLE bool getLineNumbers(){return m_settings.lineNumbers;}
    Q_INVOKABLE bool getSyntaxHighlighting(){return m_settings.syntaxHighlighting;}
    Q_INVOKABLE bool getWrapLines(){return m_settings.wrapLines;}
    Q_INVOKABLE bool getConfirmBeforeDelete(){return m_settings.confrimBeforeDelete;}
    Q_INVOKABLE int getTabSize(){return m_settings.tabSize;}
    Q_INVOKABLE QString getDefaultLanguage(){return m_settings.defaultLanguage;}
    Q_INVOKABLE QString getDefaultSortMethod(){return m_settings.defaultSortMethod;}
    Q_INVOKABLE int getDefaultSnippetFolder(){return m_settings.defaultSnippetFolder;}
    Q_INVOKABLE QString getExportLocation(){return m_settings.exportLocation;}
    Q_INVOKABLE QString getExportFormat(){return m_settings.exportFormat;}
    Q_INVOKABLE QString getImportLocation(){return m_settings.importLocation;}
    Q_INVOKABLE QString getConflictHandeling(){return m_settings.conflictHandeling;}

signals:
    void settingsChanged();

private:
    QString m_settingsPath;  
    Settings m_settings;
};
