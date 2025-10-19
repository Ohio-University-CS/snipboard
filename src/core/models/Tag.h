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
    QString dateUpdated;
    bool showDate = true;

    Tag(int id, QString name, QString dateCreated, QString dateUpdated, bool showDate)
        : id(id), name(name), dateCreated(dateCreated), dateUpdated(dateUpdated), showDate(showDate) {}
};
