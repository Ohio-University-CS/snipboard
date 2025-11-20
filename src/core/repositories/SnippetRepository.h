/**
 *        @file: SnippetsRepository.h
 *      @author: Kyle Carey
 *        @date: November 02, 2025
 *       @brief: Repository interacts directly with the database
 */

#pragma once

#include <QSqlDatabase>
#include <QVector>

#include "../models/Snippet.h"

class SnippetRepository {
 public:
    explicit SnippetRepository(QSqlDatabase db);

    QVector<Snippet> loadAll();
    QVector<Snippet> loadAllFavorites();
    Snippet loadById(int id);
    bool insert(Snippet& snippet);
    bool update(Snippet& snippet);
    bool remove(int id);
    bool incrementCopied(int id);
    bool favorite(int id);
    bool unfavorite(int id);
    bool addTag(int snippetId, int tagId);
    bool removeTag(int snippetId, int tagId);

 private:
    QSqlDatabase m_db;
};