#pragma once
#include <QString>
#include <QJsonObject>

struct Settings {

    int theme = 1;

    int editorFontSize = 10;
    int editorFontFamily = 1;
    bool lineNumbers = true;
    bool syntaxHighlighting = true;

    bool wrapLines = true;
    bool confrimBeforeDelete = true;
    int tabSize = 4;
    QString defaultLanguage = "cpp";

    QString defaultSortMethod = "dateModified";
    int defaultSnippetFolder = 1;

    QString exportLocation = "./";
    QString exportFormat = "txt";

    QString importLocation = "./";
    QString conflictHandling = "ask";

    Settings() {}

    //convert struct to JSON
    QJsonObject toJson() const {
        QJsonObject obj;
        obj["theme"] = theme;

        obj["editorFontSize"] = editorFontSize;
        obj["editorFontFamily"] = editorFontFamily;
        obj["lineNumbers"] = lineNumbers;
        obj["syntaxHighlighting"] = syntaxHighlighting;

        obj["wrapLines"] = wrapLines;
        obj["confrimBeforeDelete"] = confrimBeforeDelete;
        obj["tabSize"] = tabSize;
        obj["defaultLanguage"] = defaultLanguage;

        obj["defaultSortMethod"] = defaultSortMethod;
        obj["defaultSnippetFolder"] = defaultSnippetFolder;

        obj["exportLocation"] = exportLocation;
        obj["exportFormat"] = exportFormat;

        obj["importLocation"] = importLocation;
        obj["conflictHandling"] = conflictHandling;

        return obj;
    }

    //convert JSON to struct
    static Settings fromJson(const QJsonObject &obj) {
        Settings s;
        s.theme = obj["theme"].toInt();

        s.editorFontSize = obj["editorFontSize"].toInt();
        s.editorFontFamily = obj["editorFontFamily"].toInt();
        s.lineNumbers = obj["lineNumbers"].toBool();
        s.syntaxHighlighting = obj["syntaxHighlighting"].toBool();

        s.wrapLines = obj["wrapLines"].toBool();
        s.confrimBeforeDelete = obj["confrimBeforeDelete"].toBool();
        s.tabSize = obj["tabSize"].toInt();
        s.defaultLanguage = obj["defaultLanguage"].toString();

        s.defaultSortMethod = obj["defaultSortMethod"].toString();
        s.defaultSnippetFolder = obj["defaultSnippetFolder"].toInt();

        s.exportLocation = obj["exportLocation"].toString();
        s.exportFormat = obj["exportFormat"].toString();

        s.importLocation = obj["importLocation"].toString();
        s.conflictHandling = obj["conflictHandling"].toString();

        return s;
    }
};