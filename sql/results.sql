USE quizapp;

SELECT s.student_id, s.name, q.title, a.score, a.total, a.started_at, a.submitted_at
FROM attempts a
JOIN students s ON s.student_id = a.student_id
JOIN quizzes  q ON q.quiz_id    = a.quiz_id
ORDER BY q.title, a.score DESC;