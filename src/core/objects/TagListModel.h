/**
 *        @file: TagListModel.h
 *      @author: Kyle Carey
 *        @date: October 26, 2025
 *       @brief: List Model for Tags used by QML UI.
 *
 *   Note: This model does NOT modify the database. It simply reflects
 *   state owned and controlled by TagService.
 */

#pragma once

#include <QAbstractListModel>

#include "TagObject.h"

class TagListModel : public QAbstractListModel {
    Q_OBJECT

 public:
    // Roles for QML
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        ShowDateRole,
        CheckedRole
    };
    Q_ENUM(Roles)

    explicit TagListModel(QObject* parent = nullptr);

    // Model configuration
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    // Set the Tags
    void setTags(const QList<TagObject*>& tags);
    
    // QML read access
    Q_INVOKABLE TagObject* get(int index) const;

 public slots:
    // Called by TagService
    void onTagAdded(TagObject* tag);
    void onTagDeleted(int id);
    void onTagUpdated(int id, TagObject* updatedTag);

 private:
    // Internal helpers (these will update the UI when tagService calls a slot)
    void addTag(TagObject* tag);
    void removeTag(int id);
    void updateTagById(int id, TagObject* updatedTag);

 private:
    QList<TagObject*> m_tags;
};
