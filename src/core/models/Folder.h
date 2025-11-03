/**
 *        @file: Folder.h
 *      @author: Kyle Carey
 *        @date: October 16, 2025
 *       @brief: Folder model
 */

#pragma once

#include <QString>
#include <QVector>
#include <QDateTime>

struct Folder {
    int id = -1;
    int parentFolderId;
    QString name;
    QDateTime dateCreated;
    QDateTime dateModified;
    QVector<int> subFolderIds;

    Folder() {}
    Folder(int id, int parentFolderId, QString name, QDateTime dateCreated, QDateTime dateModified, QVector<int> subFolderIds)
        : id(id), parentFolderId(parentFolderId), name(name), dateCreated(dateCreated), dateModified(dateModified), subFolderIds(subFolderIds) {}
};
