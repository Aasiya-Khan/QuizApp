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