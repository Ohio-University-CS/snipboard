/**
 *        @file: SnippetListModel.cpp
 *      @author: Kyle Carey
 *        @date: October 26, 2025
 *       @brief: Implementation of SnippetListModel
 */

#include "SnippetListModel.h"
#include <algorithm>

SnippetListModel::SnippetListModel(QObject* parent)
    : QAbstractListModel(parent) {}

int SnippetListModel::rowCount(const QModelIndex& parent) const {
    if (parent.isValid()) {
        return 0;
    }

    return m_snippets.size();
}

QVariant SnippetListModel::data(const QModelIndex& index, int role) const {
    if (!index.isValid() || index.row() >= m_snippets.size()) {
        return {};
    }

    // Grab the clicked snippet, and return the data based on the role
    SnippetObject* snippet = m_snippets[index.row()];

    switch (role) {
        case IdRole:
            return snippet->id();
        case NameRole:
            return snippet->name();
        case DescriptionRole:
            return snippet->description();
        case LanguageRole:
            return snippet->language();
        case DataRole:
            return snippet->data();
        case FolderRole:
            return snippet->folder();
        case FavoriteRole:
            return snippet->favorite();
        case TimesCopiedRole:
            return snippet->timesCopied();
        case TagNamesRole:
            return QVariant::fromValue(snippet->tagNames());
    }

    return {};
}

QHash<int, QByteArray> SnippetListModel::roleNames() const {
    // Map roles to QML properties (ex. snippet.name in QML equates to NameRole here)
    return {
        {IdRole, "id"},
        {NameRole, "name"},
        {DescriptionRole, "description"},
        {LanguageRole, "language"},
        {DataRole, "data"},
        {FolderRole, "folder"},
        {FavoriteRole, "favorite"},
        {TimesCopiedRole, "timesCopied"},
        {TagNamesRole, "tagNames"}};
}

void SnippetListModel::setSnippets(const QList<SnippetObject*>& snippets) {
    beginResetModel();
    m_snippets = snippets;
    endResetModel();
}

SnippetObject* SnippetListModel::get(int index) const {
    if (index < 0 || index >= m_snippets.size()) {
        return nullptr;
    }

    return m_snippets[index];
}

void SnippetListModel::onSnippetAdded(SnippetObject* snippet) {
    addSnippet(snippet);
}

void SnippetListModel::onSnippetDeleted(int id) {
    removeSnippet(id);
}

void SnippetListModel::onSnippetUpdated(int id, SnippetObject* updatedSnippet) {
    updateSnippetById(id, updatedSnippet);
}

void SnippetListModel::addSnippet(SnippetObject* snippet) {
    beginInsertRows(QModelIndex(), m_snippets.size(), m_snippets.size());
    m_snippets.append(snippet);
    endInsertRows();
}

void SnippetListModel::removeSnippet(int id) {
    // Find snippet based on id and remove it
    for (int i = 0; i < m_snippets.size(); ++i) {
        if (m_snippets[i]->id() == id) {
            beginRemoveRows(QModelIndex(), i, i);
            SnippetObject* obj = m_snippets.takeAt(i);
            endRemoveRows();
            obj->deleteLater();
            return;
        }
    }
}

void SnippetListModel::updateSnippetById(int id, SnippetObject* updatedSnippet) {
    // Find the snippet based on id and update it to updatedSnippet
    for (int i = 0; i < m_snippets.size(); ++i) {
        if (m_snippets[i]->id() == id) {
            SnippetObject* old = m_snippets[i];
            m_snippets[i] = updatedSnippet;

            QModelIndex idx = createIndex(i, 0);
            emit dataChanged(idx, idx);

            old->deleteLater();
            return;
        }
    }
}

void SnippetListModel::sortByDateCreated(bool ascending) {
    // Sort by date created, with order dependent on ascending
    std::sort(m_snippets.begin(), m_snippets.end(), [ascending](const auto& x, const auto& y) {
        if (ascending) {
            return x->getDateCreated() < y->getDateCreated();
        }

        return x->getDateCreated() > y->getDateCreated();
    });
}

void SnippetListModel::sortByDateModified(bool ascending) {
    // Sort by date modified, with order dependent on ascending
    std::sort(m_snippets.begin(), m_snippets.end(), [ascending](const auto& x, const auto& y) {
        if (ascending) {
            return x->getDateModified() < y->getDateModified();
        }

        return x->getDateModified() > y->getDateModified();
    });
}

void SnippetListModel::sortByMostCopied(bool ascending) {
    // Sort by total number of times copied
    std::sort(m_snippets.begin(), m_snippets.end(), [ascending](const auto& x, const auto& y) {
        if (ascending) {
            return x->timesCopied() < y->timesCopied();
        }

        return x->timesCopied() > y->timesCopied();
    });
}

void SnippetListModel::sortByName(bool alphabetical) {
    // Sort by name
    std::sort(m_snippets.begin(), m_snippets.end(), [alphabetical](const auto& x, const auto& y) {
        if (alphabetical) {
            return x->name() < y->name();
        }

        return x->name() > y->name();
    });
}