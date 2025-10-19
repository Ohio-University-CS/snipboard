/**
 *        @file: tag.h
 *      @author: Kyle Carey
 *        @date: October 15, 2025
 *       @brief: Tag model
 */

#ifndef TAG_H
#define TAG_H

#include <string>

struct Tag {
    int id = -1;
    std::string name = "";
    std::string dateCreated = "";
    std::string dateUpdated = "";
    bool showDate = true;

    Tag(int id, std::string name, std::string dateCreated, std::string dateUpdated)
        : id(id), name(name), dateCreated(dateCreated), dateUpdated(dateUpdated) {}
};

#endif