/**
 *        @file: TagRepository.h
 *      @author: Davis Lewis
 *        @date: November 03, 2025
 *       @brief: Repository interacts directly with the database
 */

#pragma once

#include <QSqlDatabase>
#include <QVector>

#include "../models/Tag.h"

class TagRepository {
 public:
    explicit TagRepository(QSqlDatabase db);

    QVector<Tag> loadAll();
    Tag loadById(int id);
    bool insert(Tag& tag);
    bool update(Tag& tag);
    bool remove(int id);
    int findIdByName(const QString& name);

 private:
    QSqlDatabase m_db;
};