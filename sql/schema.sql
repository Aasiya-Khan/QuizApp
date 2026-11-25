-- QuizApp database schema
CREATE DATABASE IF NOT EXISTS quizapp;
USE quizapp;

-- Remove old tables (children first, parents last)
DROP TABLE IF EXISTS attempts;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS quizzes;

-- One row per test
CREATE TABLE quizzes (
    quiz_id          INT AUTO_INCREMENT PRIMARY KEY,
    title            VARCHAR(100) NOT NULL,
    topic            VARCHAR(50),
    opens_at         DATETIME NOT NULL,
    closes_at        DATETIME NOT NULL,
    duration_minutes INT NOT NULL DEFAULT 30,
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- One row per question; each belongs to one quiz
CREATE TABLE questions (
    question_id    INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id        INT NOT NULL,
    question_text  VARCHAR(500) NOT NULL,
    option_a       VARCHAR(200) NOT NULL,
    option_b       VARCHAR(200) NOT NULL,
    option_c       VARCHAR(200) NOT NULL,
    option_d       VARCHAR(200) NOT NULL,
    correct_option CHAR(1) NOT NULL CHECK (correct_option IN ('A','B','C','D')),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id) ON DELETE CASCADE
);
-- The class list
CREATE TABLE students (
    student_id VARCHAR(20) PRIMARY KEY,
    name       VARCHAR(100) NOT NULL
);

-- One row per student per test
CREATE TABLE attempts (
    attempt_id   INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id      INT NOT NULL,
    student_id   VARCHAR(20) NOT NULL,
    score        INT,
    total        INT,
    started_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    submitted_at DATETIME,
    FOREIGN KEY (quiz_id)    REFERENCES quizzes(quiz_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    UNIQUE (quiz_id, student_id)
);