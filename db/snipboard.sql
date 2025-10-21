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
    data TEXT,
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
        ("Search Algorithm"),
        ("Sorting Algorithm"),
        ("Data Structure"),
        ("String Manipulation"),
        ("File Handling"),
        ("Database Query"),
        ("API Request"),
        ("Authentication"),
        ("Error Handling"),
        ("Test Cases"),
        ("Logging"),
        ("Parsing"),
        ("Serialization"),
        ("Encryption"),
        ("Input Validation"),
        ("Web Development"),
        ("Front End"),
        ("Back End"),
        ("Full Stack"),
        ("Web Developemnt"),
        ("Mobile Development"),
        ("Desktop"),
        ("Dev Ops"),
        ("Cloud"),
        ("Command"),
        ("Script"),
        ("Class"),
        ("Class Definition")
)   
INSERT INTO Tag (name, userCreated)
SELECT name, FALSE FROM data;

--test data
