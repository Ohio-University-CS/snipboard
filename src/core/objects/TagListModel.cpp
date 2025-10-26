/**
 *        @file: TagListModel.cpp
 *      @author: Kyle Carey
 *        @date: October 26, 2025
 *       @brief: Implementation of TagListModel
 */

#include "TagListModel.h"

TagListModel::TagListModel(QObject* parent)
    : QAbstractListModel(parent) {}

int TagListModel::rowCount(const QModelIndex& parent) const {
    if (parent.isValid()) {
        return 0;
    }

    return m_tags.size();
}

QVariant TagListModel::data(const QModelIndex& index, int role) const {
    if (!index.isValid() || index.row() >= m_tags.size()) {
        return {};
    }

    // Grab the clicked tag, and return the data based on the role
    TagObject* tag = m_tags[index.row()];

    switch (role) {
        case IdRole:
            return tag->id();
        case NameRole:
            return tag->name();
        case ShowDateRole:
            return tag->showDate();
    }

    return {};
}

QHash<int, QByteArray> TagListModel::roleNames() const {
    // Map roles to QML properties (ex. tag.name in QML equates to NameRole here)
    return {
        {IdRole, "id"},
        {NameRole, "name"},
        {ShowDateRole, "showDate"}};
}

void TagListModel::setTags(const QList<TagObject*>& tags) {
    beginResetModel();
    m_tags = tags;
    endResetModel();
}

TagObject* TagListModel::get(int index) const {
    if (index < 0 || index >= m_tags.size()) {
        return nullptr;
    }

    return m_tags[index];
}

void TagListModel::onTagAdded(TagObject* tag) {
    addTag(tag);
}

void TagListModel::onTagDeleted(int id) {
    removeTag(id);
}

void TagListModel::onTagUpdated(int id, TagObject* updatedTag) {
    updateTagById(id, updatedTag);
}

void TagListModel::addTag(TagObject* tag) {
    beginInsertRows(QModelIndex(), m_tags.size(), m_tags.size());
    m_tags.append(tag);
    endInsertRows();
}

void TagListModel::removeTag(int id) {
    // Find tag based on id and remove it
    for (int i = 0; i < m_tags.size(); ++i) {
        if (m_tags[i]->id() == id) {
            beginRemoveRows(QModelIndex(), i, i);
            TagObject* old = m_tags.takeAt(i);
            endRemoveRows();
            old->deleteLater();
            return;
        }
    }
}

void TagListModel::updateTagById(int id, TagObject* updatedTag) {
    // Find the tag based on id and update it to updatedTag
    for (int i = 0; i < m_tags.size(); ++i) {
        if (m_tags[i]->id() == id) {
            TagObject* old = m_tags[i];
            m_tags[i] = updatedTag;

            QModelIndex idx = createIndex(i, 0);
            emit dataChanged(idx, idx);

            old->deleteLater();
            return;
        }
    }
}
