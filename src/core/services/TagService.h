/**
 *        @file: SnippetsService.h
 *      @author: Davis Lewis
 *        @date: November 03, 2025
 *       @brief: Tag Service. Call this from QML
 */

#pragma once

#include <QObject>
#include <QSqlDatabase>

#include "../models/Tag.h"
#include "../objects/TagListModel.h"
#include "../objects/TagObject.h"
#include "../repositories/SnippetRepository.h"

class TagService : public QObject {
    Q_OBJECT
    Q_PROPERTY(TagListModel* tags READ tags CONSTANT)

    public:
        explict TagService(QObject* parent = nullptr);

        //QML methods
        SnippetListModel* tag() { return &m_tagModel; }
        Q_INVOKABLE void createTag(const QString& name);
        Q_INVOKABLE void deleteTag(int id);
        Q_INVOKABLE void updateTag(int id, const QString& name);

    private:
        void loadTagsFromDb();

        QSqlDatabase m_db;
        TagRepository* m_repo;
        TagListModel m_tagModel; // the list mnodel its resposible for
}
