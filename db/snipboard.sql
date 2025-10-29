--schema
create table Tag(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    dateCreated DATE DEFAULT CURRENT_TIMESTAMP,
    dateModified DATE DEFAULT 0,
    userCreated BOOLEAN DEAFULT TRUE 
);

create table Folder(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    dateCreated DATE DEFAULT CURRENT_TIMESTAMP,
    dateModified DATE DEFAULT 0,
    parentFolder INTEGER, --only parent is needed because children can be found by searching folders where the parentFolderID is equal to the parent folder
    FOREIGN KEY (parentFolder) REFERENCES Folder(ID)
);

create table Snippet(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    dateCreated DATE DEFAULT CURRENT_TIMESTAMP,
    dateModified DATE DEFAULT 0,
    description TEXT,
    language TEXT,
    contents TEXT,
    folder INTEGER,
    favorite BOOLEAN NOT NULL DEFAULT FALSE,
    timesCopied UNISIGNED INTEGER DEFAULT 0,
    FOREIGN KEY (folder) REFERENCES Folder(id)
);

CREATE TABLE SnippetTagLink ( --table to create a many-to-many relationship between snippets and tags
    snippetId INTEGER,
    tagId INTEGER,
    FOREIGN KEY (snippetId) REFERENCES Snippet(id),
    FOREIGN KEY (tagId) REFERENCES Tag(id)
);

--default tags
WITH data (name) AS (
    VALUES
        ('Recursive'),
        ('Iterative'),
        ('Search Algorithm'),
        ('Sorting Algorithm'),
        ('Data Structure'),
        ('String Manipulation'),
        ('File Handling'),
        ('Database Query'),
        ('API Request'),
        ('Authentication'),
        ('Error Handling'),
        ('Test Cases'),
        ('Logging'),
        ('Parsing'),
        ('Serialization'),
        ('Encryption'),
        ('Input Validation'),
        ('Web Development'),
        ('Front End'),
        ('Back End'),
        ('Full Stack'),
        ('Web Developemnt'),
        ('Mobile Development'),
        ('Desktop'),
        ('Dev Ops'),
        ('Cloud'),
        ('Command'),
        ('Script'),
        ('Class'),
        ('Class Definition'),
        ('IO')
)   
INSERT INTO Tag (name, userCreated)
SELECT name, FALSE FROM data;

--test data
INSERT INTO Folder(name)
VALUES 
    ('Main'),
    ('Class Work');

--children folders
INSERT INTO Folder(name, parentFolder)
VALUES 
    ('CS 2400', 2),
    ('CS 2401', 2);

--snippets
INSERT INTO Snippet(name, description, language, contents, folder, favorite)
VALUES
    ('Hello World', 
    'Simple C++ hello world program.', 
    'C++', 
    '#include <iostream>

using namespace std;

int main(){
    cout << "Hello, World!";
}',  
    1, 
    TRUE);
--relate snippets to tags
INSERT INTO SnippetTagLink (snippetId, tagId)
VALUES
    (1, 31),
    (1, 1),
    (1, 3);

INSERT INTO Snippet(name, description, language, contents, folder, favorite)
VALUES
    ('Calculator', 
    'Simple C++ addition calculator.', 
    'C++', 
    '#include <iostream>

using namespace std;

int main(){
    int a = 1;
    int b = 2;
    cout << a + b;
}',  
    3, 
    FALSE);

INSERT INTO SnippetTagLink (snippetId, tagId)
VALUES
    (2, 31),
    (2, 9),
    (2, 13);