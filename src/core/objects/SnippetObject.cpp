/**
 *        @file: SnippetObject.cpp
 *      @author: Kyle Carey
 *        @date: October 19, 2025
 *       @brief: Implementations for SnippetObject constructor and setters
 *               To note: returning instantly if no change happens is for efficiency (so UI does not update)
 */

#include "SnippetObject.h"

SnippetObject::SnippetObject(const Snippet& snippetModel, const QVector<QString>& tagNames, QObject* parent) : QObject(parent) {
    // Assign snippetModel data
    m_id = snippetModel.id;
    m_name = snippetModel.name;
    m_description = snippetModel.description;
    m_language = snippetModel.language;
    m_data = snippetModel.contents; //Lucas added
    m_folder = snippetModel.folder;
    m_favorite = snippetModel.favorite;
    m_timesCopied = snippetModel.timesCopied;
    m_tagNames = tagNames;
}

void SnippetObject::setId(int id) {
    if (m_id == id) {
        return;
    }

    m_id = id;
    emit idChanged();
}

void SnippetObject::setName(QString name) {
    if (m_name == name) {
        return;
    }

    m_name = name;
    emit nameChanged();
}

void SnippetObject::setDescription(QString description) {
    if (m_description == description) {
        return;
    }

    m_description = description;
    emit descriptionChanged();
}

void SnippetObject::setLanguage(QString language) {
    if (m_language == language) {
        return;
    }

    m_language = language;
    emit languageChanged();
}

void SnippetObject::setData(QString data) {
    if (m_data == data) {
        return;
    }

    m_data = data;
    emit dataChanged();
}

void SnippetObject::setFolder(int folder) {
    if (m_folder == folder) {
        return;
    }

    m_folder = folder;
    emit folderChanged();
}

void SnippetObject::setFavorite(bool favorite) {
    if (m_favorite == favorite) {
        return;
    }

    m_favorite = favorite;
    emit favoriteChanged();
}

void SnippetObject::setTimesCopied(int timesCopied) {
    if (m_timesCopied == timesCopied) {
        return;
    }

    m_timesCopied = timesCopied;
    emit timesCopiedChanged();
}

void SnippetObject::setTagNames(const QVector<QString>& tagNames) {
    if (m_tagNames == tagNames) {
        return;
    }

    m_tagNames = tagNames;
    emit tagNamesChanged();
}

void SnippetObject::addTagName(const QString& name) {
    if (!m_tagNames.count(name)) {
        m_tagNames.append(name);
        emit tagNamesChanged();
    }
}

void SnippetObject::removeTagName(const QString& name) {
    if (m_tagNames.count(name)) {
        m_tagNames.removeAll(name);
        emit tagNamesChanged();
    }
}