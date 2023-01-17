CREATE SCHEMA student_attendance_db;

CREATE TABLE table_persons
(
    person_id  VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    first_name TEXT         NOT NULL,
    last_name  TEXT         NOT NULL,
    patronymic TEXT         NULL
);

CREATE TABLE table_faculties
(
    faculty_id VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    name       TEXT         NOT NULL
);

CREATE TABLE table_groups
(
    group_id   VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    name       TEXT         NOT NULL,
    faculty_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES table_faculties (faculty_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE table_students
(
    student_id VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    person_id  VARCHAR(255) NOT NULL,
    group_id   VARCHAR(255) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES table_persons (person_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (group_id) REFERENCES table_groups (group_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE table_teachers
(
    teacher_id VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    person_id  VARCHAR(255) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES table_persons (person_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE table_subjects
(
    subject_id VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    name       TEXT         NOT NULL
);

CREATE TABLE table_connections_subject_group_teacher
(
    id         VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    subject_id VARCHAR(255) NOT NULL,
    group_id   VARCHAR(255) NOT NULL,
    teacher_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES table_subjects (subject_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (group_id) REFERENCES table_groups (group_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (teacher_id) REFERENCES table_teachers (teacher_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE table_attendance_statuses
(
    attendance_status_id VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    status               TEXT         NOT NULL
);

CREATE TABLE table_attendance_log
(
    id                   VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'UUID',
    date_time            DATETIME     NOT NULL             DEFAULT NOW(),
    teacher_id           VARCHAR(255) NOT NULL,
    subject_id           VARCHAR(255) NOT NULL,
    student_id           VARCHAR(255) NOT NULL,
    attendance_status_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES table_teachers (teacher_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (subject_id) REFERENCES table_subjects (subject_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (student_id) REFERENCES table_students (student_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    FOREIGN KEY (attendance_status_id) REFERENCES table_attendance_statuses (attendance_status_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
