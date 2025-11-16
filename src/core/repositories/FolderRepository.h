/**
 *        @file: FolderRepository.h
 *      @author: Davis Lewis
 *        @date: November 03, 2025
 *       @brief: Repository interacts directly with the database
 */
#pragma once

#include <QSqlDatabase>
#include <QVector>

#include "../models/Folder.h"

class FolderRepository {
 public:
    explicit FolderRepository(QSqlDatabase db);

    QVector<Folder> loadAll();
    Folder loadById(int id);
    bool insert(Folder& folder);
    bool update(Folder& folder);
    bool remove(int id);

 private:
    QSqlDatabase m_db;
};