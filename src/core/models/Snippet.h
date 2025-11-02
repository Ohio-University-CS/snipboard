/**
 *        @file: Snippet.h
 *      @author: Kyle Carey
 *        @date: October 19, 2025
 *       @brief: Snippet model
 */

#pragma once

#include <QString>
#include <QVector>

struct Snippet {
    int id = -1;
    QString name;
    QString dateCreated;
    QString dateUpdated;
    QString description;
    QString data;
    QString language;
    QVector<int> tags;
    int folder = 0;  // default to home
    bool favorite = false;
    quint64 timesCopied = 0;

    Snippet() {}
    Snippet(int id, QString name, QString dateCreated, QString dateUpdated, QString description, QString data, QString language, QVector<int> tags, int folder, bool favorite, quint64 timesCopied)
        : id(id), name(name), dateCreated(dateCreated), dateUpdated(dateUpdated), description(description), data(data), language(language), tags(tags), folder(folder), favorite(favorite), timesCopied(timesCopied) {}
};
