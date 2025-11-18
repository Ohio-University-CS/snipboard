/**
 *        @file: SnippetObject.h
 *      @author: Kyle Carey
 *        @date: October 19, 2025
 *       @brief: Snippet Object to be exposed to the QML.
 *               This is a read/write only object with properties accessible using the Q_PROPERTY definitions
 *               ex. if the name is displayed in QML, then the function name() is called. or, if it is changed in a text box, then setName() is called
 *               This can be thought of as a simple struct for QML. Nothing significant happens here besides syntactical sugar for QML to understand
 */

#pragma once

#include <../models/Snippet.h>

#include <QObject>
#include <QString>
#include <QVector>

class SnippetObject : public QObject {
    // Set QML Properties
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString language READ language WRITE setLanguage NOTIFY languageChanged)
    Q_PROPERTY(QString data READ data WRITE setData NOTIFY dataChanged)
    Q_PROPERTY(int folder READ folder WRITE setFolder NOTIFY folderChanged)
    Q_PROPERTY(bool favorite READ favorite WRITE setFavorite NOTIFY favoriteChanged)
    Q_PROPERTY(quint64 timesCopied READ timesCopied WRITE setTimesCopied NOTIFY timesCopiedChanged)
    Q_PROPERTY(QVector<QString> tagNames READ tagNames WRITE setTagNames NOTIFY tagNamesChanged)

 public:
    explicit SnippetObject(QObject* parent = nullptr) : QObject(parent) {}
    explicit SnippetObject(const Snippet& snippetModel, const QVector<QString>& tagNames = {}, QObject* parent = nullptr);

    // Getters (for QML)
    int id() const { return m_id; }
    QString name() const { return m_name; }
    QString description() const { return m_description; }
    QString language() const { return m_language; }
    QString data() const { return m_data; }
    int folder() const { return m_folder; }
    bool favorite() const { return m_favorite; }
    quint64 timesCopied() const { return m_timesCopied; }
    QVector<QString> tagNames() const { return m_tagNames; }

    // Getters for sorting
    QDateTime getDateCreated() { return m_dateCreated; }
    QDateTime getDateModified() { return m_dateModified; }

    // Setters (for QML)
    void setId(int id);
    void setName(QString name);
    void setDescription(QString description);
    void setLanguage(QString language);
    void setData(QString data);
    void setFolder(int folder);
    void setFavorite(bool favorite);
    void setTimesCopied(int timesCopied);
    void setTagNames(const QVector<QString>& tagNames);
    void addTagName(const QString& name);
    void removeTagName(const QString& name);

 signals:
    // Tells the UI to update specified property whenever one of these are called
    void idChanged();
    void nameChanged();
    void descriptionChanged();
    void languageChanged();
    void dataChanged();
    void folderChanged();
    void favoriteChanged();
    void timesCopiedChanged();
    void tagNamesChanged();

 private:
    int m_id = -1;
    QString m_name;
    QString m_description;
    QString m_language;
    QString m_data;
    int m_folder = 0;
    bool m_favorite = false;
    quint64 m_timesCopied = 0;
    QVector<QString> m_tagNames;

    // Added for sorting
    QDateTime m_dateCreated;
    QDateTime m_dateModified;
};