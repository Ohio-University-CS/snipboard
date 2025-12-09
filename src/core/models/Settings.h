#pragma once
#include <QString>
#include <QJsonObject>

struct Settings {

    int theme = 1;

    bool confirmBeforeDelete = true;
    QString defaultLanguage = "cpp";

    QString defaultSortMethod = "Last Edited (Newest)";


    Settings() {}

    //convert struct to JSON
    QJsonObject toJson() const {
        QJsonObject obj;
        obj["theme"] = theme;
        obj["confirmBeforeDelete"] = confirmBeforeDelete;
        obj["defaultLanguage"] = defaultLanguage;
        obj["defaultSortMethod"] = defaultSortMethod;

        return obj;
    }

    //convert JSON to struct
    static Settings fromJson(const QJsonObject &obj) {
        Settings s;
        s.theme = obj["theme"].toInt();
        s.confirmBeforeDelete = obj["confirmBeforeDelete"].toBool();
        s.defaultLanguage = obj["defaultLanguage"].toString();
        s.defaultSortMethod = obj["defaultSortMethod"].toString();

        return s;
    }
};
