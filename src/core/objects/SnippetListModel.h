/**
 *        @file: SnippetListModel.h
 *      @author: Kyle Carey
 *        @date: October 26, 2025
 *       @brief: List Model for Snippets used by QML UI.
 *
 *   Note: This model does NOT modify the database. It simply reflects
 *   state owned and controlled by SnippetService.
 */

#pragma once

#include <QAbstractListModel>

#include "SnippetObject.h"

class SnippetListModel : public QAbstractListModel {
    Q_OBJECT

 public:
    // Roles for QML
    enum Roles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        DescriptionRole,
        LanguageRole,
        DataRole,
        FolderRole,
        FavoriteRole,
        TimesCopiedRole,
        TagNamesRole
    };
    Q_ENUM(Roles)

    explicit SnippetListModel(QObject* parent = nullptr);

    // Model configuration
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    // Set the snippets
    void setSnippets(const QList<SnippetObject*>& snippets);
    const QList<SnippetObject*>& viewSnippets() const { return m_snippets; }

    // QML read access
    Q_INVOKABLE SnippetObject* get(int index) const;

 public slots:
    // Called by SnippetService
    void onSnippetAdded(SnippetObject* snippet);
    void onSnippetDeleted(int id);
    void onSnippetUpdated(int id, SnippetObject* updatedSnippet);

 private:
    // Internal helpers (these will update the UI when snippetService calls a slot)
    void addSnippet(SnippetObject* snippet);
    void removeSnippet(int id);
    void updateSnippetById(int id, SnippetObject* updatedSnippet);
    QList<SnippetObject*> m_snippets;
};
