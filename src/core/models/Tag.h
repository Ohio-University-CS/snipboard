/**
 *        @file: Tag.h
 *      @author: Kyle Carey
 *        @date: October 15, 2025
 *       @brief: Tag model
 */

#pragma once

#include <QString>
#include <QDateTime>

struct Tag {
    int id = -1;
    QString name;
    QDateTime dateCreated;
    QDateTime dateModified;
    bool showDate = true;

    Tag() {}
    Tag(int id, QString name, QDateTime dateCreated, QDateTime dateModified, bool showDate)
        : id(id), name(name), dateCreated(dateCreated), dateModified(dateModified), showDate(showDate) {}
};
