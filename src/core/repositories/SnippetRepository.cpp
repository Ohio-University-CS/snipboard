/**
 *        @file: SnippetsRepository.cpp
 *      @author: Kyle Carey
 *        @date: November 02, 2025
 *       @brief: SQL queries
 */

#include "SnippetRepository.h"

#include <QSqlError>
#include <QSqlQuery>

SnippetRepository::SnippetRepository(QSqlDatabase db) : m_db(std::move(db)) {}

QVector<Snippet> SnippetRepository::loadAll() {
    // Create query
    QVector<Snippet> result;
    QSqlQuery query(m_db);
    if (!query.exec("SELECT id, name, dateCreated, dateModified, description, language, contents, folder, favorite, timesCopied FROM Snippet")) {
        qWarning() << "Failed to load snippets: " << query.lastError();
        return result;
    }

    // While there are results, create a Snippet and add to result QVector
    while (query.next()) {
        Snippet s;
        s.id = query.value(0).toInt();
        s.name = query.value(1).toString();
        s.dateCreated = query.value(2).toDateTime();
        s.dateModified = query.value(3).toDateTime();
        s.description = query.value(4).toString();
        s.language = query.value(5).toString();
        s.contents = query.value(6).toString();
        s.folder = query.value(7).toInt();
        s.favorite = query.value(8).toBool();
        s.timesCopied = query.value(9).toInt();
        result.append(s);
    }

    return result;
}

Snippet SnippetRepository::loadById(int id) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("SELECT id, name, dateCreated, dateModified, description, language, contents, folder, favorite, timesCopied FROM Snippet WHERE id = ?");
    query.addBindValue(id);

    // Execute and warn if error
    if (!query.exec() || !query.next()) {
        qWarning() << "Failed to load snippet by id:" << query.lastError();
        return {};
    }

    // Populate snippet with query results
    Snippet s;
    s.id = query.value(0).toInt();
    s.name = query.value(1).toString();
    s.dateCreated = query.value(2).toDateTime();
    s.dateModified = query.value(3).toDateTime();
    s.description = query.value(4).toString();
    s.language = query.value(5).toString();
    s.contents = query.value(6).toString();
    s.folder = query.value(7).toInt();
    s.favorite = query.value(8).toBool();
    s.timesCopied = query.value(9).toInt();

    return s;
}

bool SnippetRepository::insert(Snippet& snippet) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare(
        "INSERT INTO Snippet (name, description, language, contents, folder, favorite) "
        "VALUES (?, ?, ?, ?, ?, ?)");
    query.addBindValue(snippet.name);
    query.addBindValue(snippet.description);
    query.addBindValue(snippet.language);
    query.addBindValue(snippet.contents);
    query.addBindValue(snippet.folder);
    query.addBindValue(snippet.favorite);

    // Return false if insertion failed
    if (!query.exec()) {
        qWarning() << "Insert failed:" << query.lastError();
        return false;
    }

    // Update snippet's id and return true
    snippet.id = query.lastInsertId().toInt();
    return true;
}

bool SnippetRepository::update(Snippet& snippet) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("UPDATE snippets SET name=?, description=?, language=?, contents=?, folder=?, favorite=?, timesCopied=?, dateModified=? WHERE id=?");
    query.addBindValue(snippet.name);
    query.addBindValue(snippet.description);
    query.addBindValue(snippet.language);
    query.addBindValue(snippet.contents);
    query.addBindValue(snippet.folder);
    query.addBindValue(snippet.favorite);
    query.addBindValue(snippet.timesCopied);
    QDateTime now = QDateTime::currentDateTimeUtc();
    query.addBindValue(now);
    query.addBindValue(snippet.id);

    // Execute and get status
    if (!query.exec()) {
        qWarning() << "Update failed:" << query.lastError();
        return false;
    }

    snippet.dateModified = now;
    return true;
}

bool SnippetRepository::remove(int id) {
    // Create query
    QSqlQuery query(m_db);
    query.prepare("DELETE FROM snippets WHERE id=?");
    query.addBindValue(id);

    // Execute and get status
    if (!query.exec()) {
        qWarning() << "Delete failed:" << query.lastError();
        return false;
    }

    return true;
}