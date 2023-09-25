-- creating worker table
CREATE TABLE worker (
    ID IDENTITY NOT NULL PRIMARY KEY,
    NAME VARCHAR NOT NULL,
    BIRTHDAY TIMESTAMP NOT NULL,
    LEVEL varchar NOT NULL,
    SALARY INT NOT NULL
);

/* 
    define constaints for worker table columns:
    NAME - must have length within [2, 1000]
    BIRTHDAY - must starts with 1900 year
    LEVEL - must be enumerated (Trainee, Junior, Middle, Senior)
    SALARY - must be within [100, 100_000]
*/
ALTER TABLE worker ADD CONSTRAINT WORKER_NAME_CONSTRAINT
CHECK(
    CHAR_LENGTH(NAME) >= 2 AND CHAR_LENGTH(NAME) <= 1000
);

ALTER TABLE worker ADD CONSTRAINT WORKER_BIRTHDAY_CONSTRAINT
CHECK(
    YEAR(BIRTHDAY) >= 1900
);

ALTER TABLE worker ADD CONSTRAINT WORKER_LEVEL_CONSTRAINT
CHECK(
    LEVEL IN ('Trainee', 'Junior', 'Middle', 'Senior')
);

ALTER TABLE worker ADD CONSTRAINT WORKER_SALARY_CONSTRAINT
CHECK(
    SALARY >= 100 AND SALARY <= 100000
);

-- creating client table
CREATE TABLE client (
    ID IDENTITY NOT NULL PRIMARY KEY,
    NAME VARCHAR NOT NULL,
);

/* 
    define constaints for client table columns:
    NAME - must have length within [2, 1000]
*/

ALTER TABLE client ADD CONSTRAINT CLIENT_NAME_CONSTRAINT
CHECK(
    CHAR_LENGTH(NAME) >= 2 AND CHAR_LENGTH(NAME) <= 1000
);

-- creating project table
CREATE TABLE project (
    ID IDENTITY NOT NULL PRIMARY KEY,
    CLIENT_ID BIGINT NOT NULL,
    START_DATE TIMESTAMP NOT NULL,
    FINISH_DATE TIMESTAMP NOT NULL
);

-- creating project_worker table
CREATE TABLE project_worker (
    PROJECT_ID BIGINT NOT NULL, 
    FOREIGN KEY(PROJECT_ID) REFERENCES project(ID),
    WORKER_ID BIGINT NOT NULL, 
    FOREIGN KEY(WORKER_ID) REFERENCES worker(ID),
    PRIMARY KEY(WORKER_ID, PROJECT_ID)
);