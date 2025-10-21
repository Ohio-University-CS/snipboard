/**
 *        @file: FolderObject.h
 *      @author: Kyle Carey
 *        @date: October 20, 2025
 *       @brief: Folder Object to be exposed to the QML.
 *               This is a read/write only object with properties accessible using the Q_PROPERTY definitions
 *               ex. if the name is displayed in QML, then the function name() is called. or, if it is changed in a text box, then setName() is called
 *               This can be thought of as a simple struct for QML. Nothing significant happens here besides syntactical sugar for QML to understand
 */

#pragma once

#include <QObject>
#include <QString>
#include <QVector>

#include "../models/Folder.h"

class FolderObject : public QObject {
    // Set QML properties
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(int parentFolderId READ parentFolderId WRITE setParentFolderId NOTIFY parentFolderIdChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QVector<int> subFolderIds READ subFolderIds WRITE setSubFolderIds NOTIFY subFolderIdsChanged)

 public:
    explicit FolderObject(QObject* parent = nullptr) : QObject(parent) {}
    explicit FolderObject(const Folder& folderModel, QObject* parent = nullptr);

    // Getters (for QML)
    int id() const { return m_id; }
    int parentFolderId() const { return m_parentFolderId; }
    QString name() const { return m_name; }
    QVector<int> subFolderIds() const { return m_subFolderIds; }

    // Setters (for QML)
    void setId(int id);
    void setParentFolderId(int parentFolderId);
    void setName(QString name);
    void setSubFolderIds(const QVector<int>& subFolderIds);

 signals:
    // Tells the UI to update specified property whenever one of these are called
    void idChanged();
    void parentFolderIdChanged();
    void nameChanged();
    void subFolderIdsChanged();

 private:
    int m_id = -1;
    int m_parentFolderId;
    QString m_name;
    QVector<int> m_subFolderIds;
};