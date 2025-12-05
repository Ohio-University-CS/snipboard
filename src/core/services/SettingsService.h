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
    Q_INVOKABLE void setConflictHandling(QString value);

    Q_INVOKABLE int theme () const { return m_settings.theme; }
    Q_INVOKABLE int editorFontSize () const { return m_settings.editorFontSize; }
    Q_INVOKABLE int editorFontFamily () const { return m_settings.editorFontFamily; }
    Q_INVOKABLE bool lineNumbers () const { return m_settings.lineNumbers; }
    Q_INVOKABLE bool syntaxHighlighting () const { return m_settings.syntaxHighlighting; }
    Q_INVOKABLE bool wrapLines () const { return m_settings.wrapLines; }
    Q_INVOKABLE bool confirmBeforeDelete () const { return m_settings.confirmBeforeDelete; }
    Q_INVOKABLE int tabSize () const { return m_settings.tabSize; }
    Q_INVOKABLE QString defaultLanguage () const { return m_settings.defaultLanguage; }
    Q_INVOKABLE QString defaultSortMethod () const { return m_settings.defaultSortMethod; }
    Q_INVOKABLE int defaultSnippetFolder () const { return m_settings.defaultSnippetFolder; }
    Q_INVOKABLE QString exportLocation () const { return m_settings.exportLocation; }
    Q_INVOKABLE QString exportFormat () const { return m_settings.exportFormat; }
    Q_INVOKABLE QString importLocation () const { return m_settings.importLocation; }
    Q_INVOKABLE QString conflictHandling () const {return m_settings.conflictHandling; }

signals:
    void settingsChanged();

private:
    QString m_settingsPath;  
    Settings m_settings;
};
