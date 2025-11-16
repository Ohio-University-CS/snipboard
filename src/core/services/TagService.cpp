#include "TagService.h"

#include <QDateTime>
#include <QDebug>
#include <QSqlError>

TagService::TagService(QObject* parent) : QObject(parent) {
    // Initialize databse
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName("snipboard.db");
    if (!m_db.open()) {
        qWarning() << "Failed to open DB:" << m_db.lastError();
    }

    qDebug() << "DB path:" << m_db.databaseName();
    qDebug() << "DB open:" << m_db.isOpen();

    // Create repository and load all tags
    /* WE PROBABLY WANT TO UPDATE THIS TO JUST LOAD ALL TAGS THAT BELONG TO HOME FOLDER */
    m_repo = new TagRepository(m_db);
    loadTagsFromDb();
}

void TagService::loadTagsFromDb() {
    // Get all tags
    auto all = m_repo->loadAll();
    QVector<TagObject*> objs;
    objs.reserve(all.size());

    // Create new TagObjects from Tags returned from repo
    for (const Tag& t : all) {
        objs.append(new TagObject(t));
    }

    m_tagModel.setTags(objs);
}

void TagService::createTag(const QString& name) {
    // Create tag
    Tag t;
    t.name = name;

    // Insert into DB. Update ListView
    if (m_repo->insert(t)) {
        auto* obj = new TagObject(t);
        m_tagModel.onTagAdded(obj);
    }
}

void TagService::deleteTag(int id) {
    // Remove tag
    qDebug() << id;
    if (m_repo->remove(id)) {
        m_tagModel.onTagDeleted(id);
    }
}

void TagService::updateTag(int id, const QString& name) {
    // Get current tag
    Tag t = m_repo->loadById(id);
    if (t.id == -1) {
        return;
    }

    t.name = name;
    // t.dateModified = QDateTime::currentDateTime(); // shouldnt need this repo takes care of it..

    if (m_repo->update(t)) {
        auto* obj = new TagObject(t);
        m_tagModel.onTagUpdated(id, obj);
    }
}