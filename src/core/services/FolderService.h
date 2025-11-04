/**
 *        @file: FolderService.h
 *      @author: Davis Lewis
 *        @date: November 04, 2025
 *       @brief: Folder Service. Call this from QML
 */

#pragma once

#include <QObject>
#include <QSqlDatabase>

#include "../models/Folder.h"
#include "../objects/FolderTreeModel.h"
#include "../objects/FolderObject.h"
#include "../repositories/FolderRepository.h"

class FolderService : public QObject {
    Q_OBJECT
    Q_PROPERTY(FolderTreeModel* folders READ folders CONSTANT)

 public:
    explicit FolderService(QObject* parent = nullptr);

    
    // QML methods
    FolderTreeModel* folders() { return &m_folderModel; }
    Q_INVOKABLE void createFolder(const QString& name, const int parentFolderId);
    Q_INVOKABLE void deleteFolder(int id);
    Q_INVOKABLE void updateFolder(int id, const QString& name, const int parentFolderId);

 private:
    void loadFoldersFromDb();
    
    QSqlDatabase m_db;
    FolderRepository* m_repo;
    FolderTreeModel m_folderModel; // the list model its responsible for
};
