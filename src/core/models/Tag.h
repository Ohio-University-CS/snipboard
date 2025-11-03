/**
 *        @file: Tag.h
 *      @author: Kyle Carey
 *        @date: October 15, 2025
 *       @brief: Tag model
 */

#pragma once

#include <QString>

struct Tag {
    int id = -1;
    QString name;
    QString dateCreated;
    QString dateModified;
    bool showDate = true;

    Tag() {}
    Tag(int id, QString name, QString dateCreated, QString dateModified, bool showDate)
        : id(id), name(name), dateCreated(dateCreated), dateModified(dateModified), showDate(showDate) {}
};
