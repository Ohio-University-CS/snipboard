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
    QVector<Snippet> result;
    QSqlQuery query(m_db);
    
    if (!query.exec("SELECT id, name, dateCreated, dateModified, description, language, contents, folder, favorite, timesCopied FROM Snippet")) {
        qWarning() << "Failed to load snippets: " << query.lastError();
        return result;
    }

    // Load all snippets first
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

    // Add tags
    for (Snippet &s : result) {
        QSqlQuery tagQuery(m_db);
        tagQuery.prepare(
            "SELECT t.name FROM Tag t "
            "INNER JOIN SnippetTagLink stl ON t.id = stl.tagId "
            "WHERE stl.snippetId = ?");
        tagQuery.addBindValue(s.id);

        if (!tagQuery.exec()) {
            qWarning() << "Failed to load tags: " << tagQuery.lastError();
            return result;
        }

        while (tagQuery.next()) {
            s.tagNames.push_back(tagQuery.value(0).toString());
        }
    }

    return result;
}

QVector<Snippet> SnippetRepository::loadAllFavorites() {
    // Create query
    QVector<Snippet> result;
    QSqlQuery query(m_db);
    if (!query.exec("SELECT id, name, dateCreated, dateModified, description, language, contents, folder, favorite, timesCopied FROM Snippet WHERE favorite = true")) {
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

    //tags
    for (Snippet &s : result) {
        QSqlQuery tagQuery(m_db);
        tagQuery.prepare(
            "SELECT t.name FROM Tag t "
            "INNER JOIN SnippetTagLink stl ON t.id = stl.tagId "
            "WHERE stl.snippetId = ?");
        tagQuery.addBindValue(s.id);

        if (!tagQuery.exec()) {
            qWarning() << "Failed to load tags: " << tagQuery.lastError();
            return result;
        }

        while (tagQuery.next()) {
            s.tagNames.push_back(tagQuery.value(0).toString());
        }
    }

    return result;
}

QVector<Snippet> SnippetRepository::loadByAnyTags(const QVector<int>& tagIds) {
    QVector<Snippet> result;

    if (tagIds.isEmpty()) {
        return result;
    }
    //? value placeholders
    QStringList placeholders;
    for (int i = 0; i < tagIds.size(); i++) {
        placeholders << "?";
    }

    QString sql =
        "SELECT DISTINCT Snippet.id, Snippet.name, Snippet.dateCreated, "
        "Snippet.dateModified, Snippet.description, Snippet.language, "
        "Snippet.contents, Snippet.folder, Snippet.favorite, Snippet.timesCopied "
        "FROM Snippet "
        "JOIN SnippetTagLink ON Snippet.id = SnippetTagLink.snippetId "
        "WHERE SnippetTagLink.tagId IN (" +
        placeholders.join(", ") + ")";

    QSqlQuery query(m_db);
    query.prepare(sql);

    for (int tagId : tagIds) {
        query.addBindValue(tagId);
    }

    if (!query.exec()) {
        qWarning() << "Failed to load snippets by ANY tag:" << query.lastError();
        return result;
    }

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

    //tags
    for (Snippet &s : result) {
        QSqlQuery tagQuery(m_db);
        tagQuery.prepare(
            "SELECT t.name FROM Tag t "
            "INNER JOIN SnippetTagLink stl ON t.id = stl.tagId "
            "WHERE stl.snippetId = ?");
        tagQuery.addBindValue(s.id);

        if (!tagQuery.exec()) {
            qWarning() << "Failed to load tags: " << tagQuery.lastError();
            return result;
        }

        while (tagQuery.next()) {
            s.tagNames.push_back(tagQuery.value(0).toString());
        }
    }

    return result;
}

QVector<Snippet> SnippetRepository::loadByAllTags(const QVector<int>& tagIds) {
    QVector<Snippet> result;

    if (tagIds.isEmpty()) {
        return result;
    }
    //? value placeholders
    QStringList placeholders;
    for (int i = 0; i < tagIds.size(); i++) {
        placeholders << "?";
    }

    QString sql = QString(
                      "SELECT Snippet.id, Snippet.name, Snippet.dateCreated, "
                      "Snippet.dateModified, Snippet.description, Snippet.language, "
                      "Snippet.contents, Snippet.folder, Snippet.favorite, Snippet.timesCopied "
                      "FROM Snippet "
                      "JOIN SnippetTagLink ON Snippet.id = SnippetTagLink.snippetId "
                      "WHERE SnippetTagLink.tagId IN (%1) "
                      "GROUP BY Snippet.id "
                      "HAVING COUNT(DISTINCT SnippetTagLink.tagId) = %2")
                      .arg(placeholders.join(", "))
                      .arg(tagIds.size());

    QSqlQuery query(m_db);
    query.prepare(sql);

    for (int tagId : tagIds) {
        query.addBindValue(tagId);
    }

    if (!query.exec()) {
        qWarning() << "Failed to load snippets by ALL tags:" << query.lastError();
        return result;
    }

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
    query.prepare("UPDATE Snippet SET name=?, description=?, language=?, contents=?, folder=?, favorite=?, timesCopied=?, dateModified=? WHERE id=?");
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
    query.prepare("DELETE FROM Snippet WHERE id=?");
    query.addBindValue(id);

    // Execute and get status
    if (!query.exec()) {
        qWarning() << "Delete failed:" << query.lastError();
        return false;
    }

    return true;
}

bool SnippetRepository::incrementCopied(int id) {
    QSqlQuery query(m_db);
    query.prepare("UPDATE Snippet SET timesCopied = timesCopied + 1 WHERE id = ?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Failed to increment times copied:" << query.lastError();
        return false;
    }

    return true;
}

bool SnippetRepository::favorite(int id) {
    QSqlQuery query(m_db);
    query.prepare("UPDATE Snippet SET favorite = true WHERE id = ?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Failed to favorite:" << query.lastError();
        return false;
    }

    return true;
}

bool SnippetRepository::unfavorite(int id) {
    QSqlQuery query(m_db);
    query.prepare("UPDATE Snippet SET favorite = false WHERE id = ?");
    query.addBindValue(id);

    if (!query.exec()) {
        qWarning() << "Failed to unfavorite:" << query.lastError();
        return false;
    }

    return true;
}

bool SnippetRepository::addTag(int snippetId, int tagId) {
    QSqlQuery query(m_db);
    query.prepare("INSERT INTO SnippetTagLink VALUES (?, ?)");
    query.addBindValue(snippetId);
    query.addBindValue(tagId);

    if (!query.exec()) {
        qWarning() << "Failed to unfavorite:" << query.lastError();
        return false;
    }

    return true;
}

bool SnippetRepository::removeTag(int snippetId, int tagId) {
    QSqlQuery query(m_db);
    query.prepare("DELETE FROM SnippetTagLink WHERE snippetId = ? AND tagId = ?");
    query.addBindValue(snippetId);
    query.addBindValue(tagId);

    if (!query.exec()) {
        qWarning() << "Failed to unfavorite:" << query.lastError();
        return false;
    }

    return true;
}