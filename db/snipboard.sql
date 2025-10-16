create table Tag(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    dateCreated DATE DEFAULT CURRENT_TIMESTAMP,
    showDate BOOLEAN DEAFULT TRUE --allow the ability to not show the date created on default/non user created tags
);

create table Folder(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    dateCreated DATE DEFAULT CURRENT_TIMESTAMP,
    parentFolder INTEGER, --only parent is needed because children can be found by searching folders where the parentFolderID is equal to the parent folder
    FOREIGN KEY (parentFolder) REFERENCES Folder(ID)
);

create table Snippet(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    dateCreated DATE DEFAULT CURRENT_TIMESTAMP,
    description TEXT,
    language TEXT,
    tags INTEGER,
    folder INTEGER,
    favorite BOOLEAN NOT NULL DEFAULT FALSE,
    timesCopied UNISIGNED INTEGER DEFAULT 0,
    FOREIGN KEY (tags) REFERENCES Tag(id),
    FOREIGN KEY (folder) REFERENCES Folder(id)
);

--default tags
WITH data (name) AS (
    VALUES
        ("Recursive"),
        ("Iterative"),
        ("Search"),
        ("Sort")
)   
INSERT INTO Tag (name, showDate)
SELECT name, FALSE FROM data;