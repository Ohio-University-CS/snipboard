#include "FolderService.h"

#include <QDateTime>
#include <QDebug>
#include <QSqlError>

FolderService::FolderService(QObject* parent) : QObject(parent) {
    // Initialize database
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName("snipboard.db");
    if (!m_db.open()) {
        qWarning() << "Failed to open DB:" << m_db.lastError();
    }

    qDebug() << "DB path:" << m_db.databaseName();
    qDebug() << "DB open:" << m_db.isOpen();

    // Create repository and load all folders
    m_repo = new FolderRepository(m_db);
    loadFoldersFromDb();
}

void FolderService::loadFoldersFromDb() {
    // Get all folders
    auto all = m_repo->loadAll();
    QVector<FolderObject*> objs;
    objs.reserve(all.size());

    // Create new FolderObjects from Folders returned from repo
    for (const Folder& f : all) {
        objs.append(new FolderObject(f));
    }

    m_folderModel.setRootFolders(objs);
}

void FolderService::createFolder(const QString& name, const int parentFolderId) {
    // Create folder
    Folder f;
    f.name = name;
    f.parentFolderId = parentFolderId;

    // Insert into DB. Update ListView
    if (m_repo->insert(f)) {
        auto* obj = new FolderObject(f);
        m_folderModel.onFolderAdded(obj);
    }
}

void FolderService::deleteFolder(int id) {
    // Remove snippet
    qDebug() << id;
    if (m_repo->remove(id)) {
        m_folderModel.onFolderRemoved(id);
    }
}

void FolderService::updateFolder(int id, const QString& name, const int parentFolderId) {
    // Get current folder
    Folder f = m_repo->loadById(id);
    if (f.id == -1) {
        return;
    }

    f.name = name;
    f.parentFolderId = parentFolderId;
    // f.dateModified = QDateTime::currentDateTime(); // shouldnt need this repo takes care of it..

    if (m_repo->update(f)) {
        auto* obj = new FolderObject(f);
        m_folderModel.onFolderUpdated(id, obj);
    }
}
