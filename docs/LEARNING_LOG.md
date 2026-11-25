# Learning Log

## S1-01 · Create Maven project (25 Nov)
- **Did:** created a Maven project with pom.xml, src folders and Main.java.
- **Why:** Maven gives a standard folder layout and manages libraries via pom.xml.
- **Learned:** package name must match the folder path; target/ holds compiled .class files and is not committed.

## S1-02 · Database schema (26 Nov)
- **Did:** wrote sql/schema.sql with quizzes, questions, students, attempts.
- **Why:** one file rebuilds the same database anywhere.
- **Learned:** (Why drop questions before quizzes? questions point to quizzes through the FK. MySQL won't delete a parent while children still point to it, so children go first.
  What happens if quiz 1 is deleted? Its questions are deleted automatically, because of ON DELETE CASCADE on the foreign key.
  What does MySQL do with 'E'? It refuses the insert with an error, because of the CHECK (correct_option IN ('A','B','C','D')) rule.)

## s103
Step 4: seed.sql, the teacher's test data

What and why

"Seed" means starter data: sample students, tests and questions.
In the core version, this file is the teacher's "create test" screen.
Layer: database (teacher admin).
The trick: times use NOW() so they're always relative to today, which gives us test cases:
quiz 1 open (all week, so you can test any evening)
quiz 2 opens tomorrow
quiz 3 already closed

## s104
What and why

In the core version, this file is the teacher's results screen. It's FR-02.
attempts only stores IDs (quiz_id = 1, student_id = 'S101'). A JOIN looks up the matching name and title in the other tables, like matching locker numbers across notebooks.
attempts a: a is a nickname (alias) for the table, so you can write a.score instead of attempts.score.
JOIN students s ON s.student_id = a.student_id: for each attempt, find the student whose ID matches, and put their columns on the same row.
The second JOIN does the same for the quiz title.
ORDER BY q.title, a.score DESC: group by test, highest score first. DESC means descending.

In Duplicate entry '1-S101', 1 is quiz_id and S101 is student_id. MySQL shows the pair that already exists: student S101 has already attempted quiz 1.
Without the JOIN, the teacher sees only IDs, like S102 | 1 | 3 | 3, instead of "Sara | Java Basics | 3/3". The JOIN looks up the name and title using those IDs.


## s105

what a dependency is, and why JUnit has test scope.
Until now you've used MySQL from Terminal. Next, Java must talk to MySQL.
Java can't do that alone. It needs a driver: a translator library between Java and MySQL. It's called MySQL Connector/J.
JUnit is the testing library, used for Sprint 2's rule tests.
A dependency is a library your project depends on. You list it in the pom, and Maven downloads it.
Layer: none yet. This is toolbox setup.

## s106

Step 7: Java connects to MySQL (db.properties + DBConnection)

What and why

db.properties is the address card for the storeroom: where it is, which door, and the key (user and password). It's kept out of Git.
DBConnection is the storeroom key. Every DAO (clerk) asks it for a connection before running SQL.
Layer: util (helper code shared by all DAOs).
Host and port are separate settings on purpose: in Sprint 3 the student's Server IP box just replaces db.host.