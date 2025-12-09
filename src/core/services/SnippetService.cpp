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
    m_tagRepo = new TagRepository(m_db);  
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

int SnippetService::createSnippet(const QString& name, const QString& description, const QString& language, const QString& contents, int folder, bool favorite) {
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

        //returns id of snippet inserted
        return s.id;
    }
    else {
        return -1;
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
        //UPDATE FILTERED LIST 
        m_snippetModelFiltered.onSnippetUpdated(id, obj); 
    }
}

void SnippetService::toggleFavorite(int id) {
    Snippet s = m_repo->loadById(id);
    if (s.id == -1) {
        return;
    }

    s.favorite = !s.favorite;

    if (m_repo->update(s)) {
        auto* obj = new SnippetObject(s);
        m_snippetModel.onSnippetUpdated(id, obj);
        m_snippetModelFiltered.onSnippetUpdated(id, obj);
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

void SnippetService::incrementCopiedSnippet(int id) {
    // Call repository function to update database
    if (!m_repo->incrementCopied(id)) {
        qWarning() << "Failed to increment times copied in DB";
        return;
    }

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
    if (!m_repo->favorite(snippet.id())) {
        qWarning() << "Failed to favorite snippet in DB";
        return;
    }
    
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
    if (!m_repo->unfavorite(snippet.id())) {
        qWarning() << "Failed to remove favorite from snippet in DB";
        return;
    }

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

void SnippetService::loadAll() {
    loadSnippetsFromDb();
}

void SnippetService::loadFavoriteSnippets() {
    // Get all snippets
    auto all = m_repo->loadAllFavorites();
    QVector<SnippetObject*> objs;
    objs.reserve(all.size());

    // Create new SnippetObjects from Snippets returned from repo
    for (const Snippet& s : all) {
        objs.append(new SnippetObject(s));
    }

    m_snippetModel.setSnippets(objs);
    m_snippetModelFiltered.setSnippets(objs);
}

void SnippetService::loadAnyTags(const QVector<int>& tagIds) {
    // Get all snippets
    auto all = m_repo->loadByAnyTags(tagIds);
    QVector<SnippetObject*> objs;
    objs.reserve(all.size());

    // Create new SnippetObjects from Snippets returned from repo
    for (const Snippet& s : all) {
        objs.append(new SnippetObject(s));
    }

    m_snippetModel.setSnippets(objs);
    m_snippetModelFiltered.setSnippets(objs);
}

void SnippetService::loadAllTags(const QVector<int>& tagIds) {
    // Get all snippets
    auto all = m_repo->loadByAllTags(tagIds);
    QVector<SnippetObject*> objs;
    objs.reserve(all.size());

    // Create new SnippetObjects from Snippets returned from repo
    for (const Snippet& s : all) {
        objs.append(new SnippetObject(s));
    }

    m_snippetModel.setSnippets(objs);
    m_snippetModelFiltered.setSnippets(objs);
}

void SnippetService::addTagToSnippet(int id, const QString& tagName) {
    // call repo function
    int tagId = m_tagRepo->findIdByName(tagName);
    if (!m_repo->addTag(id, tagId)) {
        qWarning() << "Failed to add tag to snippet in DB";
        return;
    }

    auto snippets = m_snippetModel.viewSnippets();
    auto snippetsFiltered = m_snippetModelFiltered.viewSnippets();

    // update ui objects
    for (auto& s : snippets) {
        if (s->id() == id) {
            s->addTagName(tagName);
            break;
        }
    }

    for (auto& s : snippetsFiltered) {
        if (s->id() == id) {
            s->addTagName(tagName);
            break;
        }
    }
}

void SnippetService::removeTagFromSnippet(int id, const QString& tagName) {
    // call repo function
    int tagId = m_tagRepo->findIdByName(tagName);
    if (!m_repo->removeTag(id, tagId)) {
        qWarning() << "Failed to remove tag to snippet in DB";
        return;
    }

    auto snippets = m_snippetModel.viewSnippets();
    auto snippetsFiltered = m_snippetModelFiltered.viewSnippets();

    // update ui objects
    for (auto& s : snippets) {
        if (s->id() == id) {
            s->removeTagName(tagName);
            break;
        }
    }

    for (auto& s : snippetsFiltered) {
        if (s->id() == id) {
            s->removeTagName(tagName);
            break;
        }
    }
}

// I think for right now we just need to sort the filtered list... can easily change if needed
void SnippetService::sortByDateCreated(bool ascending) {
    m_snippetModelFiltered.sortByDateCreated(ascending);
}
void SnippetService::sortByDateModified(bool ascending) {
    m_snippetModelFiltered.sortByDateModified(ascending);
}
void SnippetService::sortByMostCopied(bool ascending) {
    m_snippetModelFiltered.sortByMostCopied(ascending);
}
void SnippetService::sortByName(bool alphabetical) {
    m_snippetModelFiltered.sortByName(alphabetical);
}
