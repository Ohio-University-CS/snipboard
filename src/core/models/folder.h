/**
 *        @file: folder.h
 *      @author: Kyle Carey
 *        @date: October 16, 2025
 *       @brief: Folder model
 */

#ifndef FOLDER_H
#define FOLDER_H

#include <string>
#include <vector>

struct Folder {
    int id = -1;
    int parentFolderId = -1;
    std::string name = "";
    std::string dateCreated = "";
    std::string dateUpdated = "";
    std::vector<int> subFolderIds;

    Folder(int id, int parentFolderId, std::string name, std::string dateCreated, std::string dateUpdated, std::vector<int> subFolderIds)
        : id(id), parentFolderId(parentFolderId), name(name), dateCreated(dateCreated), dateUpdated(dateUpdated), subFolderIds(subFolderIds) {}
};

#endif