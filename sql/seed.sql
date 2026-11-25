USE quizapp;

-- Class list
INSERT INTO students (student_id, name) VALUES
    ('S101', 'Ali'),
    ('S102', 'Sara'),
    ('S103', 'Ravi');

-- Tests: open now / opens tomorrow / already closed
INSERT INTO quizzes (title, topic, opens_at, closes_at, duration_minutes) VALUES
    ('Java Basics', 'Java',    NOW() - INTERVAL 1 HOUR, NOW() + INTERVAL 7 DAY, 30),
    ('SQL Basics',  'SQL',     NOW() + INTERVAL 1 DAY,  NOW() + INTERVAL 2 DAY, 30),
    ('Old Test',    'General', NOW() - INTERVAL 3 DAY,  NOW() - INTERVAL 2 DAY, 30);

-- Questions for quiz 1 (Java Basics)
INSERT INTO questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
    (1, 'What does the keyword new do?', 'Deletes an object', 'Creates an object', 'Starts a loop', 'Prints text', 'B'),
    (1, 'Which type stores whole numbers?', 'String', 'boolean', 'int', 'double', 'C'),
    (1, 'Which method runs first in a Java app?', 'start()', 'run()', 'init()', 'main()', 'D');

-- Questions for quiz 2 (SQL Basics)
INSERT INTO questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
    (2, 'Which command reads rows?', 'SELECT', 'INSERT', 'DROP', 'CREATE', 'A'),
    (2, 'What does a PRIMARY KEY do?', 'Sorts rows', 'Uniquely identifies a row', 'Deletes rows', 'Joins tables', 'B');