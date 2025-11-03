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
    Snippet loadById(int id);
    bool insert(Snippet& snippet);
    bool update(Snippet& snippet);
    bool remove(int id);

 private:
    QSqlDatabase m_db;
};