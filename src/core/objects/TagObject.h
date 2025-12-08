/**
 *        @file: TagObject.h
 *      @author: Kyle Carey
 *        @date: October 19, 2025
 *       @brief: Tag Object to be exposed to the QML.
 *               This is a read/write only object with properties accessible using the Q_PROPERTY definitions
 *               ex. if the name is displayed in QML, then the function name() is called. or, if it is changed in a text box, then setName() is called
 *               This can be thought of as a simple struct for QML. Nothing significant happens here besides syntactical sugar for QML to understand
 */

#pragma once

#include <../models/Tag.h>

#include <QObject>
#include <QString>
#include <QVector>

class TagObject : public QObject {
    // Set QML Properties
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool showDate READ showDate WRITE setShowDate NOTIFY showDateChanged)
    Q_PROPERTY(bool checked READ checked WRITE setChecked NOTIFY checkedChanged)

 public:
    explicit TagObject(QObject* parent = nullptr) : QObject(parent) {}
    explicit TagObject(const Tag& tagModel, QObject* parent = nullptr);

    // Getters (for QML)
    int id() const { return m_id; }
    QString name() const { return m_name; }
    bool showDate() const { return m_showDate; }
    bool checked() const { return m_checked; }

    // Setters (for QML)
    void setId(int id);
    void setName(QString name);
    void setShowDate(bool showDate);
    void setChecked(bool checked);

 signals:
    // Tells the UI to update specified property (across app) whenever one of these are called
    void idChanged();
    void nameChanged();
    void showDateChanged();
    void checkedChanged();

 private:
    int m_id = -1;
    QString m_name;
    bool m_showDate = true;
    bool m_checked = false;
};