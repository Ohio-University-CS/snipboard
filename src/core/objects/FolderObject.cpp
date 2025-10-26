/**
 *        @file: SnippetObject.cpp
 *      @author: Kyle Carey
 *        @date: October 20, 2025
 *       @brief: Implementations for FolderObject constructor and setters
 *               To note: returning instantly if no change happens is for efficiency (so UI does not update)
 */

#include "FolderObject.h"

FolderObject::FolderObject(const Folder& folderModel, QObject* parent) : QObject(parent) {
    // Assign folderModel data
    m_id = folderModel.id;
    m_parentFolderId = folderModel.parentFolderId;
    m_name = folderModel.name;
    m_subFolderIds = folderModel.subFolderIds;
}

void FolderObject::setId(int id) {
    if (m_id == id) {
        return;
    }

    m_id = id;
    emit idChanged();
}

void FolderObject::setParentFolderId(int parentFolderId) {
    if (m_parentFolderId == parentFolderId) {
        return;
    }

    m_parentFolderId = parentFolderId;
    emit parentFolderIdChanged();
}

void FolderObject::setName(QString name) {
    if (m_name == name) {
        return;
    }

    m_name = name;
    emit nameChanged();
}

void FolderObject::setSubFolderIds(const QVector<int>& subFolderIds) {
    if (m_subFolderIds == subFolderIds) {
        return;
    }

    m_subFolderIds = subFolderIds;
    emit subFolderIdsChanged();
}