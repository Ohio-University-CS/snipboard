/**
 *        @file: SnippetObject.cpp
 *      @author: Kyle Carey
 *        @date: October 19, 2025
 *       @brief: Implementations for SnippObject constructor and setters
 *               To note: returning instantly if no change happens is for efficiency (so UI does not update)
 */

#include "SnippetObject.h"

SnippetObject::SnippetObject(const Snippet& snippetModel, QObject* parent) : QObject(parent) {
    // Assign snippetModel data
    m_id = snippetModel.id;
    m_name = snippetModel.name;
    m_description = snippetModel.description;
    m_language = snippetModel.language;
    m_folder = snippetModel.folder;
    m_favorite = snippetModel.favorite;
    m_timesCopied = snippetModel.timesCopied;
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