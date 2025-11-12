#pragma once

#include <QObject>
#include <QGuiApplication>
#include <QClipboard>

class ClipboardHelper : public QObject {
    Q_OBJECT
public:
    using QObject::QObject;

    Q_INVOKABLE void copyText(const QString& s) const {
        if (auto *cb = QGuiApplication::clipboard()) {
            cb->setText(s, QClipboard::Clipboard);   // primary clipboard
#ifdef Q_OS_LINUX
            cb->setText(s, QClipboard::Selection);   // middle-click selection (Linux)
#endif
        }
    }
};