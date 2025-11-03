/**
 *        @file: Snippet.h
 *      @author: Kyle Carey
 *        @date: October 19, 2025
 *       @brief: Snippet model
 */

#pragma once

#include <QString>
#include <QVector>
#include <QDateTime>

struct Snippet {
    int id = -1;
    QString name;
    QDateTime dateCreated;
    QDateTime dateModified;
    QString description;
    QString contents;
    QString language;
    QVector<int> tags;
    int folder = 0;  // default to home
    bool favorite = false;
    quint64 timesCopied = 0;

    Snippet() {}
    Snippet(int id, QString name, QDateTime dateCreated, QDateTime dateModified, QString description, QString contents, QString language, QVector<int> tags, int folder, bool favorite, quint64 timesCopied)
        : id(id), name(name), dateCreated(dateCreated), dateModified(dateModified), description(description), contents(contents), language(language), tags(tags), folder(folder), favorite(favorite), timesCopied(timesCopied) {}
};
