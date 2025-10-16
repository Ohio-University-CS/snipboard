/**
 *        @file: tag.h
 *      @author: Kyle Carey
 *        @date: October 15, 2025
 *       @brief: Tag model
 */

#ifndef TAG_H
#define TAG_H

#include <string>

class Tag {
 public:
    /**
     * @brief  initializes id to -1, name to "", and dateCreated to ""
     *
     */
    Tag() : id(-1), name(""), dateCreated("") {}
    
    /**
     * @brief  initializes id to -1, name to newName, dateCreated to ""
     *
     * @param newName  name of the tag
     */
    Tag(const std::string& newName) : id(-1), name(newName), dateCreated("") {}

    /**
     * @brief  initializes id to newId, name to newName, dateCreated to ""
     *
     * @param newId  id of the tag
     * @param newName  name of the tag
     */
    Tag(const int& newId, const std::string& newName) : id(newId), name(newName), dateCreated("") {}
    
    /**
     * @brief  initializes id to newId, name to newName, dateCreated to newDate
     *
     * @param newId  id of tag
     * @param newName  name of tag
     * @param newDate  dateCreated of the tag
     */
    Tag(const int& newId, const std::string& newName, const std::string& newDate) : id(newId), name(newName), dateCreated(newDate) {}

    /**
     * @brief  does not throw an exception. will return -1 if no id is assigned
     *
     * @return  id of the tag
     */
    int getId() const noexcept { return id; }

    /**
     * @brief  does not throw an exception. name will be empty string if it does not have one
     *
     * @return  const reference to the name
     */
    const std::string& getName() const noexcept { return name; }

    /**
     * @brief  does not throw an exception. date will be an empty string if there is no creation date
     *
     * @return  const reference to the dateCreated
     */
    const std::string& getDateCreated() const noexcept { return dateCreated; }

    /**
     * @brief  does not throw an exception. sets the tag id to specified id
     *
     * @param newId  id to set
     */
    void setId(const int& newId) noexcept { id = newId; }

    /**
     * @brief  does not throw an exception. sets the name to specified name
     *
     * @param newname  name to set
     */
    void setName(const std::string& newName) noexcept { name = newName; }

    /**
     * @brief  does not throw an exception. sets the dateCreated to specified date (in string form)
     *
     * @param newDate  dateCreated to set
     */
    void setDateCreated(const std::string& newDate) noexcept { dateCreated = newDate; }
    
 private:
    int id;
    std::string name;
    std::string dateCreated;
};

#endif