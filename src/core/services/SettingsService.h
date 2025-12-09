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
    Q_INVOKABLE void setConfirmBeforeDelete(bool value);
    Q_INVOKABLE void setDefaultLanguage(QString value);
    Q_INVOKABLE void setDefaultSortMethod(QString value);

    Q_INVOKABLE int theme () const { return m_settings.theme; }
    Q_INVOKABLE bool confirmBeforeDelete () const { return m_settings.confirmBeforeDelete; }
    Q_INVOKABLE QString defaultLanguage () const { return m_settings.defaultLanguage; }
    Q_INVOKABLE QString defaultSortMethod () const { return m_settings.defaultSortMethod; }


signals:
    void settingsChanged();

private:
    QString m_settingsPath;  
    Settings m_settings;
};
