/**
 *        @file: FolderTreeModel.h
 *      @author: Kyle Carey
 *        @date: October 26, 2025
 *       @brief: Folder tree model representing folders and snippets in a filesystem-like tree.
 *
 *  Model does NOT own FolderObject* pointers. Those are owned by the
 *  FolderService. This model owns TreeNode objects (lightweight nodes).
 */

#pragma once

#include <QAbstractItemModel>
#include <QHash>
#include <QVector>

#include "FolderObject.h"

class FolderTreeModel : public QAbstractItemModel {
    Q_OBJECT
    Q_DISABLE_COPY(FolderTreeModel)

 public:
    // Roles for QML
    enum Roles {
        NameRole = Qt::UserRole + 1,
        IdRole,
        ParentIdRole,
        FolderObjectRole
    };
    Q_ENUM(Roles)

    explicit FolderTreeModel(QObject* parent = nullptr);
    ~FolderTreeModel() override;

    // Model configuration
    QModelIndex index(int row, int column, const QModelIndex& parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex& index) const override;
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    int columnCount(const QModelIndex& parent = QModelIndex()) const override {
        Q_UNUSED(parent);
        return 1;
    }
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // Set/clear folders
    void setRootFolders(const QList<FolderObject*>& rootFolders);
    void clear();

    // Find index by folder id
    QModelIndex indexForFolderId(int folderId) const;

 public slots:
    // Called by FolderService
    void onFolderAdded(FolderObject* folder);
    void onFolderAddedUnder(int parentFolderId, FolderObject* folder);
    void onFolderRemoved(int folderId);
    void onFolderUpdated(int folderId, FolderObject* updatedFolder);
    void onFolderMoved(int folderId, int newParentFolderId, int newPosition = -1);

 private:
    // Define TreeNode and set the root
    struct TreeNode {
        FolderObject* folder = nullptr;
        TreeNode* parent = nullptr;
        QVector<TreeNode*> children;
        explicit TreeNode(FolderObject* f = nullptr, TreeNode* p = nullptr) : folder(f), parent(p) {}
    };

    TreeNode* m_root = nullptr;
    QHash<int, TreeNode*> m_index;  // folderId -> TreeNode*

    // Helpers
    TreeNode* createNode(FolderObject* folder, TreeNode* parent);
    void deleteTreeNodes(TreeNode* node);
    TreeNode* findNodeByFolderId(int folderId) const;
    int indexOfChild(TreeNode* parent, TreeNode* child) const;
    void insertNode(TreeNode* parentNode, int position, TreeNode* node);
    void removeNode(TreeNode* node);
    void removeNodeRecursively(TreeNode* node);
    QModelIndex idxFromNode(TreeNode* node) const;
};
