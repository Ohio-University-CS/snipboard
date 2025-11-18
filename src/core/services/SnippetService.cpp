#include "SnippetService.h"

#include <QDateTime>
#include <QDebug>
#include <QSqlError>

SnippetService::SnippetService(QObject* parent) : QObject(parent) {
    // Initialize database
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName("snipboard.db");
    if (!m_db.open()) {
        qWarning() << "Failed to open DB:" << m_db.lastError();
    }

    qDebug() << "DB path:" << m_db.databaseName();
    qDebug() << "DB open:" << m_db.isOpen();

    // Create repository and load all snippets
    /* WE PROBABLY WANT TO UPDATE THIS TO JUST LOAD ALL SNIPPETS THAT BELONG TO HOME FOLDER */
    m_repo = new SnippetRepository(m_db);
    loadSnippetsFromDb();
}

void SnippetService::loadSnippetsFromDb() {
    // Get all snippets
    auto all = m_repo->loadAll();
    QVector<SnippetObject*> objs;
    objs.reserve(all.size());

    // Create new SnippetObjects from Snippets returned from repo
    for (const Snippet& s : all) {
        objs.append(new SnippetObject(s));
    }

    m_snippetModel.setSnippets(objs);
    m_snippetModelFiltered.setSnippets(objs);
}

void SnippetService::createSnippet(const QString& name, const QString& description, const QString& language, const QString& contents, int folder, bool favorite) {
    // Create snippet
    Snippet s;
    s.name = name;
    s.description = description;
    s.language = language;
    s.contents = contents;
    s.folder = folder;
    s.favorite = favorite;

    // Insert into DB. Update ListView
    if (m_repo->insert(s)) {
        auto* obj = new SnippetObject(s);
        m_snippetModel.onSnippetAdded(obj);
        m_snippetModelFiltered.onSnippetAdded(obj);
    }
}

void SnippetService::deleteSnippet(int id) {
    // Remove snippet
    qDebug() << id;
    if (m_repo->remove(id)) {
        m_snippetModel.onSnippetDeleted(id);
        m_snippetModelFiltered.onSnippetDeleted(id);
    }
}

void SnippetService::updateSnippet(int id, const QString& name, const QString& description, const QString& language, const QString& contents, int folder, bool favorite) {
    // Get current snippet
    Snippet s = m_repo->loadById(id);
    if (s.id == -1) {
        return;
    }

    s.name = name;
    s.description = description;
    s.language = language;
    s.contents = contents;
    s.folder = folder;
    s.favorite = favorite;
    // s.dateModified = QDateTime::currentDateTime(); // shouldnt need this repo takes care of it..

    if (m_repo->update(s)) {
        auto* obj = new SnippetObject(s);
        m_snippetModel.onSnippetUpdated(id, obj);
    }
}

void SnippetService::reload() {
    loadSnippetsFromDb();
}

void SnippetService::search(const QString& phrase) {
    const auto snippets = m_snippetModel.viewSnippets();

    QVector<SnippetObject*> results;
    for (const auto& s : snippets) {
        if (s->name().contains(phrase, Qt::CaseInsensitive)) {
            results.push_back(s);
        }
    }

    m_snippetModelFiltered.setSnippets(results);
}

void SnippetService::addSearchTag(const TagObject& tag) {
    const auto snippets = m_snippetModelFiltered.viewSnippets();

    // iterate over each snippet in the already filtered list
    for (const auto& s : snippets) {
        // get tags name associated with each snippet and if names match, remove it
        auto snippetTags = s->tagNames();
        for (const auto& snippetTag : snippetTags) {
            if (tag.name().toLower() == snippetTag.toLower()) {
                m_snippetModelFiltered.onSnippetDeleted(tag.id());
                break;
            }
        }
    }
}

void SnippetService::removeSearchTag(const TagObject& tag) {
    const auto snippets = m_snippetModel.viewSnippets();

    // iterate over ALL snippets and add it if tag.name() matches a name of the snippet tag
    for (const auto& s : snippets) {
        auto snippetTags = s->tagNames();
        for (const auto& snippetTag : snippetTags) {
            if (tag.name().toLower() == snippetTag.toLower()) {
                m_snippetModelFiltered.onSnippetAdded(s);
                break;
            }
        }
    }
}

void SnippetService::addSearchLanguage(const QString& language) {
    const auto snippets = m_snippetModelFiltered.viewSnippets();

    for (const auto& s : snippets) {
        if (s->language().toLower() == language.toLower()) {
            m_snippetModelFiltered.onSnippetDeleted(s->id());
        }
    }
}

void SnippetService::removeSearchLanguage(const QString& language) {
    const auto snippets = m_snippetModel.viewSnippets();

    for (const auto& s : snippets) {
        if (s->language().toLower() == language.toLower()) {
            m_snippetModelFiltered.onSnippetAdded(s);
        }
    }
}

void SnippetService::incrementSnippet(int id) {
    // Call repository function to update database

    // update ui
    const auto snippets = m_snippetModel.viewSnippets();

    for (auto& s : snippets) {
        if (s->id() == id) {
            s->setTimesCopied(s->timesCopied() + 1);
            break;
        }
    }
}

void SnippetService::favoriteSnippet(const SnippetObject& snippet) {
    // call repo function
    
    auto snippets = m_snippetModel.viewSnippets();
    auto snippetsFiltered = m_snippetModelFiltered.viewSnippets();

    // update UI
    for (auto& s : snippets) {
        if (s->id() == snippet.id()) {
            s->setFavorite(true);
            break;
        }
    }

    for (auto& s : snippetsFiltered) {
        if (s->id() == snippet.id()) {
            s->setFavorite(true);
            break;
        }
    }
}

void SnippetService::removeFavoriteSnippet(const SnippetObject& snippet) {
    // call repo function
    auto snippets = m_snippetModel.viewSnippets();
    auto snippetsFiltered = m_snippetModelFiltered.viewSnippets();

    for (auto& s : snippets) {
        if (s->id() == snippet.id()) {
            s->setFavorite(false);
            break;
        }
    }

    for (auto& s : snippetsFiltered) {
        if (s->id() == snippet.id()) {
            s->setFavorite(false);
            break;
        }
    }
}
