/**
 *        @file: Folder.h
 *      @author: Kyle Carey
 *        @date: October 16, 2025
 *       @brief: Folder model
 */

#pragma once

#include <QString>
#include <QVector>

struct Folder {
    int id = -1;
    int parentFolderId;
    QString name;
    QString dateCreated;
    QString dateUpdated;
    QVector<int> subFolderIds;

    Folder() {}
    Folder(int id, int parentFolderId, QString name, QString dateCreated, QString dateUpdated, QVector<int> subFolderIds)
        : id(id), parentFolderId(parentFolderId), name(name), dateCreated(dateCreated), dateUpdated(dateUpdated), subFolderIds(subFolderIds) {}
};
