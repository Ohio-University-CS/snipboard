/**
 *        @file: SnippetsService.h
 *      @author: Kyle Carey
 *        @date: November 02, 2025
 *       @brief: Snippet Service. Call this from QML
 */

#pragma once

#include <QObject>
#include <QSqlDatabase>

#include "../models/Snippet.h"
#include "../objects/SnippetListModel.h"
#include "../objects/SnippetObject.h"
#include "../repositories/SnippetRepository.h"
#include "../objects/TagObject.h"

class SnippetService : public QObject {
    Q_OBJECT
    Q_PROPERTY(SnippetListModel* snippets READ snippets CONSTANT)

 public:
    explicit SnippetService(QObject* parent = nullptr);

    
    // QML methods
    SnippetListModel* snippets() { return &m_snippetModelFiltered; }
    Q_INVOKABLE void createSnippet(const QString& name, const QString& description, const QString& language, const QString& contents, int folder, bool favorite);
    Q_INVOKABLE void deleteSnippet(int id);
    Q_INVOKABLE void updateSnippet(int id, const QString& name, const QString& description, const QString& language, const QString& contents, int folder, bool favorite);
    Q_INVOKABLE void reload();
    Q_INVOKABLE void search(const QString& phrase = "");
    Q_INVOKABLE void addSearchTag(const TagObject& tag);
    Q_INVOKABLE void removeSearchTag(const TagObject& tag);
    Q_INVOKABLE void addSearchLanguage(const QString& language);
    Q_INVOKABLE void removeSearchLanguage(const QString& language);
    Q_INVOKABLE void incrementSnippet(int id);

 private:
    void loadSnippetsFromDb();
    // TODO: add search phrase to store here so we can accurately add back to DB
    QSqlDatabase m_db;
    SnippetRepository* m_repo;
    SnippetListModel m_snippetModel; // list model that is all snippets in current folder (all snippets in general right now i believe)
    SnippetListModel m_snippetModelFiltered; // the list model its responsible for
};
