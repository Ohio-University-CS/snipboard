/**
 *        @file: FolderRepository.cpp
 *      @author: Davis Lewis
 *        @date: November 03, 2025
 *       @brief: SQL queries
 */

#include "FolderRepository.h"

#include <QSqlError>
#include <QSqlQuery>

FolderRepository::FolderRepository(QSqlDatabase db) : m_db(std::move(db)) {}

QVector<Folder> FolderRepository::loadAll() {
    // Create query
    QVector<Folder> result;
    QSqlQuery query(m_db);
    if (!query.exec("SELECT id, name, dateCreated, dateModified, parentFolder FROM Folder")) {
        qWarning() << "Failed to load folder: " << query.lastError();
        return result;
    }

    // While there are results, create a Folder and add to result QVector
    while (query.next()) {
        Folder f;
        f.id = query.value(0).toInt();
        f.name = query.value(1).toString();
        f.dateCreated = query.value(2).toDateTime();
        f.dateModified = query.value(3).toDateTime();
        f.parentFolderId = query.value(4).toInt();
        result.append(f);
    }

    return result;
}

Folder FolderRepository::loadById(int id) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("SELECT id, name, dateCreated, dateModified, parentFolder FROM Folder WHERE id = ?");
    query.addBindValue(id);

    // Execute and warn if error
    if (!query.exec() || !query.next()) {
        qWarning() << "Failed to load folder by id:" << query.lastError();
        return {};
    }

    // Populate snippet with query results
    Folder f;
    f.id = query.value(0).toInt();
    f.name = query.value(1).toString();
    f.dateCreated = query.value(2).toDateTime();
    f.dateModified = query.value(3).toDateTime();
    f.parentFolderId = query.value(4).toInt();

    return f;
}

bool FolderRepository::insert(Folder& folder) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare(
        "INSERT INTO Folder (name, parentFolder) "
        "VALUES (?, ?)");
    query.addBindValue(folder.name);
    query.addBindValue(folder.parentFolderId);

    // Return false if insertion failed
    if (!query.exec()) {
        qWarning() << "Insert failed:" << query.lastError();
        return false;
    }

    // Update folder's id and return true
    folder.id = query.lastInsertId().toInt();
    return true;
}

bool FolderRepository::update(Folder& folder) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("UPDATE Folder SET name=?, parentFolder=?, dateModified=? WHERE id=?");
    query.addBindValue(folder.name);
    query.addBindValue(folder.parentFolderId);
    QDateTime now = QDateTime::currentDateTimeUtc();
    query.addBindValue(now);
    query.addBindValue(folder.id);

    // Execute and get status
    if (!query.exec()) {
        qWarning() << "Update failed:" << query.lastError();
        return false;
    }

    folder.dateModified = now;
    return true;
}

bool FolderRepository::remove(int id) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("DELETE FROM Folder WHERE id=?");
    query.addBindValue(id);

    // Execute and get status
    if (!query.exec()) {
        qWarning() << "Delete failed:" << query.lastError();
        return false;
    }

    return true;
}