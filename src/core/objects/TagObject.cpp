/**
 *        @file: TagObject.cpp
 *      @author: Kyle Carey
 *        @date: October 19, 2025
 *       @brief: Implementations for TagObject constructor and setters
 *               To note: returning instantly if no change happens is for efficiency (so UI does not update)
*/


#include "TagObject.h"

TagObject::TagObject(const Tag& tagModel, QObject* parent) : QObject(parent) {
    m_id = tagModel.id;
    m_name = tagModel.name;
    m_showDate = tagModel.showDate;
}

void TagObject::setId(int id) {
    if (m_id == id) {
        return;
    }

    m_id = id;
    emit idChanged();
}

void TagObject::setName(QString name) {
    if (m_name == name) {
        return;
    }

    m_name = name;
    emit nameChanged();
}

void TagObject::setShowDate(bool showDate) {
    if (m_showDate == showDate) {
        return;
    }

    m_showDate = showDate;
    emit showDateChanged();
}