/**
 *        @file: SnippetsService.h
 *      @author: Kyle Carey
 *        @date: November 02, 2025
 *       @brief: Snippet Service. Call this from QML
 */

#pragma once

#include <QObject>
#include <QSqlDatabase>
#include <algorithm>

#include "../models/Snippet.h"
#include "../objects/SnippetListModel.h"
#include "../objects/SnippetObject.h"
#include "../repositories/SnippetRepository.h"
#include "../repositories/TagRepository.h"
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
    Q_INVOKABLE void incrementCopiedSnippet(int id);
    Q_INVOKABLE void favoriteSnippet(const SnippetObject& snippet);
    Q_INVOKABLE void removeFavoriteSnippet(const SnippetObject& snippet);
    Q_INVOKABLE void addTagToSnippet(int id, const QString& tagName);
    Q_INVOKABLE void removeTagFromSnippet(int id, const QString& tagName);
    Q_INVOKABLE void toggleFavorite(int id);
    Q_INVOKABLE void reload();
    Q_INVOKABLE void loadAll();
    Q_INVOKABLE void loadFavoriteSnippets();
    Q_INVOKABLE void loadAnyTags(const QVector<int>& tagIds);
    Q_INVOKABLE void loadAllTags(const QVector<int>& tagIds);

    // Searching functions
    Q_INVOKABLE void search(const QString& phrase = "");
    Q_INVOKABLE void addSearchTag(const TagObject& tag);
    Q_INVOKABLE void removeSearchTag(const TagObject& tag);
    Q_INVOKABLE void addSearchLanguage(const QString& language);
    Q_INVOKABLE void removeSearchLanguage(const QString& language);

    // Sorting functions
    Q_INVOKABLE void sortByDateCreated(bool ascending = true);
    Q_INVOKABLE void sortByDateModified(bool ascending = true);
    Q_INVOKABLE void sortByMostCopied(bool ascending = false);
    Q_INVOKABLE void sortByName(bool alphabetical = true);


 private:
    void loadSnippetsFromDb();
    // TODO: add search phrase to store here so we can accurately add back to DB
    QSqlDatabase m_db;
    SnippetRepository* m_repo;
    TagRepository* m_tagRepo;
    SnippetListModel m_snippetModel; // list model that is all snippets in current folder (all snippets in general right now i believe)
    SnippetListModel m_snippetModelFiltered; // the list model its responsible for
};
