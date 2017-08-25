CREATE TABLE user (
    "user_hash" text NOT NULL PRIMARY KEY,
    "databaseConnectionString" text NOT NULL,
    "password" text NOT NULL,
    "storageConnectionString" text NOT NULL,
    "username" text NOT NULL
);

