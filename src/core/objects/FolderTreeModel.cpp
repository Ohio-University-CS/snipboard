/**
 *        @file: FolderTreeModel.cpp
 *      @author: Kyle Carey
 *        @date: October 26, 2025
 *       @brief: Implementation of FolderTreeModel
 */

#include "FolderTreeModel.h"

FolderTreeModel::FolderTreeModel(QObject* parent) : QAbstractItemModel(parent) {
    m_root = new TreeNode(nullptr, nullptr);
}

FolderTreeModel::~FolderTreeModel() {
    beginResetModel();
    deleteTreeNodes(m_root);
    m_root = nullptr;
    m_index.clear();
    endResetModel();
}

QModelIndex FolderTreeModel::index(int row, int column, const QModelIndex& parent) const {
    // Return default if not found (at any point in time here)
    if (column != 0) {
        return QModelIndex();
    }

    // Get parent
    TreeNode* parentNode = m_root;
    if (parent.isValid()) {
        parentNode = static_cast<TreeNode*>(parent.internalPointer());
        if (!parentNode) {
            return QModelIndex();
        }
    }

    if (row < 0 || row >= parentNode->children.size()) {
        return QModelIndex();
    }

    TreeNode* child = parentNode->children.at(row);
    return createIndex(row, column, child);
}

QModelIndex FolderTreeModel::parent(const QModelIndex& index) const {
    if (!index.isValid()) {
        return QModelIndex();
    }

    // Grab node
    TreeNode* node = static_cast<TreeNode*>(index.internalPointer());
    if (!node || node->parent == nullptr || node->parent == m_root) {
        return QModelIndex();
    }

    // Get parent/grandparent Nodes. Return default if grandparent DNE
    TreeNode* parentNode = node->parent;
    TreeNode* grandParent = parentNode->parent;
    if (!grandParent) {
        return QModelIndex();
    }

    int row = indexOfChild(grandParent, parentNode);
    if (row < 0) {
        return QModelIndex();
    }

    return createIndex(row, 0, parentNode);
}

int FolderTreeModel::rowCount(const QModelIndex& parent) const {
    // Return rows (if they exist)
    if (!parent.isValid()) {
        return m_root ? m_root->children.size() : 0;
    }

    // Redundancy
    TreeNode* parentNode = static_cast<TreeNode*>(parent.internalPointer());
    if (!parentNode) {
        return 0;
    }

    return parentNode->children.size();
}

QVariant FolderTreeModel::data(const QModelIndex& index, int role) const {
    if (!index.isValid()) {
        return {};
    }

    // Grab the clicked folder, and return the data based on the role
    TreeNode* node = static_cast<TreeNode*>(index.internalPointer());
    if (!node || !node->folder) {
        return {};
    }

    switch (role) {
        case NameRole:
            return node->folder->name();
        case IdRole:
            return node->folder->id();
        case ParentIdRole:
            return node->parent && node->parent->folder ? node->parent->folder->id() : -1;
        case FolderObjectRole:
            return QVariant::fromValue(static_cast<QObject*>(node->folder));
        default:
            return {};
    }
}

QHash<int, QByteArray> FolderTreeModel::roleNames() const {
    // Map roles to QML properties (ex. folder.name in QML equates to NameRole here)
    return {
        {IdRole, "id"},
        {NameRole, "name"},
        {ParentIdRole, "parentId"},
        {FolderObjectRole, "folderObject"}};
}

void FolderTreeModel::setRootFolders(const QList<FolderObject*>& rootFolders) {
    beginResetModel();
    // Delete all nodes from old tree and reset index -> node mapping
    deleteTreeNodes(m_root);
    m_root = new TreeNode(nullptr, nullptr);
    m_index.clear();

    for (FolderObject* f : rootFolders) {
        TreeNode* node = createNode(f, m_root);
        m_root->children.append(node);
        m_index.insert(f->id(), node);
    }
    endResetModel();
}

void FolderTreeModel::clear() {
    beginResetModel();
    deleteTreeNodes(m_root);
    m_root = new TreeNode(nullptr, nullptr);
    m_index.clear();
    endResetModel();
}

QModelIndex FolderTreeModel::indexForFolderId(int folderId) const {
    TreeNode* n = findNodeByFolderId(folderId);
    if (!n) return QModelIndex();
    return idxFromNode(n);
}

void FolderTreeModel::onFolderAdded(FolderObject* folder) {
    // Add to root
    insertNode(m_root, m_root->children.size(), createNode(folder, m_root));
    m_index.insert(folder->id(), findNodeByFolderId(folder->id()));
}

void FolderTreeModel::onFolderAddedUnder(int parentFolderId, FolderObject* folder) {
    // Get parent node, else set it to root
    TreeNode* parentNode = findNodeByFolderId(parentFolderId);
    if (!parentNode) {
        parentNode = m_root;
    }

    // Insert the folder and update mapping
    insertNode(parentNode, parentNode->children.size(), createNode(folder, parentNode));
    m_index.insert(folder->id(), findNodeByFolderId(folder->id()));
}

void FolderTreeModel::onFolderRemoved(int folderId) {
    // Find TreeNode of folderId
    TreeNode* node = findNodeByFolderId(folderId);
    if (!node) {
        return;
    }

    // Remove node from folder
    removeNode(node);
    m_index.remove(folderId);
}

void FolderTreeModel::onFolderUpdated(int folderId, FolderObject* updatedFolder) {
    // Get node
    TreeNode* node = findNodeByFolderId(folderId);
    if (!node || !node->folder) {
        return;
    }

    // Replace pointer, update index if id changed
    int oldId = node->folder->id();
    node->folder = updatedFolder;
    if (oldId != updatedFolder->id()) {
        m_index.remove(oldId);
        m_index.insert(updatedFolder->id(), node);
    }

    // UI Changing signals
    QModelIndex idx = idxFromNode(node);
    emit dataChanged(idx, idx);
}

void FolderTreeModel::onFolderMoved(int folderId, int newParentFolderId, int newPosition) {
    // Get node
    TreeNode* node = findNodeByFolderId(folderId);
    if (!node || !node->parent) {
        return;
    }

    // Grab oldParent and newParent folder
    TreeNode* oldParent = node->parent;
    TreeNode* newParent = findNodeByFolderId(newParentFolderId);
    if (!newParent) {
        newParent = m_root;
    }

    int oldIndex = indexOfChild(oldParent, node);
    if (oldIndex < 0) {
        return;
    }

    // Update model
    QModelIndex oldParentIndex = idxFromNode(oldParent);
    beginRemoveRows(oldParentIndex, oldIndex, oldIndex);
    oldParent->children.removeAt(oldIndex);
    node->parent = nullptr;
    endRemoveRows();

    int pos = newPosition;
    if (pos < 0 || pos > newParent->children.size()) {
        pos = newParent->children.size();
    }

    insertNode(newParent, pos, node);
}

FolderTreeModel::TreeNode* FolderTreeModel::createNode(FolderObject* folder, TreeNode* parent) {
    TreeNode* n = new TreeNode(folder, parent);
    return n;
}

void FolderTreeModel::deleteTreeNodes(TreeNode* node) {
    if (!node) {
        return;
    }

    // Recursively call to delete all children nodes
    for (TreeNode* c : node->children) {
        deleteTreeNodes(c);
    }

    node->children.clear();
    delete node;
}

FolderTreeModel::TreeNode* FolderTreeModel::findNodeByFolderId(int folderId) const {
    // Iterate over the mapping, return TreeNode* once found
    auto it = m_index.find(folderId);
    if (it != m_index.end()) {
        return it.value();
    }

    return nullptr;
}

int FolderTreeModel::indexOfChild(TreeNode* parent, TreeNode* child) const {
    if (!parent) {
        return -1;
    }

    // Iterate over children returning the index if found
    for (int i = 0; i < parent->children.size(); i++) {
        if (parent->children.at(i) == child) {
            return i;
        }
    }

    return -1;
}

void FolderTreeModel::insertNode(TreeNode* parentNode, int position, TreeNode* node) {
    // Fix data if invalid
    if (!parentNode) {
        parentNode = m_root;
    }

    if (position < 0) {
        position = 0;
    }

    if (position > parentNode->children.size()) {
        position = parentNode->children.size();
    }

    // Insert TreeNode
    QModelIndex parentIndex = idxFromNode(parentNode);
    beginInsertRows(parentIndex, position, position);
    parentNode->children.insert(position, node);
    node->parent = parentNode;
    endInsertRows();

    // Add to mapping
    if (node->folder) {
        m_index.insert(node->folder->id(), node);
    }
}

void FolderTreeModel::removeNode(TreeNode* node) {
    if (!node || !node->parent) {
        return;
    }

    // Grab index
    TreeNode* parentNode = node->parent;
    int pos = indexOfChild(parentNode, node);
    if (pos < 0) {
        return;
    }

    // Remove
    QModelIndex parentIndex = idxFromNode(parentNode);
    beginRemoveRows(parentIndex, pos, pos);
    parentNode->children.removeAt(pos);
    endRemoveRows();
    removeNodeRecursively(node);
}

void FolderTreeModel::removeNodeRecursively(TreeNode* node) {
    if (!node) return;

    // Remove from index
    if (node->folder) {
        m_index.remove(node->folder->id());
    }

    // Recurse into children
    for (TreeNode* child : node->children) {
        removeNodeRecursively(child);
    }

    // Delete the TreeNode itself
    delete node;
}

QModelIndex FolderTreeModel::idxFromNode(TreeNode* node) const {
    // Return standard from here out
    if (!node || node == m_root) {
        return QModelIndex();
    }

    // Get parent node
    TreeNode* parentNode = node->parent;
    if (!parentNode) {
        return QModelIndex();
    }

    int row = indexOfChild(parentNode, node);
    if (row < 0) {
        return QModelIndex();
    }

    return createIndex(row, 0, node);
}
