/**
 *        @file: TagRepository.cpp
 *      @author: Davis Lewis
 *        @date: November 03, 2025
 *       @brief: SQL queries
 */

#include "TagRepository.h"

#include <QSqlError>
#include <QSqlQuery>

TagRepository::TagRepository(QSqlDatabase db) : m_db(std::move(db)) {}

QVector<Tag> TagRepository::loadAll() {
    QVector<Tag> result;
    QSqlQuery query(m_db);
    if(!query.exec("SELECT id, name, dateCreated, dateModified, showDate FROM Tag")) {
        qWarning() << "Failed to load tags: " << query.lastError();
        return result;
    }

    // While there are results, create a Tag and add to result QVector
    while (query.next()) {
        Tag t;
        t.id = query.value(0).toInt();
        t.name = query.value(1).toString();
        t.dateCreated = query.value(2).toDateTime();
        t.dateModified = query.value(3).toDateTime();
        t.showDate = query.value(4).toBool();
        result.append(t);
    }

    return result;
}

Tag TagRepository::loadById(int id) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("SELECT id, name, dateCreated, dateModified, showDate FROM Snippet WHERE id = ?");
    query.addBindValue(id);

    // Execute and warn if error
    if (!query.exec() || !query.next()) {
        qWarning() << "Failed to load tag by id:" << query.lastError();
        return {};
    }

    // Populate tag with query results
    Tag t;
    t.id = query.value(0).toInt();
    t.name = query.value(1).toString();
    t.dateCreated = query.value(2).toDateTime();
    t.dateModified = query.value(3).toDateTime();
    t.showDate = query.value(4).toBool();

    return t;
}

bool TagRepository::insert(Tag& tag) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare(
        "INSERT INTO Tag (name) "
        "VALUES (?)");
    query.addBindValue(tag.name);

    // Return false if insertion failed
    if (!query.exec()) {
        qWarning() << "Insert failed:" << query.lastError();
        return false;
    }

    // Update tag's id and return true
    tag.id = query.lastInsertId().toInt();
    return true;
}

bool TagRepository::update(Tag& tag) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("UPDATE Tag SET name=?, dateModified=? WHERE id=?");
    query.addBindValue(tag.name);
    QDateTime now = QDateTime::currentDateTimeUtc();
    query.addBindValue(now);
    query.addBindValue(tag.id);

    // Execute and get status
    if (!query.exec()) {
        qWarning() << "Update failed:" << query.lastError();
        return false;
    }

    tag.dateModified = now;
    return true;
}

bool TagRepository::remove(int id) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("DELETE FROM Tag WHERE id=?");
    query.addBindValue(id);

    // Execute and get status
    if (!query.exec()) {
        qWarning() << "Delete failed:" << query.lastError();
        return false;
    }

    return true;
}